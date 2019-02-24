module StringParserTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing (run)
import Dalmatian.Editor.StringParser as StringParser

fuzzyEscape: Fuzzer String
fuzzyEscape =
    [
        "\u{9824}"
        ,"\n"
        ] |> List.map constant |> oneOf


suite : Test
suite =
    describe "The StringParser Module"
    [
        describe "stringParser"
        [
            fuzz string "should support be able to parse as tring both ways" <|
                \str ->
                    StringParser.toDialectString str
                        |> run StringParser.stringParser |> Result.map StringParser.postParsing
                        |> Expect.equal (Ok str)
            , fuzz fuzzyEscape "should support escaped characters" <|
                \str ->
                    StringParser.toDialectString str
                        |> run StringParser.stringParser |> Result.map StringParser.postParsing
                        |> Expect.equal (Ok str)
            
            , fuzz2 string string "should discard quote marker" <|
                \str str2->
                    StringParser.toDialectString (str ++ "❘" ++ str2)
                        |> run StringParser.stringParser |> Result.map StringParser.postParsing
                        |> Expect.equal (Ok (str ++  str2))
       ]
    ]
