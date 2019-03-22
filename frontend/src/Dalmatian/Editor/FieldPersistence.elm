module Dalmatian.Editor.FieldPersistence exposing (FieldValue(..), 
    getNextRank, 
    getPreviousRank, 
    isValidFieldValue, 
    toStringFieldValue,
    updateRank)
import Parser exposing(run)
import Dalmatian.Editor.Dialect.Coloring as Coloring exposing (Chroma)
import Dalmatian.Editor.Compositing exposing (BinaryData(..), Composition)
import Dalmatian.Editor.Contributing as Contributing exposing (Contribution)
import Dalmatian.Editor.Dialect.Identifier exposing (Id(..))
import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Schema exposing (FieldType(..))
import Dalmatian.Editor.Speech exposing (Interlocutor, Transcript, fromStringInterlocutor)
import Dalmatian.Editor.Tiling exposing (TileInstruction)
import Dalmatian.Editor.Token as Token exposing (TokenValue)
import Dalmatian.Editor.Dialect.Dimension2DIntUnit as Dimension2DIntUnit exposing (Dimension2DInt)
import Dalmatian.Editor.Dialect.Version as Version exposing (SemanticVersion)


type FieldValue
    = LocalizedListValue (List LocalizedString.Model)
    | IdValue Id
    | VersionValue SemanticVersion
    | UrlListValue (List String)
    | DateTimeValue String
    | LanguageValue String
    | ChromaValue Chroma
    | BinaryDataValue BinaryData
    | Dimension2DIntValue Dimension2DInt
    | ListBoxValue String
    | CompositionValue (List (TokenValue Composition))
    | ContributionValue (List (TokenValue Contribution))
    | LayoutValue (List (TokenValue TileInstruction))
    | InterlocutorValue (List (TokenValue Interlocutor))
    | TranscriptValue (List (TokenValue Transcript))
    | WarningMessage String
    | TodoField
    | NoValue


isValidFieldValue : FieldValue -> Bool
isValidFieldValue value =
    case value of
        TodoField ->
            False

        WarningMessage msg ->
            False

        anyOther ->
            True


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


-- upsertContributionValue : FieldValue -> TokenValue Contribution -> FieldValue
-- upsertContributionValue oldValue tokenContribution =
--     case oldValue of
--         ContributionValue tokens ->
--             Token.upsert tokenContribution tokens |> ContributionValue

--         otherwise ->
--             WarningMessage "Something went wrong (upsertContributionValue)"


getNextRank : Int -> FieldValue -> Int
getNextRank start fieldValue =
    case fieldValue of
        CompositionValue tokens ->
            Token.getNextRank start tokens

        ContributionValue tokens ->
            Token.getNextRank start tokens

        LayoutValue tokens ->
            Token.getNextRank start tokens

        InterlocutorValue tokens ->
            Token.getNextRank start tokens

        TranscriptValue tokens ->
            Token.getNextRank start tokens

        otherwise ->
            1000


getPreviousRank : Int -> FieldValue -> Int
getPreviousRank start fieldValue =
    case fieldValue of
        CompositionValue tokens ->
            Token.getPreviousRank start tokens

        ContributionValue tokens ->
            Token.getPreviousRank start tokens

        LayoutValue tokens ->
            Token.getPreviousRank start tokens

        InterlocutorValue tokens ->
            Token.getPreviousRank start tokens

        TranscriptValue tokens ->
            Token.getPreviousRank start tokens

        otherwise ->
            1000


updateRank : Int -> Int -> FieldValue -> FieldValue
updateRank tokenId rank fieldValue =
    case fieldValue of
        CompositionValue tokens ->
            Token.updateRank tokens tokenId rank |> CompositionValue

        ContributionValue tokens ->
            Token.updateRank tokens tokenId rank |> ContributionValue

        LayoutValue tokens ->
            Token.updateRank tokens tokenId rank |> LayoutValue

        InterlocutorValue tokens ->
            Token.updateRank tokens tokenId rank |> InterlocutorValue

        TranscriptValue tokens ->
            Token.updateRank tokens tokenId rank |> TranscriptValue

        otherwise ->
            WarningMessage "Something went wrong (updateRank)"


toStringFieldValue : FieldType -> String -> Int -> String -> FieldValue -> FieldValue
toStringFieldValue fieldType language tokenId value old =
    case fieldType of
        DateTimeType ->
            DateTimeValue value

        VersionType ->
            case run Version.parser value of
                Ok version ->
                    VersionValue version

                Err msg ->
                    WarningMessage "The format for version is invalid"

        LanguageType ->
            LanguageValue value

        Dimension2DIntType ->
           case run Dimension2DIntUnit.parser value of
                Ok dim ->
                    Dimension2DIntValue dim

                Err msg ->
                    WarningMessage "The format for dimension is invalid"

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
            case Coloring.parse value of
                Ok chroma ->
                    ChromaValue chroma

                Err msg ->
                    WarningMessage msg
                    
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
