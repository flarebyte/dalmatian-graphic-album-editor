module Dalmatian.Album.GraphicAlbum exposing (Model)

import Dalmatian.Album.Rights as Rights
import Dalmatian.Album.Contribution as Contribution
import Dalmatian.Album.PublishedWork exposing (Model)
import Dalmatian.Album.LocalizedString as LocalizedString
import Dalmatian.Album.Compositing exposing (Stencil, Illustration)
import module Dalmatian.Album.Speech exposing (Model)
import Dalmatian.Album.Coloring exposing (Model)
import Dalmatian.Album.Thing exposing (Model)


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
    , illustration: List Illustration
    , stencil: List Stencil
    , font: List Thing.Model
    , character: List Thing.Model
    , speech: List Speech.Model
    , color: List Coloring.Model
    , publishedWork: List PublishedWork
    , language: List String
    
}
