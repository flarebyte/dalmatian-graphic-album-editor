module Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), ListBoxItem, PanelKey, PanelZone(..), PredicateKey(..), SchemaUI(..), ScreenZone(..), UIEvent(..), appUI, formatList, mediumList)


type alias ListBoxItem =
    { value : String
    , display : String
    }


mediumList =
    [ ListBoxItem "dlm:medium/monochrome/brochure" "Monochrome brochure"
    , ListBoxItem "dlm:medium/polychrome/brochure" "Polychrome brochure"
    , ListBoxItem "dlm:medium/monochrome/screen" "Monochrome screen"
    , ListBoxItem "dlm:medium/polychrome/screen" "Polychrome screen"
    ]


formatList =
    [ ListBoxItem "dlm:format/a5" "A5"
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


type FieldType
    = ShortLocalizedListType
    | MediumLocalizedType
    | TextAreaLocalizedType
    | IdType
    | UrlListType
    | DateTimeType
    | VersionType
    | LanguageType
    | ChromaType
    | CompositionType
    | BinaryDataType
    | Dimension2DIntType
    | ContributionType
    | ListBoxType (List ListBoxItem)
    | LayoutType
    | InterlocutorType
    | TranscriptType


type ScreenZone
    = GraphicAlbumScreen
    | RightsScreen
    | ContributionScreen
    | ContributorScreen
    | ColorScreen
    | FontScreen
    | IllustrationScreen
    | StencilScreen
    | SpeechScreen
    | PublishedWorkScreen
    | LanguageScreen
    | CharacterScreen


type PanelZone
    = CopyrightsPanel
    | DefaultPanel
    | LicensePanel
    | ContributorListPanel
    | ContributorEditPanel
    | AttributionPanel
    | StencilListPanel
    | StencilEditPanel
    | FontListPanel
    | FontEditPanel
    | ColorListPanel
    | ColorEditPanel
    | CharacterListPanel
    | CharacterEditPanel
    | SpeechListPanel
    | SpeechEditPanel
    | PublishedListPanel
    | PublishedEditPanel


type PredicateKey
    = IdKey
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
    | CompositingKey


type SchemaUI
    = SchemaField PredicateKey String FieldType -- name description
    | ScreenUI ScreenZone String
    | PanelUI PanelZone String
    | ExclusivePanelUI PanelZone String
    | ListManagerUI
    | SaveAsTemplateUI


type UIEvent
    = OnNewPanelUI PanelKey
    | OnLoadPanelUI PanelKey
    | OnDeletePanelKey PanelKey
    | OnSavePanelKey
    | OnChangeField FieldKey String
    | OnSelectComplexField FieldKey
    | OnNewToken
    | OnSelectToken Int
    | OnDeleteToken
    | OnSaveToken
    | OnMoveTokenUp
    | OnMoveTokenDown


appUI =
    [ ScreenUI GraphicAlbumScreen "Graphic Album" --
    , SchemaField VersionKey "Version of the album" VersionType
    , SchemaField CreatedKey "Date the album was first created" DateTimeType
    , SchemaField ModifiedKey "Date the album was officially modified" DateTimeType
    , SchemaField TitleKey "Official title of the album" MediumLocalizedType
    , SchemaField DescriptionKey "Official description of the album" TextAreaLocalizedType
    , SchemaField KeywordKey "Keywords that describe the nature of the content" ShortLocalizedListType
    , ScreenUI RightsScreen "Rights and License" --
    , PanelUI LicensePanel "License"
    , SaveAsTemplateUI
    , SchemaField NameKey "Common name for the license" MediumLocalizedType
    , SchemaField DescriptionKey "Details of the license" TextAreaLocalizedType
    , SchemaField HomepageKey "Webpages linking to the license" UrlListType
    , PanelUI CopyrightsPanel "Rights"
    , SaveAsTemplateUI
    , SchemaField NameKey "Copyright name" MediumLocalizedType
    , SchemaField DescriptionKey "Copyrights detailed description" TextAreaLocalizedType
    , SchemaField HomepageKey "Webpages linking to the copyrights" UrlListType
    , PanelUI AttributionPanel "Attribution"
    , SchemaField NameKey "Short attribution" MediumLocalizedType
    , SchemaField DescriptionKey "Detailed attribution" TextAreaLocalizedType
    , SchemaField HomepageKey "Webpages linking to the attributions" UrlListType
    , ScreenUI ContributionScreen "Contribution" --
    , SchemaField ContributionKey "Credits" ContributionType
    , ScreenUI IllustrationScreen "Illustration"
    , SchemaField DimensionKey "Dimension of the image" Dimension2DIntType
    , SchemaField DataKey "Reference image" BinaryDataType
    , ScreenUI ContributorScreen "Contributor" --
    , ExclusivePanelUI ContributorListPanel "List of contributors"
    , ListManagerUI
    , ExclusivePanelUI ContributorEditPanel "Edit Contributor"
    , SchemaField NameKey "Name of the contributor" MediumLocalizedType
    , SchemaField DescriptionKey "Description of the contributor" TextAreaLocalizedType
    , SchemaField HomepageKey "Links to webpages about the contributor" UrlListType
    , ScreenUI StencilScreen "Stencil" --
    , ExclusivePanelUI StencilListPanel "List of stencils"
    , ListManagerUI
    , ExclusivePanelUI StencilEditPanel "Edit stencil"
    , SchemaField CompositingKey "Compositing of several illustrations" CompositionType
    , ScreenUI FontScreen "Font" --
    , ExclusivePanelUI FontListPanel "List of fonts"
    , ListManagerUI
    , ExclusivePanelUI FontEditPanel "Edit font"
    , SchemaField NameKey "Common name for the font" MediumLocalizedType
    , SchemaField DescriptionKey "Description of the font" TextAreaLocalizedType
    , SchemaField HomepageKey "Links to font" UrlListType
    , ScreenUI ColorScreen "Color" --
    , ExclusivePanelUI ColorListPanel "List of colors"
    , ListManagerUI
    , ExclusivePanelUI ColorEditPanel "Edit color"
    , SchemaField NameKey "Common name for the color" MediumLocalizedType
    , SchemaField DescriptionKey "Description of the color" TextAreaLocalizedType
    , SchemaField SameAsKey "Links to that font on encyclopedy sites" UrlListType
    , SchemaField PrintColorKey "The best color used for print" ChromaType
    , SchemaField ScreenColorKey "The best color used for screen" ChromaType
    , ScreenUI CharacterScreen "Character" --
    , ExclusivePanelUI CharacterListPanel "List of characters"
    , ListManagerUI
    , ExclusivePanelUI CharacterEditPanel "Edit character"
    , SchemaField NameKey "Name of the character" MediumLocalizedType
    , SchemaField DescriptionKey "Description of the character" TextAreaLocalizedType
    , SchemaField HomepageKey "Links to webpages about this character" UrlListType
    , ScreenUI SpeechScreen "Speech" --
    , ExclusivePanelUI SpeechListPanel "List of speech"
    , ListManagerUI
    , ExclusivePanelUI SpeechEditPanel "Edit speech"
    , SchemaField InterlocutorKey "The different interlocutors in the speech bubble" InterlocutorType
    , SchemaField TranscriptKey "The transcript of the speech bubble with formatting" TranscriptType
    , ScreenUI PublishedWorkScreen "Published Work" --
    , ExclusivePanelUI PublishedListPanel "List of published works"
    , ListManagerUI
    , ExclusivePanelUI PublishedEditPanel "Edit published work"
    , SchemaField VersionKey "Version of the published work" VersionType
    , SchemaField TitleKey "Title if different than album" MediumLocalizedType
    , SchemaField DescriptionKey "Description if different than album" TextAreaLocalizedType
    , SchemaField LanguageKey "The language of the published work" LanguageType
    , SchemaField MediumKey "Material or physical carrier" (ListBoxType mediumList)
    , SchemaField FormatKey "File format, physical medium, or dimensions" (ListBoxType formatList)
    , SchemaField LayoutKey "Layout of the album" LayoutType
    ]


type alias PanelKey =
    { screen : ScreenZone
    , panel : PanelZone
    , language : String
    , uid : Int
    }


type alias FieldKey =
    { panelKey : PanelKey
    , key : PredicateKey
    , fieldType : FieldType
    }
