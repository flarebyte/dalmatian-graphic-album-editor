module Dimension2DIntUnitTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.Dimension2DIntUnit as Dimension2DIntUnit exposing (Dimension2DInt)

suite : Test
suite =
    describe "The Unit Module"
    [
        describe "parseDimension2DInt"
        [
            fuzz2 (intRange 0 10000 ) (intRange 0 10000 ) "should parse valid dimension" <|
                \a b ->
                    Dimension2DIntUnit.parse (Dimension2DIntUnit.toString (Dimension2DInt a b))
                        |> Expect.equal (Ok (Dimension2DInt a b))
            
            , fuzz2 (intRange -10000 -1) int "should reject negative dimension" <|
                \a b ->
                    Dimension2DIntUnit.parse (Dimension2DIntUnit.toString (Dimension2DInt a b))
                        |> Expect.equal (Err "The format for dimension should be like 0,0")
            
            , fuzz string "should reject invalid dimension" <|
                \str ->
                    Dimension2DIntUnit.parse str
                        |> Expect.equal (Err "The format for dimension should be like 0,0")
         ]

    ]
