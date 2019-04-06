module Dalmatian.Editor.Dialog exposing (DialogBox, DialogBoxOption, DialogBoxType(..), DialogField, InputType(..))


type InputType
    = LineTextInputType
    | RefEnumInputType String -- referenced
    | TextAreaInputType
    | FractionInputType
    | PositiveIntInputType


type alias DialogField =
    { kind : InputType
    , label : String
    }


type alias DialogBoxOption =
    { display : String
    , items : List ( Int, DialogField )
    }


type DialogBoxType
    = ContributionDBT
    | CompositionDBT


type alias DialogBox =
    { kind : DialogBoxType
    , display : String
    , items : List DialogBoxOption
    }
