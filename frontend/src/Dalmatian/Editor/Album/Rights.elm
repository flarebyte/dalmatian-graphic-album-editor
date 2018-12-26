module Dalmatian.Album.Rights exposing (Model)

import Dalmatian.Album.Thing as Thing

type alias Model =
    { 
          license: Thing.Model
        , rights: Thing.Model
        , attribution: Thing.Model
    }

