module Dalmatian.Editor.Persistence exposing(StoreValue, findByPanelKey, updateStoreKeyValue, savePanelKey, deletePanelKey)

import Dalmatian.Editor.Schema exposing(appUI, FieldType(..), PredicateKey, ScreenZone, FieldKey, PanelKey)
import Dalmatian.Editor.Identifier exposing (Id(..))
import Dalmatian.Editor.Compositing exposing (Composition, BinaryData)
import Dalmatian.Editor.Speech exposing (Interlocutor, Transcript)
import Dalmatian.Editor.Coloring exposing (Chroma)
import Dalmatian.Editor.Speech exposing (Interlocutor, Transcript)
import Dalmatian.Editor.LocalizedString exposing (Model)
import Dalmatian.Editor.Unit exposing (Fraction, Position2D, Dimension2D, Position2DInt, Dimension2DInt, toDimension2DInt)
import Dalmatian.Editor.Tiling exposing (TileInstruction)
import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Contributing exposing (Contribution)

type FieldValue = ShortLocalizedListValue (List LocalizedString.Model)
    | MediumLocalizedValue (List LocalizedString.Model)
    | TextAreaLocalizedValue (List LocalizedString.Model)
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

toStringFieldValue: FieldType -> String -> FieldValue
toStringFieldValue fieldType value =
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
        _ ->
            TodoField