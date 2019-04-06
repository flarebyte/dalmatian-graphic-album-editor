module Dalmatian.Editor.FieldPersistence exposing (FieldValue(..)
    , updateFieldValue, reshapeFieldValue)

{-| Manage operations on a field.

    Possible operations:
    * set a field value
    * add an item to field
    * remove an item to field
    * clear all items
    * insert an item at a specific position
    * swap two items

-}

import Parser exposing(run)
import Dalmatian.Editor.Dialect.Coloring as Coloring exposing (Chroma)
import Dalmatian.Editor.Tokens.Compositing exposing (BinaryData(..), Composition)
import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Schema exposing (FieldType(..))
import Dalmatian.Editor.Tokens.Speech exposing (Interlocutor, Transcript, fromStringInterlocutor)
import Dalmatian.Editor.Tokens.Tiling exposing (TileInstruction)
import Dalmatian.Editor.Tokens.Token as Token exposing (TokenValue)
import Dalmatian.Editor.Dialect.Dimension2DIntUnit as Dimension2DIntUnit exposing (Dimension2DInt)
import Dalmatian.Editor.Dialect.Version as Version exposing (SemanticVersion)
import Dalmatian.Editor.Dialect.LanguageIdentifier as LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.AppContext as AppContext
import Dalmatian.Editor.Selecting as Selecting exposing (UISelector(..))

type FieldValue
    = LocalizedListValue (List LocalizedString.Model)
    | VersionValue SemanticVersion
    | UrlListValue (List String)
    | DateTimeValue String
    | LanguageValue LanguageId
    | ChromaValue Chroma
    | BinaryDataValue BinaryData
    | Dimension2DIntValue Dimension2DInt
    | ListBoxValue String
    | CompositionValue (List (TokenValue Composition))
    | LayoutValue (List (TokenValue TileInstruction))
    | InterlocutorValue (List (TokenValue Interlocutor))
    | TranscriptValue (List (TokenValue Transcript))
    | WarningMessage String
    | TodoField
    | NoValue

getFieldValueAsStringList : FieldValue -> List String
getFieldValueAsStringList value =
    case value of
        UrlListValue list ->
            list

        _ ->
            []


updateLocalizedString : LanguageId -> String -> FieldValue -> FieldValue
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

        LayoutValue tokens ->
            Token.updateRank tokens tokenId rank |> LayoutValue

        InterlocutorValue tokens ->
            Token.updateRank tokens tokenId rank |> InterlocutorValue

        TranscriptValue tokens ->
            Token.updateRank tokens tokenId rank |> TranscriptValue

        otherwise ->
            WarningMessage "Something went wrong (updateRank)"

updateFieldValue : AppContext.Model -> UISelector -> String -> FieldValue -> FieldValue
updateFieldValue appContext selector value old =
    case (Selecting.toFieldType selector) of
        Just DateTimeType ->
            DateTimeValue value

        Just  VersionType ->
            case run Version.parser value of
                Ok version ->
                    VersionValue version

                Err msg ->
                    WarningMessage "The format for version is invalid"

        Just LanguageType ->
            case run LanguageIdentifier.parser value of
                Ok lang ->
                    LanguageValue lang

                Err msg ->
                    WarningMessage "The format for language is invalid"

        Just Dimension2DIntType ->
           case run Dimension2DIntUnit.parser value of
                Ok dim ->
                    Dimension2DIntValue dim

                Err msg ->
                    WarningMessage "The format for dimension is invalid"

        Just (ListBoxType any) ->
            ListBoxValue value

        Just  ShortLocalizedListType ->
            updateLocalizedString (selector |> Selecting.toLanguage) value old

        Just  MediumLocalizedType ->
            updateLocalizedString (selector |> Selecting.toLanguage) value old

        Just TextAreaLocalizedType ->
            updateLocalizedString (selector |> Selecting.toLanguage) value old

        Just  BinaryDataType ->
            BinaryDataValue (ProxyImage value)

        Just  ChromaType ->
            case run Coloring.parser value of
                Ok chroma ->
                    ChromaValue chroma

                Err msg ->
                    WarningMessage "The format for color is invalid"
                    
        Just UrlListType ->
            getFieldValueAsStringList old |> (::) value |> UrlListValue

        Just  InterlocutorType ->
            TodoField

        Just CompositionType ->
            TodoField

        Just ContributionType ->
            TodoField

        Just LayoutType ->
            TodoField

        Just TranscriptType ->
            TodoField
        
        Nothing ->
            WarningMessage "Could not infer the field type"

reshapeFieldValue : AppContext.Model -> UISelector -> FieldValue -> FieldValue
reshapeFieldValue appContext selector old =
    case (Selecting.toFieldType selector) of
 
        Just  InterlocutorType ->
            TodoField

        Just CompositionType ->
            TodoField

        Just ContributionType ->
            TodoField

        Just LayoutType ->
            TodoField

        Just TranscriptType ->
            TodoField

        Just otherwise ->
            WarningMessage "Reshape is not applicable"
        
        Nothing ->
            WarningMessage "Could not infer the field type"
