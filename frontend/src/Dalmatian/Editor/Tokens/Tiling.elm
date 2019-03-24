module Dalmatian.Editor.Tokens.Tiling exposing (TileInstruction)

import Dalmatian.Editor.Dialect.Identifier exposing (Id)
import Dalmatian.Editor.Dialect.Position2DUnit exposing (Position2D)
import Dalmatian.Editor.Dialect.Dimension2DUnit exposing (Dimension2D)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)


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
