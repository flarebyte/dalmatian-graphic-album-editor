module IdentifierTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Identifier as Identifier exposing (Id(..))


validStringId: Fuzzer String
validStringId =
    [
        "a"
        , "123e4567-e89b-12d3-a456-426655440000"
        , "a/b/c.d.e"
        , "a_b-c"
        ] |> List.map constant |> oneOf

invalidStringId: Fuzzer String
invalidStringId =
    [
        ""
        ] |> List.map constant |> oneOf

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
            , fuzz validStringId "should support StringId" <|
                \str ->
                    Identifier.fromString (Identifier.toString (StringId str))
                        |> Expect.equal (StringId str)
            
            , fuzz invalidStringId "should reject invalid StringId" <|
                \str ->
                    Identifier.fromString (Identifier.toString (StringId str))
                        |> Expect.equal (InvalidId ("id:" ++ str))
                    ]

    ]
