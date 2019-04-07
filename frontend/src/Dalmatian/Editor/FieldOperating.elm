module Dalmatian.Editor.FieldOperating exposing (FieldOperation(..), toString)


type FieldOperation
    = ClearOp
    | SetValueOp
    | AddValueOp
    | RemoveValueOp
    | InsertAfterOp
    | InsertBeforeOp
    | MoveUpOp
    | MoveDownOp

toString: FieldOperation -> String
toString fieldOp =
    case fieldOp of
        ClearOp -> "clear"
        SetValueOp -> "set-value"
        AddValueOp -> "add-value"
        RemoveValueOp -> "remove-value"
        InsertAfterOp -> "insert-after"
        InsertBeforeOp -> "insert-before"
        MoveUpOp -> "move-up"
        MoveDownOp -> "move-down"

