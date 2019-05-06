module Dalmatian.Editor.Dialect.Compositing exposing (CompositeData(..))

import Dalmatian.Editor.Dialect.Flagging exposing (OperationFlag)
import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol, keyword)

type CompositeData =
    NoCompositeData
    | ReferenceData ResourceId OperationFlag ResourceId
    | UnaryOperation ResourceId OperationFlag CompositeData
    | BinaryOperation ResourceId OperationFlag CompositeData CompositeData