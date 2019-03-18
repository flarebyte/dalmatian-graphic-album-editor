module Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId(..), toString, fromString, parser, isInvalid)

import Parser exposing ((|.), (|=), Parser, andThen, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, problem)
import Set
import Dalmatian.Editor.Dialect.Separator as Separator

type ResourceId
    = ResId String String -- curie path
    | FullResId String
    | InvalidResourceId String

toString : ResourceId -> String
toString id =
    case id of
        FullResId str ->
            "<" ++ str ++ ">"

        ResId curie path ->
           curie ++ ":" ++ path

        InvalidResourceId str->
            "invalid-resource-id"

isInvalid : ResourceId -> Bool
isInvalid id =
    case id of
       InvalidResourceId str -> True
       _ -> False

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
        problem "The path should be less than 300 characters long"

checkCurie : String -> Parser String
checkCurie value =
      if String.length value <= 30 then
        succeed value
      else
        problem "The curie should be less than 30 characters long"

parser : Parser ResourceId
parser =
  oneOf
    [succeed ResId
        |= extractCurie
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
           InvalidResourceId str

