module Dalmatian.Album.Schema exposing (Model)

import Dalmatian.Album.LocalizedString as LocalizedString
import Dalmatian.Album.Identifier exposing (Id)
import Dalmatian.Album.Unit exposing (Fraction)

type alias ListBoxItem = {
    value: String
    , display: String
}

type FieldType = ShortLocalizedType 
    | MediumLocalizedType
    | TextAreaLocalizedType 
    | IdType 
    | UrlType 
    | DateTimeType 
    | VersionType
    | LanguageType
    | ChromaType
    | CompositionType
    | BinaryDataType
    | Dimension2DIntType
    | ContributionType
    | ListBoxType (ListBoxItem)
    | LayoutType
    | InterlocutorType
    | TranscriptType


type SchemaField =
   SchemaField FieldType String Bool  -- name isList
