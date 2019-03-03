module Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId(..), toString, fromString, parser)

import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol)
import Set

type ResourceId
    = ResId String String -- curie path
    | FullResId String
    | InvalidResourceId String

toString : ResourceId -> String
toString id =
    case id of
        FullResId str ->
            str

        ResId curie path ->
           curie ++ ":" ++ path

        InvalidResourceId str->
            "invalid-resource-id"

-- Ideally we would like to support Internationalized IRI with possible non latin characters;
-- However, in this case validation will become tricky or pointless, and in practice, we have a controlled vocabulary..for now at least ..

curiesh = variable { start = Char.isAlphaNum
        , inner = \c -> Char.isAlphaNum c
        , reserved = Set.empty
        }

urlish = variable { start = Char.isAlphaNum
        , inner = \c -> Char.isAlphaNum c || c == '_' || c == '-' || c == '/' || c == '.'
        , reserved = Set.empty
        }          
parser : Parser ResourceId
parser =
  oneOf
    [succeed ResId
        |.spaces
        |= curiesh
        |. symbol ":"
        |= urlish
        |.spaces
    , succeed FullResId
        |.spaces
        |. symbol "<"
        |= urlish  
        |. symbol ">"
        |.spaces
    ]

fromString : String -> ResourceId
fromString str =
    case run parser str of
        Ok id ->
            id

        Err msg ->
           InvalidResourceId str

