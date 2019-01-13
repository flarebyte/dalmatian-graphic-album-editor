module Dalmatian.Editor.Persistence exposing(StoreValue, findByPanelKey, updateStoreKeyValue, savePanelKey, deletePanelKey)

import Dalmatian.Editor.Schema exposing(appUI, FieldType(..), PredicateKey, ScreenZone, FieldKey, PanelKey)
import Dalmatian.Editor.Identifier exposing (Id(..))
import Dalmatian.Editor.Compositing exposing (Composition, BinaryData(..))
import Dalmatian.Editor.Speech exposing (Interlocutor, Transcript)
import Dalmatian.Editor.Coloring exposing (Chroma, toChroma)
import Dalmatian.Editor.Speech exposing (Interlocutor, Transcript)
import Dalmatian.Editor.LocalizedString exposing (Model)
import Dalmatian.Editor.Unit exposing (Fraction, Position2D, Dimension2D, Position2DInt, Dimension2DInt, toDimension2DInt)
import Dalmatian.Editor.Tiling exposing (TileInstruction)
import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Contributing exposing (Contribution)

type FieldValue = LocalizedListValue (List LocalizedString.Model)
    | IdValue Id
    | VersionValue String
    | UrlListValue (List String)
    | DateTimeValue String
    | LanguageValue String
    | ChromaValue Chroma
    | CompositionValue (List Composition)
    | BinaryDataValue BinaryData
    | Dimension2DIntValue Dimension2DInt
    | ContributionValue (List Contribution)
    | ListBoxValue String
    | LayoutValue (List TileInstruction)
    | InterlocutorValue (List Interlocutor)
    | TranscriptValue (List Transcript)
    | TodoField
    | WarningMessage String

type alias StoreValue = {
     key: FieldKey
     , value: FieldValue
    }

findByPanelKey: PanelKey -> List StoreValue -> List StoreValue
findByPanelKey key list = list

savePanelKey: List StoreValue -> List StoreValue -> List StoreValue
savePanelKey newValues oldValues =
    oldValues

deletePanelKey: PanelKey -> List StoreValue -> List StoreValue
deletePanelKey key list = list

updateStoreKeyValue: FieldKey -> (List String) -> List StoreValue -> List StoreValue
updateStoreKeyValue key values list = list

updateLocalizedString: String -> String -> FieldValue -> FieldValue
updateLocalizedString language value old =
    case old of
        LocalizedListValue oldValue ->
            oldValue 
                |> List.filter (\v -> v.language /= language) 
                |> (::) (LocalizedString.Model language value) 
                |> LocalizedListValue
        _ ->
            old


toStringFieldValue: FieldType -> String -> String -> FieldValue -> FieldValue
toStringFieldValue fieldType language value old =
    case fieldType of
        DateTimeType ->
            DateTimeValue value
        VersionType ->
            VersionValue value
        LanguageType ->
            LanguageValue value
        Dimension2DIntType ->
            value |> toDimension2DInt (Dimension2DInt 0 0)|> Dimension2DIntValue
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
        _ ->
            TodoField