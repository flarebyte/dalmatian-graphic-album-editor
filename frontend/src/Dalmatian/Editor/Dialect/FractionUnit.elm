module Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction, parser, toString)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)

type alias Fraction =
    { numerator : Int
    , denominator : Int
    }


parser : Parser Fraction
parser =
    succeed Fraction
        |. spaces
        |= int
        |. symbol "/"
        |= int
        |. spaces

toString: Fraction -> String
toString value =
    (String.fromInt value.numerator) ++ "/" ++ (String.fromInt value.denominator)