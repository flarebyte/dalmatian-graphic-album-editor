module Dalmatian.Editor.Tokens.Compositing exposing (BinaryData(..), Composition)
import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Position2DIntUnit exposing (Position2DInt)
import Dalmatian.Editor.Dialect.Dimension2DIntUnit exposing (Dimension2DInt)


type Composition
    = Illustrated ResourceId -- ex: data
    | Relationship String String -- predicate entity-id
    | Invert
    | FlipHorizontal
    | XY Position2DInt
    | Dim Dimension2DInt
    | Blending Int -- Source-destination  0b1111


type BinaryData
    = IntCsv String -- 12 345
    | ProxyImage String -- cache:1235
