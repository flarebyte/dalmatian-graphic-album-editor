module Dalmatian.Editor.Schema exposing (FieldType(..), PanelZone(..),
    PredicateKey(..), SchemaUI(..),
    ScreenZone(..), DataId(..), appUI,
    predicateKeyToFieldType)

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


type SchemaUI
    = FieldUI PredicateKey String -- name description
    | ScreenUI ScreenZone String
    | PanelUI PanelZone String
    | ExclusivePanelUI PanelZone String
    | ListManagerUI
    | SaveAsTemplateUI

getParentScreenZone: PanelZone -> ScreenZone
getParentScreenZone panelZone =
    GraphicAlbumScreen --TODO

predicateKeyToFieldType: PredicateKey -> FieldType
predicateKeyToFieldType predicateKey =
    case predicateKey of
        VersionKey -> VersionType
        CreatedKey -> DateTimeType
        ModifiedKey -> DateTimeType
        TitleKey -> MediumLocalizedType
        DescriptionKey -> TextAreaLocalizedType
        LanguageKey -> LanguageType
        KeywordKey -> ShortLocalizedListType
        HomepageKey -> UrlListType
        ContributionKey -> ContributionType
        DimensionKey -> Dimension2DIntType
        NameKey -> MediumLocalizedType
        DataKey -> BinaryDataType
        SameAsKey -> UrlListType
        PrintColorKey -> ChromaType
        ScreenColorKey -> ChromaType
        InterlocutorKey -> InterlocutorType
        TranscriptKey -> TranscriptType
        MediumKey -> (ListBoxType MediumId)
        FormatKey -> (ListBoxType FormatId)
        LayoutKey -> LayoutType

appUI =
    [ ScreenUI GraphicAlbumScreen "Graphic Album" --
    , FieldUI VersionKey "Version of the album"
    , FieldUI CreatedKey "Date the album was first created"
    , FieldUI ModifiedKey "Date the album was officially modified"
    , FieldUI TitleKey "Official title of the album"
    , FieldUI DescriptionKey "Official description of the album"
    , FieldUI KeywordKey "Keywords that describe the nature of the content"
    , ScreenUI RightsScreen "Rights and License" --
    , PanelUI LicensePanel "License"
    , SaveAsTemplateUI
    , FieldUI NameKey "Common name for the license"
    , FieldUI DescriptionKey "Details of the license"
    , FieldUI HomepageKey "Webpages linking to the license"
    , PanelUI CopyrightsPanel "Rights"
    , SaveAsTemplateUI
    , FieldUI NameKey "Copyright name"
    , FieldUI DescriptionKey "Copyrights detailed description"
    , FieldUI HomepageKey "Webpages linking to the copyrights"
    , PanelUI AttributionPanel "Attribution"
    , FieldUI NameKey "Short attribution"
    , FieldUI DescriptionKey "Detailed attribution"
    , FieldUI HomepageKey "Webpages linking to the attributions"
    , ScreenUI ContributionScreen "Contribution" --
    , FieldUI ContributionKey "Credits"
    , ScreenUI IllustrationScreen "Illustration"
    , FieldUI DimensionKey "Dimension of the image"
    , FieldUI DataKey "Reference image"
    , ScreenUI ContributorScreen "Contributor" --
    , ExclusivePanelUI ContributorListPanel "List of contributors"
    , ListManagerUI
    , ExclusivePanelUI ContributorEditPanel "Edit Contributor"
    , FieldUI NameKey "Name of the contributor"
    , FieldUI DescriptionKey "Description of the contributor"
    , FieldUI HomepageKey "Links to webpages about the contributor"
    , ScreenUI FontScreen "Font" --
    , ExclusivePanelUI FontListPanel "List of fonts"
    , ListManagerUI
    , ExclusivePanelUI FontEditPanel "Edit font"
    , FieldUI NameKey "Common name for the font"
    , FieldUI DescriptionKey "Description of the font"
    , FieldUI HomepageKey "Links to font"
    , ScreenUI ColorScreen "Color" --
    , ExclusivePanelUI ColorListPanel "List of colors"
    , ListManagerUI
    , ExclusivePanelUI ColorEditPanel "Edit color"
    , FieldUI NameKey "Common name for the color"
    , FieldUI DescriptionKey "Description of the color"
    , FieldUI SameAsKey "Links to that font on encyclopedy sites"
    , FieldUI PrintColorKey "The best color used for print"
    , FieldUI ScreenColorKey "The best color used for screen"
    , ScreenUI CharacterScreen "Character" --
    , ExclusivePanelUI CharacterListPanel "List of characters"
    , ListManagerUI
    , ExclusivePanelUI CharacterEditPanel "Edit character"
    , FieldUI NameKey "Name of the character"
    , FieldUI DescriptionKey "Description of the character"
    , FieldUI HomepageKey "Links to webpages about this character"
    , ScreenUI SpeechScreen "Speech" --
    , ExclusivePanelUI SpeechListPanel "List of speech"
    , ListManagerUI
    , ExclusivePanelUI SpeechEditPanel "Edit speech"
    , FieldUI InterlocutorKey "The different interlocutors in the speech bubble"
    , FieldUI TranscriptKey "The transcript of the speech bubble with formatting"
    , ScreenUI PublishedWorkScreen "Published Work" --
    , ExclusivePanelUI PublishedListPanel "List of published works"
    , ListManagerUI
    , ExclusivePanelUI PublishedEditPanel "Edit published work"
    , FieldUI VersionKey "Version of the published work"
    , FieldUI TitleKey "Title if different than album"
    , FieldUI DescriptionKey "Description if different than album"
    , FieldUI LanguageKey "The language of the published work"
    , FieldUI MediumKey "Material or physical carrier" 
    , FieldUI FormatKey "File format, physical medium, or dimensions"
    , FieldUI LayoutKey "Layout of the album"
    ]
