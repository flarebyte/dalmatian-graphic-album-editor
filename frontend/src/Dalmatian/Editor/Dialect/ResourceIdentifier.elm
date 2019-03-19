module Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId(..), toString, fromString, parser, getInvalidResourceId)

import Parser exposing ((|.), (|=), Parser, andThen, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, problem)
import Set
import Dalmatian.Editor.Dialect.Separator as Separator
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)

type ResourceId
    = ResId String String -- curie path
    | FullResId String
    | InvalidResourceId Failure

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

urlish = variable { start = Char.isAlphaNum
        , inner = \c -> Char.isAlphaNum c || c == '_' || c == '-' || c == '/' || c == '.'
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
        |= urlish  
        |. symbol ">"
    ]

fromString : String -> ResourceId
fromString str =
    case run parser str of
        Ok id ->
            id
        
        Err msg ->
           InvalidResourceId (Failing.fromDeadEndList msg str)

