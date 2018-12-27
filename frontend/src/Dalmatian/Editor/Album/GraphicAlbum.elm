module Dalmatian.Album.CreativeWork exposing (Model)

import Dalmatian.Album.Rights as Rights
import Dalmatian.Album.Contribution as Contribution
import Dalmatian.Album.LocalizedString as LocalizedString
import Dalmatian.Album.Compositing exposing (Stencil)
import module Dalmatian.Album.Speech exposing (Model)


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
    , stencil: List Stencil.Model
    , speech: List Speech.Model
    
}
