module Dalmatian.Editor.Dialect.Dimension2DUnit exposing (
 Dimension2D, parser, toString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)
import Dalmatian.Editor.Dialect.FractionUnit as FractionUnit exposing (Fraction)

type alias Dimension2D =
    { width : Fraction
    , height : Fraction
    }

parser : Parser Dimension2D
parser =
    succeed Dimension2D
        |= FractionUnit.parser
        |. symbol ","
        |= FractionUnit.parser

toString: Dimension2D -> String
toString value =
    (FractionUnit.toString value.width) ++ "," ++ (FractionUnit.toString value.height)