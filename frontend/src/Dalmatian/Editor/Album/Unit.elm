module Dalmatian.Album.Unit exposing (Fraction, Position2D, Dimension2D)

type alias Fraction = {
    numerator: Int
    , denominator: Int
}

type alias Position2D = {
    x: Fraction
    , y: Fraction
}

type alias Dimension2D = {
     width: Fraction
    , height: Fraction
}





