module Dalmatian.Editor.Dialect.Dimension2DUnit exposing (
 Dimension2D, parser, parse, toString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)
import Dalmatian.Editor.Dialect.FractionUnit as FractionUnit exposing (Fraction)

type alias Dimension2D =
    { width : Fraction
    , height : Fraction
    }


parser : Parser Dimension2D
parser =
    succeed Dimension2D
        |. spaces
        |= FractionUnit.parser
        |. symbol ","
        |= FractionUnit.parser
        |. spaces

parse : String -> Result String Dimension2D
parse str =
    case run parser str of
        Ok ab ->
            Ok ab

        Err msg ->
            Err "The format for dimension should be like 0,0"

toString: Dimension2D -> String
toString value =
    (FractionUnit.toString value.width) ++ "," ++ (FractionUnit.toString value.height)