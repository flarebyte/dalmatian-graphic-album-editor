module Dalmatian.Editor.Contributing exposing (Contribution, fromStringList, fromStringListToken, toStringList, toStringListToken)

-- Creator | Contributor | Publisher | Sponsor | Translator | Artist | Author | Colorist | Inker | Letterer | Penciler | Editor | Sponsor

import Dalmatian.Editor.Dialog exposing (DialogBox, DialogBoxOption, DialogBoxType(..), DialogField, InputType(..))
import Dalmatian.Editor.Identifier as Identifier exposing (Id)
import Dalmatian.Editor.Token as Token exposing (TokenValue, findStringByPosition)


type Contribution
    = ContributionHeader String String -- ex: main, minor
    | ContributionLanguage String -- ex: en-gb
    | ContributionFooter String String -- ex: type, description
    | Contributor Id String String -- contributorId, type, comment


toStringList : Contribution -> List ( Int, String )
toStringList contribution =
    case contribution of
        ContributionHeader a b ->
            [ ( 100, "ContributionHeader" ), ( 0, a ), ( 1, b ) ]

        ContributionLanguage a ->
            [ ( 100, "ContributionLanguage" ), ( 0, a ) ]

        ContributionFooter a b ->
            [ ( 100, "ContributionFooter" ), ( 0, a ), ( 1, b ) ]

        Contributor a b c ->
            [ ( 100, "Contributor" ), ( 0, Identifier.toString a ), ( 1, b ), ( 2, c ) ]


fromStringList : List ( Int, String ) -> Maybe Contribution
fromStringList list =
    case findStringByPosition 100 list of
        "ContributionHeader" ->
            ContributionHeader (findStringByPosition 0 list) (findStringByPosition 1 list) |> Just

        "ContributionLanguage" ->
            ContributionLanguage (findStringByPosition 0 list) |> Just

        "ContributionFooter" ->
            ContributionFooter (findStringByPosition 0 list) (findStringByPosition 1 list) |> Just

        "Contributor" ->
            Contributor (findStringByPosition 0 list |> Identifier.fromString) (findStringByPosition 1 list) (findStringByPosition 2 list) |> Just

        otherwise ->
            Nothing


fromStringListToken : TokenValue (List ( Int, String )) -> Maybe (TokenValue Contribution)
fromStringListToken tokenValue =
    fromStringList tokenValue.value |> Maybe.map (\contrib -> TokenValue tokenValue.uid contrib tokenValue.rank)


toStringListToken : TokenValue Contribution -> TokenValue (List ( Int, String ))
toStringListToken tokenValue =
    TokenValue tokenValue.uid (toStringList tokenValue.value) tokenValue.rank


dialogBox : DialogBox
dialogBox =
    { kind = ContributionDBT
    , display = "Contribution"
    , items =
        [ DialogBoxOption "Header"
            ([ DialogField (RefEnumInputType "header/type") "Type"
             , DialogField LineTextInputType "Description"
             ]
                |> List.indexedMap Tuple.pair
            )
        , DialogBoxOption "Language"
            ([ DialogField (RefEnumInputType "language/all") "Type"
             ]
                |> List.indexedMap Tuple.pair
            )
        , DialogBoxOption "Footer"
            ([ DialogField (RefEnumInputType "footer/type") "Type"
             , DialogField LineTextInputType "Description"
             ]
                |> List.indexedMap Tuple.pair
            )
        , DialogBoxOption "Contributor"
            ([ DialogField (RefEnumInputType "contributor/id") "Id"
             , DialogField (RefEnumInputType "contributor/type") "Type"
             , DialogField LineTextInputType "Description"
             ]
                |> List.indexedMap Tuple.pair
            )
        ]
    }
