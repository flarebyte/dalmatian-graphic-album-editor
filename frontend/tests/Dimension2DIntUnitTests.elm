module Dimension2DIntUnitTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing(run)
import Dalmatian.Editor.Dialect.Dimension2DIntUnit as Dimension2DIntUnit exposing (Dimension2DInt)
import Fuzzing exposing (positiveNumberOrZero, positiveNumber)

suite : Test
suite =
    describe "The Dimension2DIntUnit Module"
    [
        describe "parse"
        [
            fuzz2 positiveNumberOrZero positiveNumberOrZero "should parse valid dimension" <|
                \a b ->
                    run Dimension2DIntUnit.parser (Dimension2DIntUnit.toString (Dimension2DInt a b))
                        |> Expect.equal (Ok (Dimension2DInt a b))
            
        ]

    ]
