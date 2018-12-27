module Dalmatian.Album.PublishedWork exposing (Model)

import Dalmatian.Album.Thing as Thing
import Dalmatian.Album.Rights as Rights
import Dalmatian.Album.Contribution as Contribution
import Dalmatian.Album.LocalizedString as LocalizedString
import Dalmatian.Album.Tiling exposing (Layout)

type alias Model =
    { 
    identifier: String    
    , version: String
    , language: String
    , title: List LocalizedString.Localized
    , description: List LocalizedString.Localized
    , medium: Thing.Model
    , format: Thing.Model
    , style: Thing.Model
    , contribution: List Contribution
    , layout: Layout
}
