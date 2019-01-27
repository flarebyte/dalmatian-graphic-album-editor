module Dalmatian.Editor.Persistence exposing (StoreValue, FieldValue(..), deleteByPanelKey, findByPanelKey, savePanelKey, updateStoreKeyValue, toStringFieldValue, isValidFieldValue, SemanticVersion)

import Parser exposing (Parser, (|.), (|=), succeed, symbol, int, spaces, run, getChompedString, map, chompWhile)
import Dalmatian.Editor.Coloring exposing (Chroma, toChroma)
import Dalmatian.Editor.Compositing exposing (BinaryData(..), Composition)
import Dalmatian.Editor.Contributing exposing (Contribution)
import Dalmatian.Editor.Identifier exposing (Id(..))
import Dalmatian.Editor.LocalizedString as LocalizedString exposing (Model)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PredicateKey, ScreenZone, appUI)
import Dalmatian.Editor.Speech exposing (Interlocutor, Transcript, fromStringInterlocutor)
import Dalmatian.Editor.Tiling exposing (TileInstruction)
import Dalmatian.Editor.Unit exposing (Dimension2D, Dimension2DInt, Fraction, Position2D, Position2DInt, toDimension2DInt)


type alias SemanticVersion =
  { major : Int
  , minor : Int
  , patch: Int
  }

type FieldValue
    = LocalizedListValue (List LocalizedString.Model)
    | IdValue Id
    | VersionValue SemanticVersion
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

type alias StoreValue =
    { key : FieldKey
    , value : FieldValue
    }


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


getFieldValueAsInterlocutorList : FieldValue -> List Interlocutor
getFieldValueAsInterlocutorList value =
    case value of
        InterlocutorValue list ->
            list

        _ ->
            []


findByPanelKey : PanelKey -> List StoreValue -> List StoreValue
findByPanelKey key list =
    List.filter (\store -> store.key.panelKey == key) list


deleteByPanelKey : PanelKey -> List StoreValue -> List StoreValue
deleteByPanelKey key list =
    List.filter (\store -> store.key.panelKey /= key) list


savePanelKey : PanelKey -> List StoreValue -> List StoreValue -> List StoreValue
savePanelKey key newValues oldValues =
    deleteByPanelKey key oldValues |> (++) newValues


updateStoreKeyValue : FieldKey -> List String -> List StoreValue -> List StoreValue
updateStoreKeyValue key values list =
    list


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

toIntOrZero: String -> Int
toIntOrZero str =
    String.toInt str |> Maybe.withDefault 0

versionParser : Parser SemanticVersion
versionParser =
  succeed SemanticVersion
    |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)
    |. symbol "."
    |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)
    |. symbol "."
    |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)

parseVersion: String -> FieldValue
parseVersion str =
    let 
        maybeVersion = run versionParser str
    in
        case maybeVersion of
            Ok foundVersion ->
                VersionValue foundVersion
            Err msg ->
                WarningMessage "The format for version should be like 1.0.0"


toStringFieldValue : FieldType -> String -> String -> FieldValue -> FieldValue
toStringFieldValue fieldType language value old =
    case fieldType of
        DateTimeType ->
            DateTimeValue value

        VersionType ->
            parseVersion value

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
            getFieldValueAsInterlocutorList old |> (::) (fromStringInterlocutor value) |> InterlocutorValue

        _ ->
            TodoField
