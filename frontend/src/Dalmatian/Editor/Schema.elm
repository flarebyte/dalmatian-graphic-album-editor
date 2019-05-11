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
    | AlbumFormatId
    | SpeechActivityId
    | ContributionActivityId
    | PageMetadataId
    | NarrativeMetadataId
    | TranscriptDataId
    | StatusDataId


type SnatchId
    = CompositionId -- recursive binary operations on image
    | LayoutId -- agencing of panels on a page
    | TranscriptId DataId PredicateKey -- formatting of speech text
    | OrderedRelation PanelZone
    | SingleRelation PanelZone
    | OrderedRelationPair PanelZone PanelZone
    | MetadataId DataId
    | AnnotatedRelation PanelZone DataId Int -- max
    | DimensionSnatchId
    | PixelDimensionSnatchId
    | CroppingSnatchId


type FieldType
    = ShortLocalizedListType
    | MediumLocalizedType
    | TextAreaLocalizedType
    | UrlListType
    | DateTimeType
    | VersionType
    | LanguageType
    | ChromaType
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
    | CroppedIllustrationScreen
    | StencilScreen
    | SpeechScreen
    | PublishedWorkScreen
    | LanguageScreen
    | CharacterScreen
    | NarrativeScreen
    | StoryScreen
    | PageScreen
    | DimensionScreen
    | MonochromeScreen


type PanelZone
    = AlbumPanel
    | CopyrightsPanel
    | LicensePanel
    | ContributorPanel
    | ContributionPanel
    | IllustrationPanel
    | CroppedIllustrationPanel
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
    | DimensionPanel
    | MonochromePanel


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
    | DimensionKey
    | PixelDimensionKey
    | ColorLayeringKey
    | CroppingKey
    | StatusKey


type FieldUI
    = FieldUI PredicateKey -- name

type PanelUI
    = PanelUI PanelZone (List FieldUI)
    | ListPanelUI PanelZone


type ScreenUI
    = ScreenUI ScreenZone (List PanelUI)


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
            ChromaType

        ScreenColorKey ->
            ChromaType

        TranscriptKey ->
            SnatchType (TranscriptId TranscriptDataId DescriptionKey)

        InterlocutorKey ->
            SnatchType (AnnotatedRelation CharacterPanel SpeechActivityId 1)

        CompositionKey ->
            SnatchType CompositionId

        MediumKey ->
            ListBoxType MediumId

        MediaFormatKey ->
             SnatchType (SingleRelation DimensionPanel)

        AlbumFormatKey ->
            ListBoxType AlbumFormatId

        LayoutKey ->
            SnatchType LayoutId

        ContributorKey ->
            SnatchType (AnnotatedRelation ContributorPanel ContributionActivityId 5)

        CommentKey ->
            TextAreaLocalizedType

        NarrativeListKey ->
            SnatchType (OrderedRelation NarrativePanel)

        SpeechListKey ->
            SnatchType (OrderedRelation SpeechPanel)

        NarrativeMetadataKey ->
            SnatchType (MetadataId NarrativeMetadataId)
        
        PageMetadataKey ->
            SnatchType (MetadataId PageMetadataId)
        
        PageListKey ->
            SnatchType (OrderedRelation PagePanel)
        
        DimensionKey ->
            SnatchType DimensionSnatchId

        PixelDimensionKey ->
            SnatchType PixelDimensionSnatchId

        ColorLayeringKey ->
            SnatchType (OrderedRelationPair MonochromePanel ColorPanel)
        
        CroppingKey ->
            SnatchType CroppingSnatchId
        
        StatusKey ->
            SnatchType (MetadataId StatusDataId)


