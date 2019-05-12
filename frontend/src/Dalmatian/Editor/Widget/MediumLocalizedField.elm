module Dalmatian.Editor.Widget.MediumLocalizedField exposing (..)

import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)

type alias MediumLocalizedField = {
        display : String
        , language : LanguageId
        , localizedText: List LocalizedString.Model
    }