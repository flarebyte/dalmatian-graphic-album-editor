module Position2DUnitTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing(run)
import Dalmatian.Editor.Dialect.Position2DUnit as Position2DUnit exposing (Position2D)
import Fuzzing exposing (fraction)

suite : Test
suite =
    describe "The Position2DUnit Module"
    [
        describe "parse"
        [
            fuzz2 fraction fraction "should parse valid Position" <|
                \a b ->
                    run Position2DUnit.parser (Position2DUnit.toString (Position2D a b))
                        |> Expect.equal (Ok (Position2D a b))
        ]

    ]
