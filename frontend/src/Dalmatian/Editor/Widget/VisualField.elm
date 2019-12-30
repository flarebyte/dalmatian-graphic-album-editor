module Dalmatian.Editor.Widget.VisualField exposing (..)

import Dalmatian.Editor.Widget.FieldStyle exposing(FieldStyle)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)

type alias VisualField v = {
    style : FieldStyle
    , language : LanguageId
    , value: v
    }