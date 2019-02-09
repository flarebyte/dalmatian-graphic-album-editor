module Dalmatian.Editor.FieldPersistence exposing (FieldValue(..), toStringFieldValue, isValidFieldValue, upsertContributionValue)

import Dalmatian.Editor.Coloring exposing (Chroma, toChroma)
import Dalmatian.Editor.Compositing exposing (BinaryData(..), Composition)
import Dalmatian.Editor.Contributing as Contributing exposing (Contribution)
import Dalmatian.Editor.Identifier exposing (Id(..))
import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Speech exposing (Interlocutor, Transcript, fromStringInterlocutor)
import Dalmatian.Editor.Tiling exposing (TileInstruction)
import Dalmatian.Editor.Unit exposing (Dimension2D, Dimension2DInt, Fraction, Position2D, Position2DInt, toDimension2DInt)
import Dalmatian.Editor.Version as Version exposing (SemanticVersion)
import Dalmatian.Editor.Schema exposing (FieldType(..))
import Dalmatian.Editor.Token as Token exposing (TokenValue)

type FieldValue
    = LocalizedListValue (List LocalizedString.Model)
    | IdValue Id
    | VersionValue SemanticVersion
    | UrlListValue (List String)
    | DateTimeValue String
    | LanguageValue String
    | ChromaValue Chroma
    | CompositionValue (List (TokenValue Composition))
    | BinaryDataValue BinaryData
    | Dimension2DIntValue Dimension2DInt
    | ContributionValue (List (TokenValue Contribution))
    | ListBoxValue String
    | LayoutValue (List (TokenValue TileInstruction))
    | InterlocutorValue (List (TokenValue Interlocutor))
    | TranscriptValue (List (TokenValue Transcript))
    | TodoField
    | NoValue
    | WarningMessage String


isValidFieldValue: FieldValue -> Bool
isValidFieldValue value =
    case value of
        TodoField -> False
        WarningMessage msg -> False
        anyOther -> True
    

getFieldValueAsStringList : FieldValue -> List String
getFieldValueAsStringList value =
    case value of
        UrlListValue list ->
            list

        _ ->
            []


updateLocalizedString : String -> String -> FieldValue -> FieldValue
updateLocalizedString language value old =
    case old of
        LocalizedListValue oldValue ->
            oldValue
                |> List.filter (\v -> v.language /= language)
                |> (::) (LocalizedString.Model language value)
                |> LocalizedListValue

        _ ->
            old

upsertContributionValue: FieldValue -> TokenValue Contribution -> FieldValue
upsertContributionValue oldValue tokenContribution =
    case oldValue of
        ContributionValue tokens ->
            Token.upsert tokenContribution tokens |> ContributionValue
        otherwise ->
            WarningMessage "Something went wrong (upsertContributionValue)"


toStringFieldValue : FieldType -> String -> Int -> String -> FieldValue -> FieldValue
toStringFieldValue fieldType language tokenId value old =
    case fieldType of
        DateTimeType ->
            DateTimeValue value

        VersionType ->
            case Version.parse value of
                Ok version ->
                    VersionValue version
                Err msg ->
                    WarningMessage msg

        LanguageType ->
            LanguageValue value

        Dimension2DIntType ->
            value |> toDimension2DInt (Dimension2DInt 0 0) |> Dimension2DIntValue

        ListBoxType any ->
            ListBoxValue value

        ShortLocalizedListType ->
            updateLocalizedString language value old

        MediumLocalizedType ->
            updateLocalizedString language value old

        TextAreaLocalizedType ->
            updateLocalizedString language value old

        BinaryDataType ->
            BinaryDataValue (ProxyImage value)

        ChromaType ->
            ChromaValue (toChroma value)

        UrlListType ->
            getFieldValueAsStringList old |> (::) value |> UrlListValue

        InterlocutorType ->
            TodoField
        
        IdType ->
            TodoField
        
        CompositionType ->
            TodoField

        ContributionType ->
            TodoField

        LayoutType ->
            TodoField

        TranscriptType ->
            TodoField

