module Dalmatian.Editor.LocalizedString exposing (Model)

import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)

type alias Model =
    { language : LanguageId
    , text : String
    }
