module FieldPersistenceTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..))
import Dalmatian.Editor.Version as Version exposing (SemanticVersion)
import Dalmatian.Editor.FieldPersistence exposing (FieldValue(..), isValidFieldValue, toStringFieldValue)


createVersion: Int -> Int -> Int -> String
createVersion a b c =
    (String.fromInt a) ++ "." ++ (String.fromInt b ) ++ "." ++ (String.fromInt c)

createDimension: List Int -> String
createDimension list =
    list |> List.map String.fromInt |> String.join ","

englishText = { language = "en", text = "Once upon a time" }
frenchText = { language = "fr", text = "Il etait une fois" }

suite : Test
suite =
    describe "The Field Persistence Module"
    [
        describe "toStringFieldValue"
        [
            fuzz3 (intRange 0 1000) (intRange 0 100000) (intRange 0 100000) "should support valid version" <|
                \a b c ->
                    toStringFieldValue VersionType "en" 0 (createVersion a b c) (VersionValue (SemanticVersion 1 1 0))
                        |> Expect.equal (VersionValue (SemanticVersion a b c))

            , fuzz string "should reject invalid version" <|
                \newStr ->
                    toStringFieldValue VersionType "en" 0 newStr (VersionValue (SemanticVersion 1 1 0))
                        |> isValidFieldValue
                        |> Expect.equal False
            
            , fuzz2 (intRange 0 1000) (intRange 0 1000) "should support valid Dimension2DIntType" <|
                \a b ->
                    toStringFieldValue Dimension2DIntType "en" 0 (createDimension [a, b]) (Dimension2DIntValue {width = 0, height = 0})
                        |> Expect.equal (Dimension2DIntValue {width = a, height = b})
            
            , fuzz string "should reject invalid Dimension2DIntType" <|
                \newStr ->
                    toStringFieldValue Dimension2DIntType "en" 0 newStr (Dimension2DIntValue {width = 0, height = 0})
                        |> isValidFieldValue
                        |> Expect.equal False
            
            , fuzz string "should insert valid ShortLocalizedListType" <|
                \newStr ->
                    toStringFieldValue ShortLocalizedListType "it" 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = "it"}, englishText])
           
           , fuzz string "should update valid ShortLocalizedListType" <|
                \newStr ->
                    toStringFieldValue ShortLocalizedListType "en" 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = "en"}])
            
            , fuzz string "should insert valid MediumLocalizedType" <|
                \newStr ->
                    toStringFieldValue MediumLocalizedType "it" 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = "it"}, englishText])
           
            , fuzz string "should insert valid TextAreaLocalizedType" <|
                \newStr ->
                    toStringFieldValue TextAreaLocalizedType "it" 0 newStr (LocalizedListValue [englishText])
                        |> Expect.equal (LocalizedListValue [{text= newStr, language = "it"}, englishText])
            
            , fuzz string "should insert valid UrlListType" <|
                \newStr ->
                    toStringFieldValue UrlListType "en" 0 newStr (UrlListValue ["http://some-url.com"])
                        |> Expect.equal (UrlListValue [newStr, "http://some-url.com"])
           

        ]
    ]
