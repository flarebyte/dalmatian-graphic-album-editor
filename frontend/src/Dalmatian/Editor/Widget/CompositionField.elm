module Dalmatian.Editor.Widget.CompositionField exposing (..)

import Dalmatian.Editor.Dialect.Polymorphic exposing (PolymorphicData(..), ResourceData)
import Dalmatian.Editor.Dialect.Compositing exposing (CompositeData(..))

type alias CompositionField =
    { display : String
    , resourceData : ResourceData
    }

getCompositeData: CompositionField -> CompositeData
getCompositeData field =
    case field.resourceData.data of
        NestedData compositeData ->
            compositeData
        otherwise ->
            NoCompositeData