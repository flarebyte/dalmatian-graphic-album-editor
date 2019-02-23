module Dalmatian.Editor.Unit exposing (Dimension2D,
 Dimension2DInt, Fraction, Position2D,
  Position2DInt, parseDimension2DInt, dimension2DIntAsString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)

type alias Fraction =
    { numerator : Int
    , denominator : Int
    }


type alias Position2D =
    { x : Fraction
    , y : Fraction
    }


type alias Dimension2D =
    { width : Fraction
    , height : Fraction
    }


type alias Position2DInt =
    { x : Int
    , y : Int
    }


type alias Dimension2DInt =
    { width : Int
    , height : Int
    }


dimension2DIntParser : Parser Dimension2DInt
dimension2DIntParser =
    succeed Dimension2DInt
        |. spaces
        |= int
        |. symbol ","
        |= int
        |. spaces

parseDimension2DInt : String -> Result String Dimension2DInt
parseDimension2DInt str =
    case run dimension2DIntParser str of
        Ok ab ->
            Ok ab

        Err msg ->
            Err "The format for dimension should be like 0,0"

dimension2DIntAsString: Dimension2DInt -> String
dimension2DIntAsString value =
    (String.fromInt value.width) ++ "," ++ (String.fromInt value.height)