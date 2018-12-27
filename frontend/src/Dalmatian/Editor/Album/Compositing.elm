module Dalmatian.Album.Compositing exposing (Composition, Stencil)

import Dalmatian.Album.Curve exposing (Draw)
import Dalmatian.Album.Unit exposing (Position2DInt, Dimension2DInt)

type Composition =
    Illustration (List Int) -- ex: data
    | Shape (List Draw)
    | Relationship String String -- predicate entity-id
    | Invert
    | FlipHorizontal
    | XY Position2DInt
    | Dim Dimension2DInt
    | Blending Int -- Source-destination  0b1111


type alias Stencil = {
    identifier: Id  
    , compositing: List Composition
}
    




