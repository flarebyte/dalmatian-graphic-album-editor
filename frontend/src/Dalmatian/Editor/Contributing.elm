module Dalmatian.Editor.Contributing exposing (Contribution(..)
    , fromStringList
    , fromStringListToken
    , toStringList
    , toStringListToken
    , contributionParser
    , toString
    )

-- Creator | Contributor | Publisher | Sponsor | Translator | Artist | Author | Colorist | Inker | Letterer | Penciler | Editor | Sponsor

import Dalmatian.Editor.Dialog exposing (DialogBox, DialogBoxOption, DialogBoxType(..), DialogField, InputType(..))
import Dalmatian.Editor.Dialect.Identifier as Identifier exposing (Id)
import Dalmatian.Editor.Token as Token exposing (TokenValue)
import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol)
import Set
import Dalmatian.Editor.Dialect.Stringy as Stringy

type Contribution
    = ContributionHeader String String -- ex: main, minor
    | ContributionLanguage String -- ex: en-gb
    | ContributionFooter String String -- ex: type, description
    | Contributor Id String String -- contributorId, type, comment

findStringByPosition: Int -> List ( Int, String ) -> String
findStringByPosition position list =
    list |> List.filter (\v -> Tuple.first v == position) |> List.head |> Maybe.map Tuple.second |> Maybe.withDefault ""

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

contributionParser : Parser Contribution
contributionParser =
  oneOf
    [   succeed ContributionHeader
        |. symbol "Header"
        |. spaces
        |= Stringy.parser
        |. spaces
        |= Stringy.parser
        |. spaces
        , succeed ContributionFooter
        |. symbol "Footer"
        |. spaces
        |= Stringy.parser
        |. spaces
        |= Stringy.parser
        |. spaces
        , succeed ContributionLanguage
        |. symbol "Language"
        |. spaces
        |= Stringy.parser
        |. spaces
        , succeed Contributor
        |. symbol "Contributor"
        |. spaces
        |= Identifier.parser
        |. spaces 
        |= Stringy.parser
        |. spaces
        |= Stringy.parser
        |. spaces
    ]

asStr = Stringy.toString

toString: Contribution -> String
toString contribution =
    case contribution of
        ContributionHeader a b ->
            ["Header", asStr a, asStr b] |> String.join " "

        ContributionLanguage a ->
            ["Language", asStr a] |> String.join " "

        ContributionFooter a b ->
            ["Footer", asStr a, asStr b] |> String.join " "

        Contributor a b c ->
            ["Contributor", Identifier.toString a, asStr b, asStr c] |> String.join " "