module Dalmatian.Album.Schema exposing (Model)

type alias ListBoxItem = {
    value: String
    , display: String
}

mediumList = [
    ListBoxItem "dlm:medium/monochrome/brochure" "Monochrome brochure"
    , ListBoxItem "dlm:medium/polychrome/brochure" "Polychrome brochure"
    , ListBoxItem "dlm:medium/monochrome/screen" "Monochrome screen"
    , ListBoxItem "dlm:medium/polychrome/screen" "Polychrome screen"
    ]

formatList = [
    ListBoxItem "dlm:format/a5" "A5"
    , ListBoxItem "dlm:format/a4" "A4"
    , ListBoxItem "dlm:format/a3" "A3"
    , ListBoxItem "dlm:format/comic-book" "Comic Book (6.63 x 10.25 inch)"
    , ListBoxItem "dlm:format/us-trade" "US Trade ( 6 x 9 inch)"
    , ListBoxItem "dlm:format/us-letter" "US Letter (8.5 x 11 inch)"
    , ListBoxItem "dlm:format/square-8.5" "Square (8.5 x 8.5 inch)"
    , ListBoxItem "dlm:format/japanese-b6" "Japanese B6"
    , ListBoxItem "dlm:format/screen/landscape" "Screen Landscape"
    , ListBoxItem "dlm:format/screen/portrait" "Screen Portrait"
    ]

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
   | ExclusivePanelUI String
   | ListManagerUI String

dalmatianUI = [ 
    ScreenUI "Graphic Album" --
    , SchemaField "version" VersionType
    , SchemaField "created" DateTimeType
    , SchemaField "modified" DateTimeType
    , SchemaField "title" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "language" LanguageType
    , SchemaListField "keyword" ShortLocalizedType
    , ScreenUI "Rights and License" --
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
    , ScreenUI "Contribution" --
    , SchemaField "contribution" ContributionType
    , ScreenUI "Illustration"
    , SchemaField "dimension" Dimension2DIntType
    , SchemaField "data" BinaryDataType
    , ScreenUI "Stencil" --
    , ExclusivePanelUI "List of stencils"
    , ListManagerUI "stencil"
    , ExclusivePanelUI "Edit stencil"
    , SchemaField "compositing" CompositionType
    , ScreenUI "Font" --
    , ExclusivePanelUI "List of fonts"
    , ListManagerUI "font"
    , ExclusivePanelUI "Edit font"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "homepage" UrlType
    , SchemaListField "sameAs" UrlType
    , ScreenUI "Color" --
    , ExclusivePanelUI "List of colors"
    , ListManagerUI "color"
    , ExclusivePanelUI "Edit color"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "sameAs" UrlType
    , SchemaField "printColor" ChromaType
    , SchemaField "screenColor" ChromaType
    , ScreenUI "Character" --
    , ExclusivePanelUI "List of characters"
    , ListManagerUI "character"
    , ExclusivePanelUI "Edit character"
    , SchemaField "name" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "homepage" UrlType
    , SchemaListField "sameAs" UrlType
    , ScreenUI "Speech" --
    , ExclusivePanelUI "List of speech"
    , ListManagerUI "speech"
    , ExclusivePanelUI "Edit speech"
    , SchemaField "interlocutor" InterlocutorType
    , SchemaField "transcript" TranscriptType
    , ScreenUI "Published Work" --
    , ExclusivePanelUI "List of published works"
    , ListManagerUI "publishedWork"
    , ExclusivePanelUI "Edit published work"
    , SchemaField "interlocutor" InterlocutorType
    , SchemaField "version" VersionType
    , SchemaField "title" MediumLocalizedType
    , SchemaField "description" TextAreaLocalizedType
    , SchemaListField "language" LanguageType
    , SchemaField "medium" (ListBoxType mediumList)
    , SchemaField "format" (ListBoxType formatList)
    , SchemaField "layout" LayoutType
    ]


