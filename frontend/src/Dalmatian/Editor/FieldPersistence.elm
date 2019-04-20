module Dalmatian.Editor.FieldPersistence exposing (FieldValue(..), isValid)

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
import Dalmatian.Editor.Tokens.Compositing exposing (Composition)
import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Schema exposing (FieldType(..))
import Dalmatian.Editor.Tokens.Speech exposing (Transcript)
import Dalmatian.Editor.Tokens.Tiling exposing (TileAssembling)
import Dalmatian.Editor.Dialect.Dimension2DIntUnit as Dimension2DIntUnit exposing (Dimension2DInt)
import Dalmatian.Editor.Dialect.Version as Version exposing (SemanticVersion)
import Dalmatian.Editor.Dialect.LanguageIdentifier as LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier exposing(ResourceId)
import Dalmatian.Editor.Selecting as Selecting exposing (UISelector(..))
import Dalmatian.Editor.FieldOperating as FieldOperating exposing (FieldOperation(..))
import Dalmatian.Editor.Snatching exposing (Snatch, LocalizedSnatches)

type FieldValue
    = LocalizedListValue (List LocalizedString.Model)
    | VersionValue SemanticVersion
    | UrlListValue (List String)
    | ResourceIdListValue (List ResourceId)
    | DateTimeValue String
    | LanguageValue LanguageId
    | ListBoxValue String
    | SnatchValue Int (List Snatch)
    | LocalizedSnatchesValue Int (List LocalizedSnatches)
    | WarningMessage String
    | TodoField
    | NoValue

toInfoString: FieldValue -> String
toInfoString fieldValue =
    case fieldValue of
        LocalizedListValue a -> "LocalizedListValue"
        VersionValue a -> "VersionValue"
        UrlListValue a -> "UrlListValue"
        ResourceIdListValue a -> "ResourceIdListValue"
        DateTimeValue a -> "DateTimeValue"
        LanguageValue a -> "LanguageValue"
        ListBoxValue a -> "ListBoxValue"
        SnatchValue a b -> "SnatchValue"
        LocalizedSnatchesValue a b -> "LocalizedSnatchesValue"
        WarningMessage a -> "WarningMessage"
        TodoField -> "TodoField"
        NoValue -> "NoValue"

isValid: FieldValue -> Bool
isValid fieldValue =
    case fieldValue of
        WarningMessage a -> False
        TodoField -> False
        NoValue -> False
        otherwise -> True

getFieldValueAsStringList : FieldValue -> List String
getFieldValueAsStringList value =
    case value of
        UrlListValue list ->
            list

        _ ->
            []

getFieldValueAsResourceIdList : FieldValue -> List ResourceId
getFieldValueAsResourceIdList value =
    case value of
        ResourceIdListValue list ->
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

warnUnsupportedOp: FieldOperation -> FieldValue -> FieldValue
warnUnsupportedOp fieldOp value =
    "Unsupported operation " ++ (FieldOperating.toString fieldOp) ++ "for " ++ (toInfoString value) |> WarningMessage

updateFieldValue : UISelector -> FieldOperation -> String -> FieldValue -> FieldValue
updateFieldValue selector fieldOp str old =
    case (Selecting.toFieldType selector) of
        Just DateTimeType ->
            case fieldOp of
                    SetValueOp ->
                        DateTimeValue str
                    otherwise ->
                        warnUnsupportedOp fieldOp old
 
        Just  VersionType ->
            case fieldOp of
                SetValueOp ->
                    case run Version.parser str of
                        Ok version ->
                            VersionValue version

                        Err msg ->
                            WarningMessage "The format for version is invalid"
                otherwise ->
                    warnUnsupportedOp fieldOp old

        Just LanguageType ->
            case fieldOp of
                SetValueOp ->
                    case run LanguageIdentifier.parser str of
                        Ok lang ->
                            LanguageValue lang

                        Err msg ->
                            WarningMessage "The format for language is invalid"

                otherwise ->
                    warnUnsupportedOp fieldOp old

        Just (ListBoxType any) ->
            case fieldOp of
                SetValueOp ->
                    ListBoxValue str
                otherwise ->
                        warnUnsupportedOp fieldOp old

        Just  ShortLocalizedListType ->
            case fieldOp of
                SetValueOp ->
                    updateLocalizedString (selector |> Selecting.toLanguage) str old
                otherwise ->
                        warnUnsupportedOp fieldOp old

        Just  MediumLocalizedType ->
            case fieldOp of
                SetValueOp ->
                    updateLocalizedString (selector |> Selecting.toLanguage) str old
                otherwise ->
                        warnUnsupportedOp fieldOp old

        Just TextAreaLocalizedType ->
            case fieldOp of
                SetValueOp ->
                    updateLocalizedString (selector |> Selecting.toLanguage) str old
                otherwise ->
                        warnUnsupportedOp fieldOp old
                   
        Just UrlListType ->
            case fieldOp of
                    AddValueOp ->
                        getFieldValueAsStringList old |> (::) str |> UrlListValue
                    RemoveValueOp ->
                        getFieldValueAsStringList old |> List.filter (\v -> v /= str) |> UrlListValue
                    otherwise ->
                        warnUnsupportedOp fieldOp old
       
        Just ResourceIdListType ->
            case fieldOp of
                    AddValueOp ->
                        getFieldValueAsResourceIdList old |> (::) (ResourceIdentifier.fromString str) |> ResourceIdListValue
                    RemoveValueOp ->
                        getFieldValueAsResourceIdList old |> List.filter (\v -> v /= (ResourceIdentifier.fromString str)) |> ResourceIdListValue
                    otherwise ->
                        warnUnsupportedOp fieldOp old
        Just (SnatchType a) ->
            TodoField

        Nothing ->
            WarningMessage "Could not infer the field type"

clearOrWarn: FieldOperation -> FieldValue -> FieldValue
clearOrWarn fieldOp old =
    case fieldOp of
        ClearOp ->
            TodoField
        otherwise ->
            warnUnsupportedOp fieldOp old

reshapeFieldValue : UISelector -> FieldOperation -> FieldValue -> FieldValue
reshapeFieldValue selector fieldOp old =
    case (Selecting.toFieldType selector) of
        Just DateTimeType ->
           clearOrWarn fieldOp old

        Just  VersionType ->
            clearOrWarn fieldOp old

        Just LanguageType ->
           clearOrWarn fieldOp old

        Just (ListBoxType any) ->
            clearOrWarn fieldOp old

        Just  ShortLocalizedListType ->
            clearOrWarn fieldOp old

        Just  MediumLocalizedType ->
            clearOrWarn fieldOp old

        Just TextAreaLocalizedType ->
           clearOrWarn fieldOp old
                    
        Just UrlListType ->
            clearOrWarn fieldOp old

        Just ResourceIdListType ->
            clearOrWarn fieldOp old

        Just (SnatchType a) ->
            clearOrWarn fieldOp old
  
        Nothing ->
            WarningMessage "Could not infer the field type"

