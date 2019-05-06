module Dalmatian.Editor.Widget.LayoutField exposing (..)

import Dalmatian.Editor.Dialect.Polymorphic exposing (PolymorphicData(..), LocalResourceId, ResourceData, matchResourceId)
import Dalmatian.Editor.Pathway exposing (SnatchPath(..), PrimaryPathway(..))
import Dalmatian.Editor.Snatching exposing (Snatch, matchPath)

type alias LayoutField =
    { display : String
    , snatches : List Snatch
    }

getTileProperty: Int -> LocalResourceId -> LayoutField -> Maybe PolymorphicData
getTileProperty tileId localResourceId layoutField =
    layoutField.snatches 
        |> List.filter (PrimaryPathProps TilePath tileId |> matchPath)
        |> List.map .resourceData
        |> List.filter (matchResourceId localResourceId)
        |> List.head
        |> Maybe.map .data