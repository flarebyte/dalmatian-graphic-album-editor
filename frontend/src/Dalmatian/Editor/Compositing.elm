module Dalmatian.Editor.Compositing exposing (BinaryData(..), Composition)

import Dalmatian.Editor.Curve exposing (Draw)
import Dalmatian.Editor.Unit exposing (Dimension2DInt, Position2DInt)
import Dalmatian.Editor.Identifier exposing(Id)


type Composition
    = Illustrated Id -- ex: data
    | Shape (List Draw)
    | Relationship String String -- predicate entity-id
    | Invert
    | FlipHorizontal
    | XY Position2DInt
    | Dim Dimension2DInt
    | Blending Int -- Source-destination  0b1111


type BinaryData
    = IntCsv String -- 12 345
    | ProxyImage String -- cache:1235
