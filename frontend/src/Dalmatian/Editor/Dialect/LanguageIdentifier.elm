module Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId, toString, fromString, parser, getInvalidLanguageId, createLanguage, createLanguageAndCountry)

import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, keyword, problem, andThen, sequence, Step(..), Trailing(..), loop)
import Set
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)
import Dalmatian.Editor.Dialect.Separator as Separator

type LanguageId
    = LangId String -- language
    | LangCountryId String String -- language country
    | InvalidLanguageId Failure

createLanguage: String -> LanguageId
createLanguage lang =
    lang |> String.toLower |> LangId

createLanguageAndCountry: String -> String -> LanguageId
createLanguageAndCountry lang country =
    LangCountryId (lang |> String.toLower) (country |> String.toUpper)

toString : LanguageId -> String
toString id =
    case id of
        LangId lang ->
            "L=" ++ (lang |> String.toLower)
        
        LangCountryId lang country ->
            "LC=" ++ (lang |> String.toLower) ++ "-" ++ (country |> String.toUpper)

        InvalidLanguageId failure ->
           failure.message

getInvalidLanguageId: LanguageId -> Maybe Failure
getInvalidLanguageId languageId =
    case languageId of
        InvalidLanguageId failure ->
            Just failure
        otherwise ->
            Nothing

extractLang = variable { start = Char.isAlpha
        , inner = \c -> Char.isAlpha c
        , reserved = Set.empty
        }

extractCountry = variable { start = Char.isAlpha
        , inner = \c -> Char.isAlpha c
        , reserved = Set.empty
        }

checkLang : String -> Parser String
checkLang value =
      if String.length value <= 30 then
        succeed value
      else
        Failing.createMessage InvalidLengthFailure "The language should be less than 30 characters long" |> problem

checkCountry : String -> Parser String
checkCountry value =
      if String.length value <= 30 then
        succeed value
      else
        Failing.createMessage InvalidLengthFailure "The country should be less than 30 characters long" |> problem

parser : Parser LanguageId
parser =
  oneOf
    [succeed LangCountryId
        |.keyword "LC"
        |.symbol "="
        |= (extractLang |> andThen checkLang)
        |. symbol "-"
        |= (extractCountry |> andThen checkCountry)
        |. Separator.space
    , succeed LangId
        |.keyword "L"
        |.symbol "="
        |= (extractLang |> andThen checkLang)
        |. Separator.space
    ]

fromString : String -> LanguageId
fromString str =
    case run parser str of
        Ok id ->
            id

        Err msg ->
            InvalidLanguageId (Failing.fromDeadEndList msg str)