appUI : List ScreenUI
appUI =
    [ ScreenUI GraphicAlbumScreen
        [ PanelUI AlbumPanel
            [ FieldUI VersionKey -- "Version of the album"
            , FieldUI CreatedKey -- "Date the album was first created"
            , FieldUI ModifiedKey  -- "Date the album was officially modified"
            , FieldUI TitleKey -- "Official title of the album"
            , FieldUI DescriptionKey -- "Official description of the album"
            , FieldUI KeywordKey -- "Keywords that describe the nature of the content"
            ]
        ]
    , ScreenUI RightsScreen
        [ PanelUI LicensePanel
            [ FieldUI NameKey -- "Common name for the license"
            , FieldUI DescriptionKey -- "Details of the license"
            , FieldUI HomepageKey -- "Webpages linking to the license"
            ]
        , PanelUI CopyrightsPanel
            [ FieldUI NameKey -- "Copyright name"
            , FieldUI DescriptionKey -- "Copyrights detailed description"
            , FieldUI HomepageKey -- "Webpages linking to the copyrights"
            ]
        , PanelUI AttributionPanel
            [ FieldUI NameKey -- "Short attribution"
            , FieldUI DescriptionKey -- "Detailed attribution"
            , FieldUI HomepageKey -- "Webpages linking to the attributions"
            ]
        ]
    , ScreenUI ContributionScreen
        [ ListPanelUI ContributionPanel
        , PanelUI ContributionPanel
            [ FieldUI NameKey -- "Name of the contribution"
            , FieldUI DescriptionKey -- "Description of the contribution"
            , FieldUI ContributorKey -- "List of contributors"
            ]
        ]

   , ScreenUI StencilScreen -- link a single B/W image
        [ ListPanelUI StencilPanel
        , PanelUI StencilPanel
            [ FieldUI NameKey -- "Name of the stencil"
            , FieldUI DescriptionKey -- "Description of the stencil"
            , FieldUI PixelDimensionKey -- "Dimension of the stencil"
            , FieldUI CommentKey -- "Writers' comments for the stencil"
            ]
        ]
     
     , ScreenUI MonochromeScreen
        [ ListPanelUI MonochromePanel
        , PanelUI MonochromePanel
            [ FieldUI NameKey -- "Name of the monochrome composition"
            , FieldUI DescriptionKey -- "Description of the monochrome composition"
            , FieldUI PixelDimensionKey -- "Dimension of the illustration"
            , FieldUI CompositionKey -- "Composition of the illustration"
            , FieldUI CommentKey -- "Writers' comments for the monochrome composition"
            ]
        ]

    , ScreenUI IllustrationScreen -- Colored Illustration
        [ ListPanelUI IllustrationPanel
        , PanelUI IllustrationPanel
            [ FieldUI NameKey -- "Name of the illustration"
            , FieldUI DescriptionKey -- "Description of the illustration"
            , FieldUI PixelDimensionKey -- "Dimension of the illustration"
            , FieldUI ColorLayeringKey -- "Color layering of the illustration"
            , FieldUI CommentKey -- "Writers' comments for the illustration"
            ]
        ]

    , ScreenUI CroppedIllustrationScreen
        [ ListPanelUI CroppedIllustrationPanel
        , PanelUI CroppedIllustrationPanel
            [ FieldUI NameKey -- "Name of the illustration"
            , FieldUI DescriptionKey -- "Description of the illustration"
            , FieldUI MediaFormatKey -- "Dimension of the illustration"
            , FieldUI CroppingKey -- "Cropping of the illustration"
            ]
        ]
   
    , ScreenUI ContributorScreen
        [ ListPanelUI ContributorPanel
        , PanelUI ContributorPanel
            [ FieldUI NameKey -- "Name of the contributor"
            , FieldUI DescriptionKey -- "Description of the contributor"
            , FieldUI HomepageKey -- "Links to webpages about the contributor"
            ]
        ]
    , ScreenUI FontScreen
        [ ListPanelUI FontPanel
        , PanelUI FontPanel
            [ FieldUI NameKey -- "Common name for the font"
            , FieldUI DescriptionKey -- "Description of the font"
            , FieldUI HomepageKey -- "Links to font"
            ]
        ]
    , ScreenUI ColorScreen
        [ ListPanelUI ColorPanel
        , PanelUI ColorPanel
            [ FieldUI NameKey -- "Common name for the color"
            , FieldUI DescriptionKey -- "Description of the color"
            , FieldUI SameAsKey -- "Links to that font on encyclopedia sites"
            , FieldUI PrintColorKey -- "The best color used for print"
            , FieldUI ScreenColorKey -- "The best color used for screen"
            ]
        ]
    
    , ScreenUI DimensionScreen
        [ ListPanelUI DimensionPanel
        , PanelUI DimensionPanel
            [ FieldUI NameKey -- "Name of the dimension"
            , FieldUI DescriptionKey -- "Description of the dimension"
            , FieldUI DimensionKey -- "Width and height (fraction)"
            ]
        ]
    , ScreenUI CharacterScreen
        [ ListPanelUI CharacterPanel
        , PanelUI CharacterPanel
            [ FieldUI NameKey -- "Name of the character"
            , FieldUI DescriptionKey -- "Description of the character"
            , FieldUI HomepageKey -- "Links to webpages about this character"
            , FieldUI CommentKey -- "Writers' comments about this character"
            ]
        ]
    , ScreenUI SpeechScreen
        [ ListPanelUI SpeechPanel
        , PanelUI SpeechPanel
            [ FieldUI DescriptionKey -- "Speech in plain text"
            , FieldUI TranscriptKey -- "The transcript of the speech bubble with formatting"
            , FieldUI InterlocutorKey -- "The different interlocutors of the speech bubble"
            , FieldUI CommentKey -- "Writers' comments about the speech"
            ]
        ]
    , ScreenUI NarrativeScreen
        [ ListPanelUI NarrativePanel
        , PanelUI NarrativePanel
            [ FieldUI NameKey -- "Name of the narrative"
            , FieldUI SpatialCoverageKey -- "Location of the action"
            , FieldUI TemporalCoverageKey -- "Time of the action"
            , FieldUI DescriptionKey -- "Description of what is happening in the comic panel"
            , FieldUI SpeechListKey -- "Ordered list of speeches happening at the point of the narrative"
            , FieldUI NarrativeMetadataKey -- "Metadata for the narrative"
            , FieldUI CommentKey -- "Writers' comments about the narrative"
            , FieldUI HomepageKey -- "Helpful links"
            ]
        ]

    , ScreenUI StoryScreen
        [ PanelUI StoryPanel
            [ FieldUI NarrativeListKey -- "Ordered sequence of the narratives"
            , FieldUI CommentKey -- "Writers' comments about the story"
            ]
        ]

    , ScreenUI PageScreen
        [ ListPanelUI PagePanel
        , PanelUI PagePanel
            [ FieldUI NameKey -- "Name of the page"
            , FieldUI DescriptionKey -- "Description of the page"
            , FieldUI NarrativeListKey -- "Ordered sequence of the narratives"
            , FieldUI LanguageKey -- "The language of the page"
            , FieldUI MediumKey -- "Material or physical carrier"
            , FieldUI AlbumFormatKey -- "File format, physical medium, or dimensions"
            , FieldUI PageMetadataKey -- "Metadata for the page"
            , FieldUI LayoutKey -- "Layout of the page"
            , FieldUI CommentKey -- "Writers' comments about the page"
            ]
        ]

    , ScreenUI PublishedWorkScreen
        [ ListPanelUI PublishedPanel
        , PanelUI PublishedPanel
            [ FieldUI VersionKey -- "Version of the published work"
            , FieldUI TitleKey -- "Title if different than album"
            , FieldUI DescriptionKey -- "Description if different than album"
            , FieldUI LanguageKey -- "The language of the published work"
            , FieldUI MediumKey -- "Material or physical carrier"
            , FieldUI AlbumFormatKey -- "File format, physical medium, or dimensions"
            , FieldUI PageListKey -- "Ordered list of pages in the published work"
            ]
        ]
    ]
