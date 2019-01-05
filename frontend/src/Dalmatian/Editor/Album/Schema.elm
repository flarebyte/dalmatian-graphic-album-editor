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
    | Versionype  
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


type SchemaUI =
   SchemaField String FieldType  -- name
   | SchemaListField String FieldType  -- name
   | ScreenUI String
   | PanelUI String

dalmatianUI = [ 
    ScreenUI "Graphic Album"
    , SchemaField "version" VersionType
    , SchemaField "created" DateTimeType
    , SchemaField "modified" DateTimeType
    , SchemaField "title" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "language" LanguageType
    , SchemaListField "keyword" ShortLocalizedType
    , ScreenUI "Rights"
    , PanelUI "License"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "homepage" UrlType
    , SchemaListField "sameAs" UrlType
    , PanelUI "Rights"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "homepage" UrlType
    , SchemaListField "sameAs" UrlType
    , PanelUI "Attribution"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "homepage" UrlType
    , SchemaListField "sameAs" UrlType    
    , ScreenUI "Contribution"
    , SchemaField "contribution" ContributionType
    , ScreenUI "Illustration"
    , SchemaField "dimension" Dimension2DIntType
    , SchemaField "data" BinaryDataType
    , ScreenUI "Stencil"
    , SchemaField "compositing" CompositionType
    , ScreenUI "Font"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "homepage" UrlType
    , SchemaListField "sameAs" UrlType
    , ScreenUI "Color"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "sameAs" UrlType
    , SchemaField "printColor" ChromaType
    , SchemaField "screenColor" ChromaType
    , ScreenUI "Character"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "homepage" UrlType
    , SchemaListField "sameAs" UrlType
    , ScreenUI "Speech"
    , SchemaField "interlocutor" InterlocutorType
    , SchemaField "transcript" TranscriptType
    , ScreenUI "PublishedWork"
    , SchemaField "interlocutor" InterlocutorType
    , SchemaField "version" VersionType
    , SchemaField "title" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "language" LanguageType
    , SchemaField "medium" (ListBoxType mediumList)
    , SchemaField "format" (ListBoxType formatList)
    , SchemaField "layout" LayoutType
    ]


