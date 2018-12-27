module Dalmatian.Album.Layout exposing (Composition, Stencil)

import Dalmatian.Album.Unit exposing (Fraction, Position2D, Dimension2D)
import Dalmatian.Album.Identifier exposing (Id)

type TileInstruction =
    Section Id
    | Page Id
    | RectPanel Id Position2D Dimension2D
    | SquarePanel Id Fraction Fraction -- position dimension
    | StencilId Id
    | SpeechId Id
    | ColorId Id
    | BackgroundColorId Id

type Layout =
    TileLayout (List TileInstruction)





