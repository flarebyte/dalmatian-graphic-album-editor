module Dalmatian.Album.Unit exposing (Fraction, Position2D, Dimension2D, Position2DInt, Dimension2DInt)

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

type alias Position2DInt = {
    x: Int
    , y: Int
}

type alias Dimension2DInt = {
     width: Int
    , height: Int
}





