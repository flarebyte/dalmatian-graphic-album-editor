module Dalmatian.Album.PublishedWork exposing (Model)

import Dalmatian.Album.Hyperlink as Hyperlink
import Dalmatian.Album.Rights as Rights
import Dalmatian.Album.Contribution as Contribution

type alias Model =
    { 
    identifier: String    
    , version: String
    , language: String
    , title: List LocalizedString.Localized
    , description: List LocalizedString.Localized
    , medium: Hyperlink.Model
    , format: Hyperlink.Model
    , style: Hyperlink.Model
}
