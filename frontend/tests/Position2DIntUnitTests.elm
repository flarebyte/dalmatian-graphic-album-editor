module Position2DIntUnitTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing(run)
import Dalmatian.Editor.Dialect.Position2DIntUnit as Position2DIntUnit exposing (Position2DInt)
import Fuzzing exposing (positiveNumberOrZero, positiveNumber)

suite : Test
suite =
    describe "The Position2DIntUnit Module"
    [
        describe "parse"
        [
            fuzz2 positiveNumberOrZero positiveNumberOrZero "should parse valid Position" <|
                \a b ->
                    run Position2DIntUnit.parser (Position2DIntUnit.toString (Position2DInt a b))
                        |> Expect.equal (Ok (Position2DInt a b))
            
        ]

    ]
