module Dalmatian.Editor.Identifier exposing (Id(..), fromString, toString)


type Id
    = StringId String
    | IntId Int


toString : Id -> String
toString id =
    case id of
        StringId str ->
            "id:" ++ str

        IntId n ->
            "uid:" ++ String.fromInt n


fromString : String -> Id
fromString str =
    StringId "TODO"
