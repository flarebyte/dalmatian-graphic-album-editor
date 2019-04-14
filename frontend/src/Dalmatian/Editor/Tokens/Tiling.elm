module Dalmatian.Editor.Tokens.Tiling exposing (..)

import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Position2DUnit exposing (Position2D)
import Dalmatian.Editor.Dialect.Dimension2DUnit exposing (Dimension2D)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)

type BorderProperties =
    BorderColor ResourceId
    | BorderStyle ResourceId
    | BorderMargin Fraction
    | BorderPadding Fraction

type ShapeCut = RectangularCut | SquareCut | CircularCut | HexagonalCut

type PanelResource =
    StencilId ResourceId
    | SpeechId ResourceId

type TileProperties =
    TileColor ResourceId
    | TileBackgroundColor ResourceId
    | TileDimension Dimension2D
    | TilePosition Position2D
    | TileBorder (List BorderProperties)
    | TileShape ShapeCut
    | TilePriority Int -- element with greater stack order is always in front of an element with a lower stack order.

type TileAssembling
    =  TilePanel PanelResource (List TileProperties)
