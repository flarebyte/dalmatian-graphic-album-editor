module ColoringTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.Coloring as Coloring exposing (Chroma)
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier
import Fuzzing exposing (curie, path, positiveNumberOrZero, fraction)
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)

longPrefix = String.repeat 100 "a"

suite : Test
suite =
    describe "The Coloring Module"
    [
        describe "fromString"
        [
            fuzz3 positiveNumberOrZero positiveNumberOrZero positiveNumberOrZero "should support RGBA" <|
                \r g b ->
                    Coloring.fromString (Coloring.toString (Coloring.createRGBA r g b 10 ))
                        |> Expect.equal (Coloring.createRGBA r g b 10 )
            
            , fuzz3 fraction fraction fraction "should support HSLA" <|
                \h s l ->
                    Coloring.fromString (Coloring.toString (Coloring.createHSLA h s l (Fraction 1 10)))
                        |> Expect.equal (Coloring.createHSLA h s l (Fraction 1 10))
            
            , fuzz3 fraction fraction fraction "should support CMYK" <|
                \c m y ->
                    Coloring.fromString (Coloring.toString (Coloring.createCMYK c m y (Fraction 1 10)))
                        |> Expect.equal (Coloring.createCMYK c m y (Fraction 1 10))
            
            , fuzz2 curie path "should support Color Id" <|
                \c p ->
                    Coloring.fromString (Coloring.toString (Coloring.create (ResourceIdentifier.create c p)))
                        |> Expect.equal (Coloring.create (ResourceIdentifier.create c p))
        ]

    ]
