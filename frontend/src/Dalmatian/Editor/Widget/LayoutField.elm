module Dalmatian.Editor.Widget.LayoutField exposing (..)

import Dalmatian.Editor.Dialect.Polymorphic exposing (PolymorphicData(..), LocalResourceId, ResourceData, matchResourceId)
import Dalmatian.Editor.Pathway exposing (SnatchPath(..), PrimaryPathway(..))
import Dalmatian.Editor.Snatching exposing (Snatch, matchPath)
import Dalmatian.Editor.Widget.VisualField exposing (VisualField)

type alias LayoutField = VisualField (List Snatch)

getTileProperty: Int -> LocalResourceId -> LayoutField -> Maybe PolymorphicData
getTileProperty tileId localResourceId layoutField =
    layoutField.value 
        |> List.filter (PrimaryPathProps TilePath tileId |> matchPath)
        |> List.map .resourceData
        |> List.filter (matchResourceId localResourceId)
        |> List.head
        |> Maybe.map .data