module Dalmatian.Editor.Widget.RangeField exposing (..)

import Dalmatian.Editor.Dialect.Polymorphic as Polymorphic exposing (LocalResourceId, PolymorphicData(..), ResourceData)
import Dalmatian.Editor.Dialect.Ranging exposing (SelectionRange(..))
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)

type alias RangeField =
    { display : String
    , language : LanguageId
    , items : List ResourceData
    }

getRange: LocalResourceId -> RangeField -> SelectionRange
getRange localResourceId field =
    case Polymorphic.get localResourceId field.items of
        Just (RangeData selectionRange) ->
            selectionRange
        otherwise ->
            Unselect
