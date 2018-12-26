module Dalmatian.Album.Compositing exposing (Composition, Stencil)

import Dalmatian.Album.Thing as Thing
import Dalmatian.Album.Curve exposing (Draw)

type Composition =
    Illustration (List Int) -- ex: data
    | Shape (List Draw)
    | Relationship String String -- predicate entity-id
    | Invert
    | FlipHorizontal
    | XY Int Int
    | Blending Int -- Source-destination  0b1111


type alias Stencil = {
    compositing: List Composition
}
    




