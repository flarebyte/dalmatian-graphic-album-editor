module Dalmatian.Editor.FieldOperating exposing (FieldOperation(..))


type FieldOperation
    = ClearOp
    | SetValueOp
    | AddValueOp
    | RemoveValueOp
    | InsertAfterOp
    | InsertBeforeOp
    | MoveUpOp
    | MoveDownOp


