module Dalmatian.Editor.Widget.VisualField exposing (..)

import Dalmatian.Editor.Widget.FieldStyle exposing(FieldStyle)

type alias VisualField v = {
    style : FieldStyle
    , value: v
    }