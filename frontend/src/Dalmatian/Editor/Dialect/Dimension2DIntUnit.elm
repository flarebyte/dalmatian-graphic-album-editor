module Dalmatian.Editor.Dialect.Dimension2DIntUnit exposing (
 Dimension2DInt, parser, parse, toString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)

type alias Dimension2DInt =
    { width : Int
    , height : Int
    }


parser : Parser Dimension2DInt
parser =
    succeed Dimension2DInt
        |. spaces
        |= int
        |. symbol ","
        |= int
        |. spaces

parse : String -> Result String Dimension2DInt
parse str =
    case run parser str of
        Ok ab ->
            Ok ab

        Err msg ->
            Err "The format for dimension should be like 0,0"

toString: Dimension2DInt -> String
toString value =
    (String.fromInt value.width) ++ "," ++ (String.fromInt value.height)