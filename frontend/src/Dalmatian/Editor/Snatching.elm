module Dalmatian.Editor.Snatching exposing (Snatch, LocalizedSnatches, matchPath)

import Dalmatian.Editor.Dialect.Polymorphic exposing (ResourceData, PolymorphicData)
import Dalmatian.Editor.Pathway exposing (SnatchPath)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)

type alias Snatch = {
    path: SnatchPath
    , resourceData: ResourceData
    }

type alias LocalizedSnatches =
    { language : LanguageId
    , snatches : List Snatch
    }

matchPath: SnatchPath -> Snatch -> Bool
matchPath snatchPath snatch =
    snatch.path == snatchPath
