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
    | InterlocutorId
    | NarrativeListId
    | SpeechListId
    | NarrativeMetadataId
    | PageMetadataId
    | PageListId


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
    | NarrativeScreen
    | StoryScreen
    | PageScreen


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
    | NarrativePanel
    | StoryPanel
    | PagePanel


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
    | InterlocutorKey
    | MediumKey
    | AlbumFormatKey
    | MediaFormatKey
    | LayoutKey
    | CompositionKey
    | CommentKey
    | NarrativeListKey
    | SpeechListKey
    | NarrativeMetadataKey
    | PageMetadataKey
    | PageListKey
    | SpatialCoverageKey
    | TemporalCoverageKey


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

        TemporalCoverageKey ->
            MediumLocalizedType

        SpatialCoverageKey ->
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

        InterlocutorKey ->
            SnatchType InterlocutorId

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

        NarrativeListKey ->
            SnatchType NarrativeListId

        SpeechListKey ->
            SnatchType SpeechListId

        NarrativeMetadataKey ->
            SnatchType NarrativeMetadataId
        
        PageMetadataKey ->
            SnatchType PageMetadataId
        
        PageListKey ->
            SnatchType PageListId

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
        [ ListPanelUI SpeechPanel "List of speeches"
        , PanelUI SpeechPanel
            "Edit speech"
            [ FieldUI DescriptionKey "Speech in plain text"
            , FieldUI TranscriptKey "The transcript of the speech bubble with formatting"
            , FieldUI InterlocutorKey "The different interlocutors of the speech bubble"
            , FieldUI CommentKey "Writers' comments about the speech"
            ]
        ]
    , ScreenUI NarrativeScreen
        "Panel's narrative"
        [ ListPanelUI NarrativePanel "List of panel narratives"
        , PanelUI NarrativePanel
            "Edit panel's narrative"
            [ FieldUI NameKey "Name of the narrative"
            , FieldUI SpatialCoverageKey "Location of the action"
            , FieldUI TemporalCoverageKey "Time of the action"
            , FieldUI DescriptionKey "Description of what is happening in the comic panel"
            , FieldUI SpeechListKey "Ordered list of speeches happening at the point of the narrative"
            , FieldUI NarrativeMetadataKey "Metadata for the narrative"
            , FieldUI CommentKey "Writers' comments about the narrative"
            , FieldUI HomepageKey "Helpful links"
            ]
        ]

    , ScreenUI StoryScreen
        "Story"
        [ PanelUI StoryPanel
            "Edit story"
            [ FieldUI NarrativeListKey "Ordered sequence of the narratives"
            , FieldUI CommentKey "Writers' comments about the story"
            ]
        ]

    , ScreenUI PageScreen
        "Page"
        [ ListPanelUI PagePanel "List of pages"
        , PanelUI PagePanel
            "Edit page"
            [ FieldUI NameKey "Name of the page"
            , FieldUI DescriptionKey "Description of the page"
            , FieldUI NarrativeListKey "Ordered sequence of the narratives"
            , FieldUI LanguageKey "The language of the page"
            , FieldUI MediumKey "Material or physical carrier"
            , FieldUI AlbumFormatKey "File format, physical medium, or dimensions"
            , FieldUI PageMetadataKey "Metadata for the page" --include page:from page:to double-page
            , FieldUI LayoutKey "Layout of the page"
            , FieldUI CommentKey "Writers' comments about the page"
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
            , FieldUI PageListKey "Ordered list of pages in the published work"
            ]
        ]
    ]
