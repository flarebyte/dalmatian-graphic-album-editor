module Dimension2DUnitTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing(run)
import Dalmatian.Editor.Dialect.Dimension2DUnit as Dimension2DUnit exposing (Dimension2D)
import Fuzzing exposing (fraction)

suite : Test
suite =
    describe "The Dimension2DUnit Module"
    [
        describe "parse"
        [
            fuzz2 fraction fraction "should parse valid dimension" <|
                \a b ->
                    run Dimension2DUnit.parser (Dimension2DUnit.toString (Dimension2D a b))
                        |> Expect.equal (Ok (Dimension2D a b))
        ]

    ]
