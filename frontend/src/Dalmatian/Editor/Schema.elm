module Dalmatian.Editor.Schema exposing
    ( DataId(..)
    , FieldType(..)
    , PanelZone(..)
    , PredicateKey(..)
    , ScreenZone(..)
    , appUI
    , predicateKeyToFieldType
    )

import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)


type DataId
    = MediumId
    | FormatId


type SnatchId
    = CompositionId
    | LayoutId
    | TranscriptId
    | ChromaId


type FieldType
    = ShortLocalizedListType
    | MediumLocalizedType
    | TextAreaLocalizedType
    | UrlListType
    | ResourceIdListType
    | DateTimeType
    | VersionType
    | LanguageType
    | ListBoxType DataId
    | SnatchType SnatchId


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
    | LicensePanel
    | ContributorPanel
    | ContributionPanel
    | IllustrationPanel
    | AttributionPanel
    | StencilPanel
    | FontPanel
    | ColorPanel
    | CharacterPanel
    | SpeechPanel
    | PublishedPanel


type PredicateKey
    = VersionKey
    | CreatedKey
    | ModifiedKey
    | TitleKey
    | DescriptionKey
    | LanguageKey
    | KeywordKey
    | HomepageKey
    | ContributorKey
    | NameKey
    | SameAsKey
    | PrintColorKey
    | ScreenColorKey
    | TranscriptKey
    | MediumKey
    | AlbumFormatKey
    | MediaFormatKey
    | LayoutKey
    | CompositionKey
    | CommentKey


type FieldUI
    = FieldUI PredicateKey String -- name description


type PanelUI
    = DefaultPanel (List FieldUI)
    | PanelUI PanelZone String (List FieldUI)
    | ListPanelUI PanelZone String


type ScreenUI
    = ScreenUI ScreenZone String (List PanelUI)


getParentScreenZone : PanelZone -> ScreenZone
getParentScreenZone panelZone =
    GraphicAlbumScreen



--TODO


predicateKeyToFieldType : PredicateKey -> FieldType
predicateKeyToFieldType predicateKey =
    case predicateKey of
        VersionKey ->
            VersionType

        CreatedKey ->
            DateTimeType

        ModifiedKey ->
            DateTimeType

        TitleKey ->
            MediumLocalizedType

        DescriptionKey ->
            TextAreaLocalizedType

        LanguageKey ->
            LanguageType

        KeywordKey ->
            ShortLocalizedListType

        HomepageKey ->
            UrlListType

        NameKey ->
            MediumLocalizedType

        SameAsKey ->
            UrlListType

        PrintColorKey ->
            SnatchType ChromaId

        ScreenColorKey ->
            SnatchType ChromaId

        TranscriptKey ->
            SnatchType TranscriptId

        CompositionKey ->
            SnatchType CompositionId

        MediumKey ->
            ListBoxType MediumId

        MediaFormatKey ->
            ListBoxType FormatId

        AlbumFormatKey ->
            ListBoxType FormatId

        LayoutKey ->
            SnatchType LayoutId

        ContributorKey ->
            ResourceIdListType

        CommentKey ->
            TextAreaLocalizedType


