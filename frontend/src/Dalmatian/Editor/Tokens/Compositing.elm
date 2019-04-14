module Dalmatian.Editor.Tokens.Compositing exposing (Composition(..))

import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Position2DIntUnit exposing (Position2DInt)
import Dalmatian.Editor.Dialect.Dimension2DIntUnit exposing (Dimension2DInt)

type BinaryData
    = HexaCsv String -- ex: 1A 2B
    | ProxyImage ResourceId -- cache:1235

type Framing =
    OriginalFraming
    | TopLeftFraming Dimension2DInt Position2DInt

type alias Illustrated = {
        binaryData: BinaryData
        , dimension: Dimension2DInt
    }

type alias Relationships =
    List (ResourceId, ResourceId) -- List (predicate entity-id)

type Composition
    = IllustrationFrame Illustrated Framing Relationships -- ex: data
    | Invert Composition
    | FlipHorizontal Composition
    | Blending Int Composition Composition -- Source-destination  0b1111

