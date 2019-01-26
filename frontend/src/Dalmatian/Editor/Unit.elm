module Dalmatian.Editor.Unit exposing (Dimension2D, Dimension2DInt, Fraction, Position2D, Position2DInt, toDimension2DInt)


type alias Fraction =
    { numerator : Int
    , denominator : Int
    }


type alias Position2D =
    { x : Fraction
    , y : Fraction
    }


type alias Dimension2D =
    { width : Fraction
    , height : Fraction
    }


type alias Position2DInt =
    { x : Int
    , y : Int
    }


type alias Dimension2DInt =
    { width : Int
    , height : Int
    }


toDimension2DInt : Dimension2DInt -> String -> Dimension2DInt
toDimension2DInt defaultValue text =
    defaultValue
