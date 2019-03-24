module Dalmatian.Editor.Dialect.Dimension2DIntUnit exposing (
 Dimension2DInt, parser, toString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol, keyword)

type alias Dimension2DInt =
    { width : Int
    , height : Int
    }

parser : Parser Dimension2DInt
parser =
    succeed Dimension2DInt
        |. keyword "d"
        |. symbol "="
        |= int
        |. symbol ","
        |= int

toString: Dimension2DInt -> String
toString value =
    "d=" ++ (String.fromInt value.width) ++ "," ++ (String.fromInt value.height)