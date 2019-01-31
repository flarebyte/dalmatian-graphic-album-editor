module Dalmatian.Editor.Contributing exposing (Contribution)

-- Creator | Contributor | Publisher | Sponsor | Translator | Artist | Author | Colorist | Inker | Letterer | Penciler | Editor | Sponsor

import Dalmatian.Editor.Identifier exposing (Id)
import Dalmatian.Editor.Dialog exposing (InputType(..), DialogField, DialogBox, DialogBoxes)

type Contribution
    = ContributionHeader String String -- ex: main, minor
    | ContributionLanguage String -- ex: en-gb
    | ContributionFooter String String -- ex: type, description
    | Contributor Id String String -- contributorId, type, comment

dialogBoxes: DialogBoxes
dialogBoxes = {
     id = "Contribution"
    , display = "Contribution"
    , items = [
        DialogBox "ContributionHeader" "Header" [
            DialogField (RefEnumInputType "header/type") "Type"
            , DialogField LineTextInputType "Description"
        ]
        , DialogBox "ContributionLanguage" "Language" [
            DialogField (RefEnumInputType "language/all") "Type"
        ]
        , DialogBox "ContributionFooter" "Footer" [
            DialogField (RefEnumInputType "footer/type") "Type"
            , DialogField LineTextInputType "Description"
        ]
    ]
    }