module Dalmatian.Editor.Dialog exposing (InputType(..), DialogField, DialogBox, DialogBoxes)

type alias ListBoxItem =
    { value : String
    , display : String
    }

type InputType = LineTextInputType
    | RefEnumInputType String -- referenced
    | TextAreaInputType
    | FractionInputType
    | PositiveIntInputType

type alias DialogField = {
    kind: InputType
    , display : String
    }

type alias DialogBox = {
    id: String
    , display : String
    , items: List DialogField
    }

type alias DialogBoxes = {
    id: String
    , display : String
    , items: List DialogBox
    }