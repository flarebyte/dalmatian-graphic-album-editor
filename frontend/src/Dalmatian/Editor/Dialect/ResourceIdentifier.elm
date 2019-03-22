module Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId, toString, fromString, parser, getInvalidResourceId, create, createByUrl)

import Parser exposing ((|.), (|=), Parser, andThen, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, problem)
import Set
import Dalmatian.Editor.Dialect.Separator as Separator
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)

type ResourceId
    = ResId String String -- curie path
    | FullResId String
    | InvalidResourceId Failure

createByUrl: String ->  ResourceId
createByUrl value =
    if String.length value > 300 then
        Failing.create value InvalidLengthFailure "The url should be less than 300 characters long" |> InvalidResourceId
    else if not (String.startsWith "http://" value || String.startsWith "https://" value) then
        Failing.create value InvalidFormatFailure "An url must start by http:// or https://" |> InvalidResourceId
    else if value |> String.dropLeft 7 |> String.contains ":" then
        Failing.create value InvalidFormatFailure "The url must not contain any colon " |> InvalidResourceId
    else
        FullResId value

create: String -> String ->  ResourceId
create curie path =
    if String.length curie > 30 then
        Failing.create curie InvalidLengthFailure "The curie should be less than 30 characters long" |> InvalidResourceId
    else if String.length path > 300 then
        Failing.create path InvalidLengthFailure "The path should be less than 300 characters long" |> InvalidResourceId
    else
        ResId curie path

toString : ResourceId -> String
toString id =
    case id of
        FullResId str ->
            "<" ++ str ++ ">"

        ResId curie path ->
           curie ++ ":" ++ path

        InvalidResourceId failure ->
           failure.message

getInvalidResourceId: ResourceId -> Maybe Failure
getInvalidResourceId resourceId =
    case resourceId of
        InvalidResourceId failure ->
            Just failure
        otherwise ->
            Nothing
        
-- Ideally we would like to support Internationalized IRI with possible non latin characters;
-- However, in this case validation will become tricky or pointless, and in practice, we have a controlled vocabulary..for now at least ..

extractCurie = variable { start = Char.isAlphaNum
        , inner = \c -> Char.isAlphaNum c
        , reserved = Set.fromList ["http", "https", "id", "iid"]
        }

extractUrl = variable { start = Char.isAlpha
        , inner = \c -> Char.isAlphaNum c || c == '_' || c == '-' || c == '/' || c == '.' || c == ':'
        , reserved = Set.empty
        }

extractPath = variable { start = Char.isAlphaNum
        , inner = \c -> Char.isAlphaNum c || c == '_' || c == '-' || c == '/' || c == '.'
        , reserved = Set.empty
        }

checkPath : String -> Parser String
checkPath value =
      if String.length value <= 300 then
        succeed value
      else
        Failing.createMessage InvalidLengthFailure "The path should be less than 300 characters long" |> problem

checkCurie : String -> Parser String
checkCurie value =
      if String.length value <= 30 then
        succeed value
      else
        Failing.createMessage InvalidLengthFailure "The curie should be less than 30 characters long" |> problem

checkUrl : String -> Parser String
checkUrl value =
      if String.length value > 300 then
        Failing.createMessage InvalidLengthFailure "The url should be less than 300 characters long" |> problem
      else if not (String.startsWith "http://" value || String.startsWith "https://" value) then
        Failing.createMessage InvalidFormatFailure "An url must start by http:// or https://" |> problem
      else if value |> String.dropLeft 7 |> String.contains ":" then
        Failing.createMessage InvalidFormatFailure "The url must not contain any colon " |> problem
      else
        succeed value

parser : Parser ResourceId
parser =
  oneOf
    [succeed ResId
        |= (extractCurie |> andThen checkCurie)
        |. symbol ":"
        |= (extractPath |> andThen checkPath)
        |. Separator.space
    , succeed FullResId
        |. symbol "<"
        |= (extractUrl|> andThen checkUrl)  
        |. symbol ">"
    ]

fromString : String -> ResourceId
fromString str =
    case run parser str of
        Ok id ->
            id
        
        Err msg ->
           InvalidResourceId (Failing.fromDeadEndList msg str)

