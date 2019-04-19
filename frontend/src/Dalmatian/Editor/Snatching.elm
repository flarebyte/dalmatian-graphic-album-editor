module Dalmatian.Editor.Snatching exposing (Snatch)

import Dalmatian.Editor.Dialect.Polymorphic exposing (PolymorphicData)
import Dalmatian.Editor.Pathway exposing (SnatchPath, Pathway)

type alias Snatch = {
    path: SnatchPath
    , data: PolymorphicData
    }