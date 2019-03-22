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
        |= int
        |. symbol ","
        |= int

toString: Position2DInt -> String
toString value =
    (String.fromInt value.width) ++ "," ++ (String.fromInt value.height)