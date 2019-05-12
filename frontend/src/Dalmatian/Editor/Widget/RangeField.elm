module Dalmatian.Editor.Widget.RangeField exposing (..)

import Dalmatian.Editor.Dialect.Polymorphic as Polymorphic exposing (LocalResourceId, PolymorphicData(..), ResourceData)
import Dalmatian.Editor.Dialect.Ranging exposing (SelectionRange(..))
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.Widget.VisualField exposing (VisualField)

type alias RangeField = VisualField (List ResourceData)

getRange: LocalResourceId -> RangeField -> SelectionRange
getRange localResourceId field =
    case (field.value |> List.filter (Polymorphic.matchResourceId localResourceId) |> List.head |> Maybe.map .data) of
        Just (RangeData selectionRange) ->
            selectionRange
        otherwise ->
            Unselect
