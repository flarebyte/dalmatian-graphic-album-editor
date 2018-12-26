module Dalmatian.Album.Layout exposing (Composition, Stencil)

import Dalmatian.Album.Thing as Thing
import Dalmatian.Album.Curve exposing (Draw)

type alias Fraction = {
    numerator: Int
    , denominator: Int
}

type alias Position = {
    x: Fraction,
    y: Fraction,
    width: Fraction,
    height: Fraction
}

type TileInstruction =
    Section Int --id
    | Page Int -- id
    | Panel Int Position -- id
    | StencilId String
    | SpeechId String
    | ColorId String -- unique id

type Layout =
    TileLayout (List TileInstruction)





