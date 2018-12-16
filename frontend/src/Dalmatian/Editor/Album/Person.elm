module Dalmatian.Album.Person exposing (Model)

type PersonKind = RealPerson| Pseudonym | Organization | Machine

type alias Model =
    { 
        language : String
        , identifier: String  
        , name: String
        , alternateName: String
        , description: String
        , homepage: List String
        , kind: PersonKind
    }
