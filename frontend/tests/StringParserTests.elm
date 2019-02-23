module StringParserTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing (run)
import Dalmatian.Editor.StringParser as StringParser


suite : Test
suite =
    describe "The StringParser Module"
    [
        describe "stringParser"
        [
            fuzz string "should support be able to parse as tring both ways" <|
                \str ->
                    StringParser.toDialectString str
                        |> run StringParser.stringParser
                        |> Expect.equal (Ok str)
        ]
    ]
