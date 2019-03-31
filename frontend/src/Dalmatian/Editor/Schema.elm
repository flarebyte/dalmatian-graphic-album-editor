module Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PanelZone(..), PredicateKey(..), SchemaUI(..), ScreenZone(..), UIEvent(..), DataId(..), appUI)

import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)

type DataId = MediumId | FormatId

type FieldType
    = ShortLocalizedListType
    | MediumLocalizedType
    | TextAreaLocalizedType
    | UrlListType
    | DateTimeType
    | VersionType
    | LanguageType
    | ChromaType
    | CompositionType
    | BinaryDataType
    | Dimension2DIntType
    | ContributionType
    | ListBoxType DataId
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
    = VersionKey
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
    = FieldUI PredicateKey String FieldType -- name description
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

type alias PanelKey =
    { screen : ScreenZone
    , panel : PanelZone
    , language : LanguageId
    , uid : Int
    }


type alias FieldKey =
    { panelKey : PanelKey
    , key : PredicateKey
    , fieldType : FieldType
    }


appUI =
    [ ScreenUI GraphicAlbumScreen "Graphic Album" --
    , FieldUI VersionKey "Version of the album" VersionType
    , FieldUI CreatedKey "Date the album was first created" DateTimeType
    , FieldUI ModifiedKey "Date the album was officially modified" DateTimeType
    , FieldUI TitleKey "Official title of the album" MediumLocalizedType
    , FieldUI DescriptionKey "Official description of the album" TextAreaLocalizedType
    , FieldUI KeywordKey "Keywords that describe the nature of the content" ShortLocalizedListType
    , ScreenUI RightsScreen "Rights and License" --
    , PanelUI LicensePanel "License"
    , SaveAsTemplateUI
    , FieldUI NameKey "Common name for the license" MediumLocalizedType
    , FieldUI DescriptionKey "Details of the license" TextAreaLocalizedType
    , FieldUI HomepageKey "Webpages linking to the license" UrlListType
    , PanelUI CopyrightsPanel "Rights"
    , SaveAsTemplateUI
    , FieldUI NameKey "Copyright name" MediumLocalizedType
    , FieldUI DescriptionKey "Copyrights detailed description" TextAreaLocalizedType
    , FieldUI HomepageKey "Webpages linking to the copyrights" UrlListType
    , PanelUI AttributionPanel "Attribution"
    , FieldUI NameKey "Short attribution" MediumLocalizedType
    , FieldUI DescriptionKey "Detailed attribution" TextAreaLocalizedType
    , FieldUI HomepageKey "Webpages linking to the attributions" UrlListType
    , ScreenUI ContributionScreen "Contribution" --
    , FieldUI ContributionKey "Credits" ContributionType
    , ScreenUI IllustrationScreen "Illustration"
    , FieldUI DimensionKey "Dimension of the image" Dimension2DIntType
    , FieldUI DataKey "Reference image" BinaryDataType
    , ScreenUI ContributorScreen "Contributor" --
    , ExclusivePanelUI ContributorListPanel "List of contributors"
    , ListManagerUI
    , ExclusivePanelUI ContributorEditPanel "Edit Contributor"
    , FieldUI NameKey "Name of the contributor" MediumLocalizedType
    , FieldUI DescriptionKey "Description of the contributor" TextAreaLocalizedType
    , FieldUI HomepageKey "Links to webpages about the contributor" UrlListType
    , ScreenUI FontScreen "Font" --
    , ExclusivePanelUI FontListPanel "List of fonts"
    , ListManagerUI
    , ExclusivePanelUI FontEditPanel "Edit font"
    , FieldUI NameKey "Common name for the font" MediumLocalizedType
    , FieldUI DescriptionKey "Description of the font" TextAreaLocalizedType
    , FieldUI HomepageKey "Links to font" UrlListType
    , ScreenUI ColorScreen "Color" --
    , ExclusivePanelUI ColorListPanel "List of colors"
    , ListManagerUI
    , ExclusivePanelUI ColorEditPanel "Edit color"
    , FieldUI NameKey "Common name for the color" MediumLocalizedType
    , FieldUI DescriptionKey "Description of the color" TextAreaLocalizedType
    , FieldUI SameAsKey "Links to that font on encyclopedy sites" UrlListType
    , FieldUI PrintColorKey "The best color used for print" ChromaType
    , FieldUI ScreenColorKey "The best color used for screen" ChromaType
    , ScreenUI CharacterScreen "Character" --
    , ExclusivePanelUI CharacterListPanel "List of characters"
    , ListManagerUI
    , ExclusivePanelUI CharacterEditPanel "Edit character"
    , FieldUI NameKey "Name of the character" MediumLocalizedType
    , FieldUI DescriptionKey "Description of the character" TextAreaLocalizedType
    , FieldUI HomepageKey "Links to webpages about this character" UrlListType
    , ScreenUI SpeechScreen "Speech" --
    , ExclusivePanelUI SpeechListPanel "List of speech"
    , ListManagerUI
    , ExclusivePanelUI SpeechEditPanel "Edit speech"
    , FieldUI InterlocutorKey "The different interlocutors in the speech bubble" InterlocutorType
    , FieldUI TranscriptKey "The transcript of the speech bubble with formatting" TranscriptType
    , ScreenUI PublishedWorkScreen "Published Work" --
    , ExclusivePanelUI PublishedListPanel "List of published works"
    , ListManagerUI
    , ExclusivePanelUI PublishedEditPanel "Edit published work"
    , FieldUI VersionKey "Version of the published work" VersionType
    , FieldUI TitleKey "Title if different than album" MediumLocalizedType
    , FieldUI DescriptionKey "Description if different than album" TextAreaLocalizedType
    , FieldUI LanguageKey "The language of the published work" LanguageType
    , FieldUI MediumKey "Material or physical carrier" (ListBoxType MediumId)
    , FieldUI FormatKey "File format, physical medium, or dimensions" (ListBoxType FormatId)
    , FieldUI LayoutKey "Layout of the album" LayoutType
    ]
