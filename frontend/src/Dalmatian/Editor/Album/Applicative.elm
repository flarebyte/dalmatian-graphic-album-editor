module Dalmatian.Album.Applicative exposing (Model)

import Dalmatian.Album.Persistence exposing(StoreValue)

type alias Model =
    { 
    counter: Int    
    , album: List StoreValue
}
