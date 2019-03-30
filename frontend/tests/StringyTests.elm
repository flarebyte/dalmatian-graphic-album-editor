module StringyTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing (run)
import Dalmatian.Editor.Dialect.Stringy as Stringy

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
                    Stringy.toString str
                        |> run Stringy.parser |> Result.map Stringy.postParsing
                        |> Expect.equal (Ok str)
            , fuzz fuzzyEscape "should support escaped characters" <|
                \str ->
                    Stringy.toString str
                        |> run Stringy.parser |> Result.map Stringy.postParsing
                        |> Expect.equal (Ok str)
            
            , fuzz2 string string "should discard quote marker" <|
                \str str2->
                    Stringy.toString (str ++ "❘" ++ str2)
                        |> run Stringy.parser |> Result.map Stringy.postParsing
                        |> Expect.equal (Ok (str ++  str2))
       ]
    ]
