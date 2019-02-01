module Dalmatian.Editor.Contributing exposing (Contribution)

-- Creator | Contributor | Publisher | Sponsor | Translator | Artist | Author | Colorist | Inker | Letterer | Penciler | Editor | Sponsor

import Dalmatian.Editor.Identifier exposing (Id)
import Dalmatian.Editor.Dialog exposing (InputType(..), DialogField, DialogBoxOption, DialogBox, DialogBoxType(..))

type Contribution
    = ContributionHeader String String -- ex: main, minor
    | ContributionLanguage String -- ex: en-gb
    | ContributionFooter String String -- ex: type, description
    | Contributor Id String String -- contributorId, type, comment

dialogBox: DialogBox
dialogBox = {
     kind = ContributionDBT
    , display = "Contribution"
    , items = [
        DialogBoxOption "Header"  ([
            DialogField (RefEnumInputType "header/type") "Type"
            , DialogField LineTextInputType "Description"
        ] |> List.indexedMap Tuple.pair)
        , DialogBoxOption "Language" ([
            DialogField (RefEnumInputType "language/all") "Type"
        ] |> List.indexedMap Tuple.pair)
        , DialogBoxOption "Footer" ([
            DialogField (RefEnumInputType "footer/type") "Type"
            , DialogField LineTextInputType "Description"
        ] |> List.indexedMap Tuple.pair)
        , DialogBoxOption "Contributor" ([
            DialogField (RefEnumInputType "contributor/id") "Id"
            , DialogField (RefEnumInputType "contributor/type") "Type"
            , DialogField LineTextInputType "Description"
        ] |> List.indexedMap Tuple.pair)
    ]
    }