module Dalmatian.Album.CreativeWork exposing (Model)

import Dalmatian.Album.Thing as Thing
import Dalmatian.Album.Rights as Rights
import Dalmatian.Album.Contribution as Contribution
import Dalmatian.Album.LocalizedString as LocalizedString

type alias Model =
    { 
    identifier: String    
    , version: String
    , created: String
    , modified: String
    , title: List LocalizedString.Localized
    , description: List LocalizedString.Localized
    , keyword: List LocalizedString.Localized
    , rights: Rights.Model
    , contribution: List Contribution
    
}
