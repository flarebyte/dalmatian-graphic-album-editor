module Dalmatian.Album.Thing exposing (Model)

import Dalmatian.Album.LocalizedString as LocalizedString
import Dalmatian.Album.Identifier exposing (Id)

type alias Model =
    { 
        identifier: Id  
        , name: List LocalizedString.Model
        , description: List LocalizedString.Model
        , homepage: List String
        , sameAs: List String --ex: wikipedia page
        , stencilId: Maybe Int
        , keyword: List LocalizedString.Model -- RealPerson| Pseudonym | Organization | Machine
    }
