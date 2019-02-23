module UnitTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Unit as Unit exposing (Dimension2DInt)

suite : Test
suite =
    describe "The Unit Module"
    [
        describe "parseDimension2DInt"
        [
            fuzz2 (intRange 0 10000 ) (intRange 0 10000 ) "should parse valid dimension" <|
                \a b ->
                    Unit.parseDimension2DInt (Unit.dimension2DIntAsString (Dimension2DInt a b))
                        |> Expect.equal (Ok (Dimension2DInt a b))
            
            , fuzz2 (intRange -10000 -1) int "should reject negative dimension" <|
                \a b ->
                    Unit.parseDimension2DInt (Unit.dimension2DIntAsString (Dimension2DInt a b))
                        |> Expect.equal (Err "The format for dimension should be like 0,0")
            
            , fuzz string "should reject invalid dimension" <|
                \str ->
                    Unit.parseDimension2DInt str
                        |> Expect.equal (Err "The format for dimension should be like 0,0")
         ]

    ]
