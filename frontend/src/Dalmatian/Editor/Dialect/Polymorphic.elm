module Dalmatian.Editor.Dialect.Polymorphic exposing (PolymorphicData)

import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Ranging exposing (SelectionRange)
import Dalmatian.Editor.Dialect.Position2DUnit exposing (Position2D)
import Dalmatian.Editor.Dialect.Dimension2DUnit exposing (Dimension2D)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)
import Dalmatian.Editor.Dialect.Compositing exposing (CompositeData)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol, keyword)

type PolymorphicData = 
    RangeData ResourceId ResourceId SelectionRange -- font fontId range
    | ResourceIdData ResourceId ResourceId -- predicate entity-id
    | ResourceIdListData ResourceId (List ResourceId) -- predicate entity-id
    | RelationshipData ResourceId ResourceId ResourceId --
    | RelationshipsData ResourceId ResourceId (List ResourceId) --
    | FractionData ResourceId Fraction
    | Position2DData ResourceId Position2D
    | Dimension2DData ResourceId Dimension2D
    | IntData ResourceId Int
    | NestedData CompositeData
