module Dalmatian.Editor.Identifier exposing (Id(..), fromString, toString, idParser)

import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol)
import Set

type Id
    = StringId String
    | IntId Int
    | InvalidId String


toString : Id -> String
toString id =
    case id of
        StringId str ->
            "id:" ++ str

        IntId n ->
            "uid:" ++ String.fromInt n
        
        InvalidId str->
            "The Identifier is invalid: " ++ str


idParser : Parser Id
idParser =
  oneOf
    [succeed StringId
        |. symbol "id:"
        |.spaces
        |= variable
        { start = Char.isAlphaNum
        , inner = \c -> Char.isAlphaNum c || c == '_' || c == '-' || c == '/' || c == '.'
        , reserved = Set.empty
        }
        |.spaces
    , succeed IntId
        |. symbol "uid:"
        |= int    
    ]


fromString : String -> Id
fromString str =
    case run idParser str of
        Ok id ->
            id

        Err msg ->
           InvalidId str

