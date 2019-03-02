module Dalmatian.Editor.Dialect.Position2DIntUnit exposing (
 Position2DInt, parser, toString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)

type alias Position2DInt =
    { width : Int
    , height : Int
    }


parser : Parser Position2DInt
parser =
    succeed Position2DInt
        |. spaces
        |= int
        |. symbol ","
        |= int
        |. spaces

parse : String -> Result String Position2DInt
parse str =
    case run parser str of
        Ok ab ->
            Ok ab

        Err msg ->
            Err "The format for dimension should be like 0,0"

toString: Position2DInt -> String
toString value =
    (String.fromInt value.width) ++ "," ++ (String.fromInt value.height)