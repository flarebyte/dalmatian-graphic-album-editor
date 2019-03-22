module Dalmatian.Editor.Dialect.Identifier exposing (Id, create, createInt, getInvalidId, fromString, toString, parser)

import Parser exposing ((|.), (|=), Parser, oneOf, andThen, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, keyword, chompUntilEndOr, problem)
import Set
import Dalmatian.Editor.Dialect.Separator as Separator
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)

type Id
    = StringId String
    | IntId Int
    | InvalidId Failure

createInt: Int -> Id
createInt value =
    if value >= 0 then
        IntId value
    else
        Failing.create (String.fromInt value) InvalidFormatFailure "Id should not be a negative number" |> InvalidId

create: String ->  Id
create value =
    if String.isEmpty value then
        Failing.create value InvalidFormatFailure "Id should not be a empty" |> InvalidId
    else if String.length value > 70 then
        Failing.create value InvalidLengthFailure "The id should be less than 70 characters long" |> InvalidId
    else
        StringId value

getInvalidId: Id -> Maybe Failure
getInvalidId id =
    case id of
        InvalidId failure ->
            Just failure
        otherwise ->
            Nothing

toString : Id -> String
toString id =
    case id of
        StringId str ->
            "id:" ++ str

        IntId n ->
            "iid:" ++ String.fromInt n
        
        InvalidId failure ->
            failure.message

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
           InvalidId (Failing.fromDeadEndList msg str)

