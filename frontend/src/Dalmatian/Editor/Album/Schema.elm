module Dalmatian.Album.Schema exposing (dalmatianUI)

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
   SchemaField String String FieldType  -- name description
   | SchemaListField String String FieldType  -- name description
   | ScreenUI String
   | PanelUI String
   | ExclusivePanelUI String
   | ListManagerUI String
   | SaveAsTemplateUI

dalmatianUI = [ 
    ScreenUI "Graphic Album" --
    , SchemaField "version" "Version of the album" VersionType
    , SchemaField "created" "Date the album was first created" DateTimeType
    , SchemaField "modified" "Date the album was officially modified" DateTimeType
    , SchemaField "title" "Official title of the album" MediumLocalizedType
    , SchemaField "description" "Official description of the album" TextAreaLocalizedType
    , SchemaListField "language" "List of supported languages" LanguageType
    , SchemaListField "keyword" "Keywords that describe the nature of the content" ShortLocalizedType
    , ScreenUI "Rights and License" --
    , PanelUI "License"
    , SaveAsTemplateUI
    , SchemaField "name" "Common name for the license" MediumLocalizedType
    , SchemaField "description" "Details of the license" TextAreaLocalizedType
    , SchemaListField "homepage" "Webpages linking to the license" UrlType
    , PanelUI "Rights"
    , SaveAsTemplateUI
    , SchemaField "name" "Copyright name" MediumLocalizedType
    , SchemaField "description" "Copyrights detailed description" TextAreaLocalizedType
    , SchemaListField "homepage" "Webpages linking to the copyrights" UrlType
    , PanelUI "Attribution"
    , SchemaField "name" "Short attribution" MediumLocalizedType
    , SchemaField "description" "Detailed attribution" TextAreaLocalizedType
    , SchemaListField "homepage" "Webpages linking to the attributions" UrlType
    , ScreenUI "Contribution" --
    , SchemaField "contribution" "Credits" ContributionType
    , ScreenUI "Illustration"
    , SchemaField "dimension" "Dimension of the image" Dimension2DIntType
    , SchemaField "data" "Reference image" BinaryDataType
    , ScreenUI "Stencil" --
    , ExclusivePanelUI "List of stencils"
    , ListManagerUI "stencil"
    , ExclusivePanelUI "Edit stencil"
    , SchemaField "compositing" "Compositing of several illustrations" CompositionType
    , ScreenUI "Font" --
    , ExclusivePanelUI "List of fonts"
    , ListManagerUI "font"
    , ExclusivePanelUI "Edit font"
    , SchemaField "name" "Common name for the font" MediumLocalizedType
    , SchemaField "description" "Description of the font" TextAreaLocalizedType
    , SchemaListField "homepage" "Links to font" UrlType
    , ScreenUI "Color" --
    , ExclusivePanelUI "List of colors"
    , ListManagerUI "color"
    , ExclusivePanelUI "Edit color"
    , SchemaField "name" "Common name for the color" MediumLocalizedType
    , SchemaField "description" "Description of the color" TextAreaLocalizedType
    , SchemaListField "sameAs" "Links to that font on encyclopedy sites" UrlType
    , SchemaField "printColor" "The best color used for print" ChromaType
    , SchemaField "screenColor" "The best color used for screen" ChromaType
    , ScreenUI "Character" --
    , ExclusivePanelUI "List of characters"
    , ListManagerUI "character"
    , ExclusivePanelUI "Edit character"
    , SchemaField "name" "Name of the character" MediumLocalizedType
    , SchemaField "description" "Description of the character" TextAreaLocalizedType
    , SchemaListField "homepage" "Links to webpages about this character" UrlType
    , ScreenUI "Speech" --
    , ExclusivePanelUI "List of speech"
    , ListManagerUI "speech"
    , ExclusivePanelUI "Edit speech"
    , SchemaField "interlocutor" "The different interlocutors in the speech bubble" InterlocutorType
    , SchemaField "transcript" "The transcript of the speech bubble with formatting" TranscriptType
    , ScreenUI "Published Work" --
    , ExclusivePanelUI "List of published works"
    , ListManagerUI "publishedWork"
    , ExclusivePanelUI "Edit published work"
    , SchemaField "version" "Version of the published work" VersionType
    , SchemaField "title" "Title if different than album" MediumLocalizedType
    , SchemaField "description" "Description if different than album" TextAreaLocalizedType
    , SchemaListField "language" "The language of the published work" LanguageType
    , SchemaField "medium" "Material or physical carrier" (ListBoxType mediumList)
    , SchemaField "format" "File format, physical medium, or dimensions" (ListBoxType formatList)
    , SchemaField "layout" "Layout of the album" LayoutType
    ]