appUI : List ScreenUI
appUI =
    [ ScreenUI GraphicAlbumScreen
        "Graphic Album"
        [ DefaultPanel
            [ FieldUI VersionKey "Version of the album"
            , FieldUI CreatedKey "Date the album was first created"
            , FieldUI ModifiedKey "Date the album was officially modified"
            , FieldUI TitleKey "Official title of the album"
            , FieldUI DescriptionKey "Official description of the album"
            , FieldUI KeywordKey "Keywords that describe the nature of the content"
            ]
        ]
    , ScreenUI RightsScreen
        "Rights and License"
        [ PanelUI LicensePanel
            "License"
            [ FieldUI NameKey "Common name for the license"
            , FieldUI DescriptionKey "Details of the license"
            , FieldUI HomepageKey "Webpages linking to the license"
            ]
        , PanelUI CopyrightsPanel
            "Rights"
            [ FieldUI NameKey "Copyright name"
            , FieldUI DescriptionKey "Copyrights detailed description"
            , FieldUI HomepageKey "Webpages linking to the copyrights"
            ]
        , PanelUI AttributionPanel
            "Attribution"
            [ FieldUI NameKey "Short attribution"
            , FieldUI DescriptionKey "Detailed attribution"
            , FieldUI HomepageKey "Webpages linking to the attributions"
            ]
        ]
    , ScreenUI ContributionScreen
        "Contribution"
        [ ListPanelUI ContributionPanel "List of contributions"
        , PanelUI ContributionPanel
            "Edit contribution"
            [ FieldUI NameKey "Name of the contribution"
            , FieldUI DescriptionKey "Description of the contribution"
            , FieldUI ContributorKey "List of contributors"
            ]
        ]
    , ScreenUI IllustrationScreen
        "Illustration"
        [ ListPanelUI IllustrationPanel "List of illustrations"
        , PanelUI IllustrationPanel
            "Edit illustration"
            [ FieldUI NameKey "Name of the illustration"
            , FieldUI DescriptionKey "Description of the illustration"
            , FieldUI MediaFormatKey "Dimension of the illustration"
            , FieldUI CompositionKey "Composition of the illustration"
            , FieldUI CommentKey "Writers' comments for the illustration"
            ]
        ]
    , ScreenUI ContributorScreen
        "Contributor"
        [ ListPanelUI ContributorPanel "List of contributors"
        , PanelUI ContributorPanel
            "Edit Contributor"
            [ FieldUI NameKey "Name of the contributor"
            , FieldUI DescriptionKey "Description of the contributor"
            , FieldUI HomepageKey "Links to webpages about the contributor"
            ]
        ]
    , ScreenUI FontScreen
        "Font"
        [ ListPanelUI FontPanel "List of fonts"
        , PanelUI FontPanel
            "Edit font"
            [ FieldUI NameKey "Common name for the font"
            , FieldUI DescriptionKey "Description of the font"
            , FieldUI HomepageKey "Links to font"
            ]
        ]
    , ScreenUI ColorScreen
        "Color"
        [ ListPanelUI ColorPanel "List of colors"
        , PanelUI ColorPanel
            "Edit color"
            [ FieldUI NameKey "Common name for the color"
            , FieldUI DescriptionKey "Description of the color"
            , FieldUI SameAsKey "Links to that font on encyclopedia sites"
            , FieldUI PrintColorKey "The best color used for print"
            , FieldUI ScreenColorKey "The best color used for screen"
            ]
        ]
    , ScreenUI CharacterScreen
        "Character"
        [ ListPanelUI CharacterPanel "List of characters"
        , PanelUI CharacterPanel
            "Edit character"
            [ FieldUI NameKey "Name of the character"
            , FieldUI DescriptionKey "Description of the character"
            , FieldUI HomepageKey "Links to webpages about this character"
            , FieldUI CommentKey "Writers' comments about this character"
            ]
        ]
    , ScreenUI SpeechScreen
        "Speech"
        [ ListPanelUI SpeechPanel "List of speech"
        , PanelUI SpeechPanel
            "Edit speech"
            [ FieldUI DescriptionKey "Speech in plain text"
            , FieldUI TranscriptKey "The transcript of the speech bubble with formatting"
            , FieldUI CommentKey "Writers' comments about the speech"
            ]
        ]
    , ScreenUI PublishedWorkScreen
        "Published Work"
        [ ListPanelUI PublishedPanel "List of published works"
        , PanelUI PublishedPanel
            "Edit published work"
            [ FieldUI VersionKey "Version of the published work"
            , FieldUI TitleKey "Title if different than album"
            , FieldUI DescriptionKey "Description if different than album"
            , FieldUI LanguageKey "The language of the published work"
            , FieldUI MediumKey "Material or physical carrier"
            , FieldUI AlbumFormatKey "File format, physical medium, or dimensions"
            , FieldUI LayoutKey "Layout of the album"
            ]
        ]
    ]
