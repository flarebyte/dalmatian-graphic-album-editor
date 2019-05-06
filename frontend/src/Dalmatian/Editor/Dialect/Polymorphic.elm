module Dalmatian.Editor.Dialect.Polymorphic exposing (LocalResourceId, ResourceData, PolymorphicData(..), matchResourceId)

import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Ranging exposing (SelectionRange)
import Dalmatian.Editor.Dialect.Position2DUnit exposing (Position2D)
import Dalmatian.Editor.Dialect.Dimension2DUnit exposing (Dimension2D)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)
import Dalmatian.Editor.Dialect.Compositing exposing (CompositeData)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol, keyword)

type LocalResourceId =
    LocalResourceId ResourceId
    | LocalResourceIdVariant ResourceId ResourceId

type alias ResourceData = {
    resourceId: LocalResourceId
    , data: PolymorphicData
    }

type PolymorphicData = 
    RangeData SelectionRange -- font fontId range
    | ResourceIdData ResourceId -- predicate entity-id
    | ResourceIdListData (List ResourceId) -- predicate entity-id
    | FractionData Fraction
    | Position2DData Position2D
    | Dimension2DData Dimension2D
    | IntData Int
    | NestedData CompositeData

matchResourceId: LocalResourceId -> ResourceData -> Bool
matchResourceId resourceId resourceData =
    resourceData.resourceId == resourceId
