module Dalmatian.Editor.Widget.CompositionField exposing (..)

import Dalmatian.Editor.Dialect.Polymorphic exposing (PolymorphicData(..), ResourceData)
import Dalmatian.Editor.Dialect.Compositing exposing (CompositeData(..))
import Dalmatian.Editor.Widget.VisualField exposing (VisualField)

type alias CompositionField = VisualField ResourceData

getCompositeData: CompositionField -> CompositeData
getCompositeData field =
    case field.value.data of
        NestedData compositeData ->
            compositeData
        otherwise ->
            NoCompositeData