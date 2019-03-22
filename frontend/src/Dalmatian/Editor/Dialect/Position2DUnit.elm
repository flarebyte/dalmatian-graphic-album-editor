module Dalmatian.Editor.Dialect.Position2DUnit exposing (
 Position2D, parser, toString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)
import Dalmatian.Editor.Dialect.FractionUnit as FractionUnit exposing (Fraction)

type alias Position2D =
    { width : Fraction
    , height : Fraction
    }


parser : Parser Position2D
parser =
    succeed Position2D
        |= FractionUnit.parser
        |. symbol ","
        |= FractionUnit.parser

parse : String -> Result String Position2D
parse str =
    case run parser str of
        Ok ab ->
            Ok ab

        Err msg ->
            Err "The format for dimension should be like 0,0"

toString: Position2D -> String
toString value =
    (FractionUnit.toString value.width) ++ "," ++ (FractionUnit.toString value.height)