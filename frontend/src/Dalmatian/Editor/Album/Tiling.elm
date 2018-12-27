module Dalmatian.Album.Tile exposing (Layout, TileInstruction)

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
    | BackgroundColorId Id
    | Margin Fraction -- width
    | SolidBorderColor Id

type alias Layout = {
    layout: List TileInstruction
    , counterSection: Int
    , counterPage: Int
    , counterPanel: Int
}





