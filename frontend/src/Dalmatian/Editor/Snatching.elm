module Dalmatian.Editor.Snatching exposing (Snatch, LocalizedSnatches)

import Dalmatian.Editor.Dialect.Polymorphic exposing (PolymorphicData)
import Dalmatian.Editor.Pathway exposing (SnatchPath, Pathway)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)

type alias Snatch = {
    path: SnatchPath
    , data: PolymorphicData
    }

type alias LocalizedSnatches =
    { language : LanguageId
    , snatches : List Snatch
    }
