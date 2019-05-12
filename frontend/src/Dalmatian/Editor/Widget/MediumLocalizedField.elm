module Dalmatian.Editor.Widget.MediumLocalizedField exposing (..)

import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.Widget.FieldStyle exposing(FieldStyle)

type alias MediumLocalizedField = {
        style : FieldStyle
        , language : LanguageId
        , localizedText: List LocalizedString.Model
    }