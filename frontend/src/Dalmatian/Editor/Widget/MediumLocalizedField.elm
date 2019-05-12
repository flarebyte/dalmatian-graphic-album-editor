module Dalmatian.Editor.Widget.MediumLocalizedField exposing (..)

import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.Widget.VisualField exposing (VisualField)

type alias MediumLocalizedField = VisualField (List LocalizedString.Model)
