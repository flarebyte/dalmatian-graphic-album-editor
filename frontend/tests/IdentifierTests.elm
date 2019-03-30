module IdentifierTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.Identifier as Identifier exposing (Id)
import Fuzzing exposing (identifier, corruptedIdentifier, positiveNumber)
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)

longPrefix = String.repeat 100 "a"

suite : Test
suite =
    describe "The Identifier Module"
    [
        describe "fromString"
        [
            fuzz positiveNumber "should support IntId" <|
                \a ->
                    Identifier.fromString (Identifier.toString (Identifier.createInt a))
                        |> Expect.equal (Identifier.createInt a)
            , fuzz positiveNumber "should reject negative number" <|
                \a ->
                    Identifier.fromString ("iid:-" ++ String.fromInt a)
                        |>Identifier.getInvalidId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
        
            , fuzz identifier "should support StringId" <|
                \str ->
                    Identifier.fromString (Identifier.toString (Identifier.create str))
                        |> Expect.equal (Identifier.create str)

            , fuzz corruptedIdentifier "should reject corrupted identifier" <|
                \str ->
                    Identifier.fromString ("id:" ++ str)
                        |>Identifier.getInvalidId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
            
            , fuzz identifier "should reject very long identifier" <|
                \str ->
                    Identifier.fromString ("id:" ++ longPrefix ++ str)
                        |>Identifier.getInvalidId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)

            , test "should reject empty string" <|
                \_ ->
                    Identifier.fromString "id:"
                        |>Identifier.getInvalidId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
                    ]

    ]
