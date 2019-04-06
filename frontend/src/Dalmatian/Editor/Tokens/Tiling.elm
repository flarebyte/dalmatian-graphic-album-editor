module Dalmatian.Editor.Tokens.Tiling exposing (TileInstruction)

import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Position2DUnit exposing (Position2D)
import Dalmatian.Editor.Dialect.Dimension2DUnit exposing (Dimension2D)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)


type TileInstruction
    = Section ResourceId
    | Page ResourceId
    | RectPanel ResourceId Position2D Dimension2D
    | SquarePanel ResourceId Fraction Fraction -- position dimension
    | StencilId ResourceId
    | SpeechId ResourceId
    | ColorId ResourceId
    | BackgroundColorId ResourceId
    | Margin Fraction -- width
    | SolidBorderColor ResourceId
