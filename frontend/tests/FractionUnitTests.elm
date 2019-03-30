module FractionUnitTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.FractionUnit as FractionUnit exposing (Fraction)
import Fuzzing exposing (fraction)
import Parser exposing(run)

suite : Test
suite =
    describe "The FractionUnit Module"
    [
        describe "parse"
        [
            fuzz fraction "should parse valid fraction" <|
                \fn ->
                    FractionUnit.toString fn |> run FractionUnit.parser
                        |> Expect.equal (Ok fn)
        ]

    ]
