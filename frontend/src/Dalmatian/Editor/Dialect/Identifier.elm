module Dalmatian.Editor.Dialect.Identifier exposing (Id(..), fromString, toString, parser)

import Parser exposing ((|.), (|=), Parser, oneOf, andThen, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, keyword, chompUntilEndOr, problem)
import Set
import Dalmatian.Editor.Dialect.Separator as Separator

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
            "iid:" ++ String.fromInt n
        
        InvalidId str->
            "The Identifier is invalid: " ++ str

extractId: Parser String
extractId = variable
        { start = Char.isAlphaNum
        , inner = \c -> Char.isAlphaNum c ||  c == '-' || c == '/' || c == '.'
        , reserved = Set.empty
        }


checkId : String -> Parser String
checkId value =
      if String.length value <= 70 then
        succeed value
      else
        problem "The id should be less than 70 characters long"

parser : Parser Id
parser =
  oneOf
    [succeed IntId
        |. keyword "iid"
        |. symbol ":"
        |= int
        |. Separator.space    
    ,succeed StringId
        |. keyword "id"
        |. symbol ":"
        |= (extractId |> andThen checkId)
        |. Separator.space
    ]


fromString : String -> Id
fromString str =
    case run parser str of
        Ok id ->
            id

        Err msg ->
           InvalidId str

