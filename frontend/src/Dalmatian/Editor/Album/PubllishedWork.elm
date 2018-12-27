module Dalmatian.Album.PublishedWork exposing (Model)

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
    , medium: String
    , format: String
    , layout: Layout
}
