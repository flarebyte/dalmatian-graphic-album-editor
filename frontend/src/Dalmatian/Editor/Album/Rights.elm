module Dalmatian.Album.Rights exposing (Localized)

type alias Localized =
    { 
        language : String
        , license: Hyperlink.Model
        , rights: Hyperlink.Model
        , attribution: Hyperlink.Model
    }

