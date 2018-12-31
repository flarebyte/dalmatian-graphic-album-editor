module Dalmatian.Album.Compositing exposing (Composition, Illustration, Stencil)

import Dalmatian.Album.Curve exposing (Draw)
import Dalmatian.Album.Unit exposing (Position2DInt, Dimension2DInt)

type Composition =
    Illustrated Id-- ex: data
    | Shape (List Draw)
    | Relationship String String -- predicate entity-id
    | Invert
    | FlipHorizontal
    | XY Position2DInt
    | Dim Dimension2DInt
    | Blending Int -- Source-destination  0b1111

type alias Illustration = {
    identifier: Id  
    , data: List Int
}

type alias Stencil = {
    identifier: Id  
    , compositing: List Composition
}
    




