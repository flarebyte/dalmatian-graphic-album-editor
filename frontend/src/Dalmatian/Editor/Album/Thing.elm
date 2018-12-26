module Dalmatian.Album.Thing exposing (Model)

import Dalmatian.Album.LocalizedString as LocalizedString

type alias Model =
    { 
        identifier: String  
        , name: List LocalizedString.Model
        , description: List LocalizedString.Model
        , homepage: List String
        , sameAs: List String --ex: wikipedia page
        , imageSelectorId: Int
        , keyword: List LocalizedString.Model -- RealPerson| Pseudonym | Organization | Machine
    }
