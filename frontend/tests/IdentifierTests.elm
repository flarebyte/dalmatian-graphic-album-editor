module IdentifierTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.Identifier as Identifier exposing (Id(..))
import Fuzzing exposing (identifier, corruptedIdentifier)

longPrefix = String.repeat 100 "a"

suite : Test
suite =
    describe "The Identifier Module"
    [
        describe "fromString"
        [
            fuzz (intRange 0 10000 ) "should support IntId" <|
                \a ->
                    Identifier.fromString (Identifier.toString (IntId a))
                        |> Expect.equal (IntId a)
            , fuzz (intRange -1000 -1 ) "should reject negative number" <|
                \a ->
                    Identifier.fromString (Identifier.toString (IntId a))
                        |> Expect.equal (InvalidId ("iid:" ++ (String.fromInt a)))
        
            , fuzz identifier "should support StringId" <|
                \str ->
                    Identifier.fromString (Identifier.toString (StringId str))
                        |> Expect.equal (StringId str)

            , fuzz corruptedIdentifier "should reject corrupted identifier" <|
                \str ->
                    Identifier.fromString (Identifier.toString (StringId str))
                        |> Expect.equal (InvalidId ("id:" ++ str))
            
            , fuzz identifier "should reject very long identifier" <|
                \str ->
                    Identifier.fromString (Identifier.toString (longPrefix ++ str |> StringId))
                        |> Expect.equal (InvalidId ("id:" ++ longPrefix ++ str))

            , test "should reject empty string" <|
                \_ ->
                    Identifier.fromString (Identifier.toString (StringId ""))
                        |> Expect.equal (InvalidId ("id:"))
                    ]

    ]
