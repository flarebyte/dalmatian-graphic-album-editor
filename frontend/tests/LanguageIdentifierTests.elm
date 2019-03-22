module LanguageIdentifierTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.LanguageIdentifier as LanguageIdentifier exposing (LanguageId, createLanguage, createLanguageAndCountry)
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)
import Fuzzing exposing (alpha, corruptedAlpha)

longPrefix = String.repeat 100 "a"

suite : Test
suite =
    describe "The LanguageIdentifier Module"
    [
        describe "fromString"
        [
            fuzz alpha "should support LangId" <|
                \lang ->
                    LanguageIdentifier.fromString (LanguageIdentifier.toString (createLanguage lang))
                        |> Expect.equal (createLanguage lang)

            , fuzz2 alpha alpha "should support LangCountryId" <|
                \lang country->
                    LanguageIdentifier.fromString (LanguageIdentifier.toString (createLanguageAndCountry lang country))
                        |> Expect.equal (createLanguageAndCountry lang country)

            , fuzz corruptedAlpha "should reject corrupted LangId" <|
                \lang ->
                    LanguageIdentifier.fromString (LanguageIdentifier.toString (createLanguage lang))
                    |>LanguageIdentifier.getInvalidLanguageId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
            
            , fuzz alpha "should reject very long LanguageIdentifier" <|
                \lang ->
                    LanguageIdentifier.fromString (LanguageIdentifier.toString (longPrefix ++ lang |> createLanguage))
                        |>LanguageIdentifier.getInvalidLanguageId |> Maybe.map .kind |> Expect.equal (Just InvalidLengthFailure)

            , test "should reject empty string" <|
                \_ ->
                    LanguageIdentifier.fromString (LanguageIdentifier.toString (createLanguage ""))
                        |>LanguageIdentifier.getInvalidLanguageId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
                    ]

    ]
