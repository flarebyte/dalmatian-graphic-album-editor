module Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId(..), toString, fromString, parser)

import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol)
import Set

type LanguageId
    = LangId String -- language
    | LangCountryId String String -- language country
    | InvalidLanguageId String

toString : LanguageId -> String
toString id =
    case id of
        LangId lang ->
            lang
        
        LangCountryId lang country ->
            lang ++ "_" ++ country

        InvalidLanguageId str->
            "invalid-language-id"

langValidator = variable { start = Char.isLower
        , inner = \c -> Char.isLower c
        , reserved = Set.empty
        }

countryValidator = variable { start = Char.isUpper
        , inner = \c -> Char.isUpper c
        , reserved = Set.empty
        }

parser : Parser LanguageId
parser =
  oneOf
    [succeed LangId
        |.spaces
        |= langValidator
        |.spaces
    , succeed LangCountryId
        |.spaces
        |= langValidator
        |. symbol "_"
        |= countryValidator
        |.spaces
    ]

fromString : String -> LanguageId
fromString str =
    case run parser str of
        Ok id ->
            id

        Err msg ->
           InvalidLanguageId str

