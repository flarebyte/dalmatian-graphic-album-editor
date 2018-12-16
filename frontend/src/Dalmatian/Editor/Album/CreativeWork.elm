module Dalmatian.Album.CreativeWork exposing (Model)

import Dalmatian.Album.Hyperlink as Hyperlink
import Dalmatian.Album.Rights as Rights
import Dalmatian.Album.Contribution as Contribution

type alias Model =
    { 
    identifier: String    
    , version: String
    , created: String
    , modified: String
    , title: List LocalizedString.Localized
    , description: List LocalizedString.Localized
    , keywords: List LocalizedString.Localized
    , rights: List Rights.Localized
    , contribution: List Contribution.Localized
    
}
