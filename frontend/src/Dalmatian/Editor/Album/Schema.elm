module Dalmatian.Album.Schema exposing (appUI, Zone, FieldType, PredicateKey)

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

type Zone =
    GraphicAlbumZone
    | RightsZone
    | ContributionZone
    | ColorZone
    | FontZone
    | IllustrationZone
    | StencilZone
    | SpeechZone
    | PublishedWorkZone
    | LanguageZone
    | CharacterZone

type PredicateKey =
    IdKey
    | VersionKey
    | CreatedKey
    | ModifiedKey
    | TitleKey
    | DescriptionKey
    | LanguageKey
    | KeywordKey
    | HomepageKey
    | ContributionKey
    | DimensionKey
    | NameKey
    | DataKey
    | SameAsKey
    | PrintColorKey
    | ScreenColorKey
    | InterlocutorKey
    | TranscriptKey
    | MediumKey
    | FormatKey
    | LayoutKey

type SchemaUI =
   SchemaField PredicateKey String FieldType  -- name description
   | SchemaListField PredicateKey String FieldType  -- name description
   | ScreenUI Zone String
   | PanelUI String
   | ExclusivePanelUI String
   | ListManagerUI
   | SaveAsTemplateUI

appUI = [ 
    ScreenUI GraphicAlbumZone "Graphic Album" --
    , SchemaField VersionKey "Version of the album" VersionType
    , SchemaField CreatedKey "Date the album was first created" DateTimeType
    , SchemaField ModifiedKey "Date the album was officially modified" DateTimeType
    , SchemaField TitleKey "Official title of the album" MediumLocalizedType
    , SchemaField DescriptionKey "Official description of the album" TextAreaLocalizedType
    , SchemaListField LanguageKey "List of supported languages" LanguageType
    , SchemaListField KeywordKey "Keywords that describe the nature of the content" ShortLocalizedType
    , ScreenUI RightsZone "Rights and License" --
    , PanelUI "License"
    , SaveAsTemplateUI
    , SchemaField NameKey "Common name for the license" MediumLocalizedType
    , SchemaField DescriptionKey "Details of the license" TextAreaLocalizedType
    , SchemaListField HomepageKey "Webpages linking to the license" UrlType
    , PanelUI "Rights"
    , SaveAsTemplateUI
    , SchemaField NameKey "Copyright name" MediumLocalizedType
    , SchemaField DescriptionKey "Copyrights detailed description" TextAreaLocalizedType
    , SchemaListField HomepageKey "Webpages linking to the copyrights" UrlType
    , PanelUI "Attribution"
    , SchemaField NameKey "Short attribution" MediumLocalizedType
    , SchemaField DescriptionKey "Detailed attribution" TextAreaLocalizedType
    , SchemaListField HomepageKey"Webpages linking to the attributions" UrlType
    , ScreenUI ContributionZone "Contribution" --
    , SchemaField ContributionKey "Credits" ContributionType
    , ScreenUI "Illustration"
    , SchemaField DimensionKey "Dimension of the image" Dimension2DIntType
    , SchemaField DataKey "Reference image" BinaryDataType
    , ScreenUI StencilZone "Stencil" --
    , ExclusivePanelUI "List of stencils"
    , ListManagerUI
    , ExclusivePanelUI "Edit stencil"
    , SchemaField "compositing" "Compositing of several illustrations" CompositionType
    , ScreenUI FontZone "Font" --
    , ExclusivePanelUI "List of fonts"
    , ListManagerUI
    , ExclusivePanelUI "Edit font"
    , SchemaField NameKey "Common name for the font" MediumLocalizedType
    , SchemaField DescriptionKey "Description of the font" TextAreaLocalizedType
    , SchemaListField HomepageKey "Links to font" UrlType
    , ScreenUI ColorZone "Color" --
    , ExclusivePanelUI "List of colors"
    , ListManagerUI
    , ExclusivePanelUI "Edit color"
    , SchemaField NameKey "Common name for the color" MediumLocalizedType
    , SchemaField DescriptionKey "Description of the color" TextAreaLocalizedType
    , SchemaListField SameAsKey "Links to that font on encyclopedy sites" UrlType
    , SchemaField PrintColorKey "The best color used for print" ChromaType
    , SchemaField ScreenColorKey "The best color used for screen" ChromaType
    , ScreenUI CharacterZone "Character" --
    , ExclusivePanelUI "List of characters"
    , ListManagerUI
    , ExclusivePanelUI "Edit character"
    , SchemaField NameKey "Name of the character" MediumLocalizedType
    , SchemaField DescriptionKey "Description of the character" TextAreaLocalizedType
    , SchemaListField HomepageKey "Links to webpages about this character" UrlType
    , ScreenUI SpeechZone "Speech" --
    , ExclusivePanelUI "List of speech"
    , ListManagerUI
    , ExclusivePanelUI "Edit speech"
    , SchemaField InterlocutorKey "The different interlocutors in the speech bubble" InterlocutorType
    , SchemaField TranscriptKey "The transcript of the speech bubble with formatting" TranscriptType
    , ScreenUI PublishedWorkZone "Published Work" --
    , ExclusivePanelUI "List of published works"
    , ListManagerUI
    , ExclusivePanelUI "Edit published work"
    , SchemaField VersionKey "Version of the published work" VersionType
    , SchemaField TitleKey "Title if different than album" MediumLocalizedType
    , SchemaField  DescriptionKey "Description if different than album" TextAreaLocalizedType
    , SchemaListField LanguageKey "The language of the published work" LanguageType
    , SchemaField MediumKey "Material or physical carrier" (ListBoxType mediumList)
    , SchemaField FormatKey "File format, physical medium, or dimensions" (ListBoxType formatList)
    , SchemaField LayoutKey "Layout of the album" LayoutType
    ]


