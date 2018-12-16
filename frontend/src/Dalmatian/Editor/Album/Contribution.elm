module Dalmatian.Album.Contribution exposing (Localized)

import Dalmatian.Album.Hyperlink as Hyperlink
import Dalmatian.Album.Person as Person
import Dalmatian.Album.Rights as Rights

type alias Localized =
    { 
        language : String
        , creator: List Person.Model
        , contributor: List Person.Model
        , publisher: List Person.Model
        , sponsor: List Person.Model
        , translator: List Person.Model
        , artist: List Person.Model
        , author: List Person.Model
        , colorist: List Person.Model
        , inker: List Person.Model
        , letterer: List Person.Model
        , penciler: List Person.Model
        , editor: List Person.Model

}

