module Dalmatian.Editor.Tiling exposing (TileInstruction)

import Dalmatian.Editor.Identifier exposing (Id)
import Dalmatian.Editor.Unit exposing (Dimension2D, Fraction, Position2D)


type TileInstruction
    = Section Id
    | Page Id
    | RectPanel Id Position2D Dimension2D
    | SquarePanel Id Fraction Fraction -- position dimension
    | StencilId Id
    | SpeechId Id
    | ColorId Id
    | BackgroundColorId Id
    | Margin Fraction -- width
    | SolidBorderColor Id
