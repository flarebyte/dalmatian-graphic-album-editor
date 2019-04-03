module FieldPersistenceTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..))
import Dalmatian.Editor.FieldPersistence exposing (FieldValue(..), toStringFieldValue)
import Dalmatian.Editor.Dialect.LanguageIdentifier as LanguageIdentifier exposing (LanguageId)

en = LanguageIdentifier.createLanguage "en"
fr = LanguageIdentifier.createLanguage "fr"
it = LanguageIdentifier.createLanguage "it"

createVersion: Int -> Int -> Int -> String
createVersion a b c =
    (String.fromInt a) ++ "." ++ (String.fromInt b ) ++ "." ++ (String.fromInt c)

createDimension: List Int -> String
createDimension list =
    list |> List.map String.fromInt |> String.join ","

englishText = { language = en, text = "Once upon a time" }
frenchText = { language = fr, text = "Il etait une fois" }

suite : Test
suite =
    describe "The Field Persistence Module"
    [
        describe "toStringFieldValue"
        [
            fuzz string "should insert valid ShortLocalizedListType" <|
                \newStr ->
                    toStringFieldValue ShortLocalizedListType it 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = it}, englishText])
           
           , fuzz string "should update valid ShortLocalizedListType" <|
                \newStr ->
                    toStringFieldValue ShortLocalizedListType en 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = en}])
            
            , fuzz string "should insert valid MediumLocalizedType" <|
                \newStr ->
                    toStringFieldValue MediumLocalizedType it 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = it}, englishText])
           
            , fuzz string "should insert valid TextAreaLocalizedType" <|
                \newStr ->
                    toStringFieldValue TextAreaLocalizedType it 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = it}, englishText])
            
            , fuzz string "should insert valid UrlListType" <|
                \newStr ->
                    toStringFieldValue UrlListType en 0 newStr (UrlListValue ["http://some-url.com"])
                        |> Expect.equal (UrlListValue [newStr, "http://some-url.com"])
           

        ]
    ]
