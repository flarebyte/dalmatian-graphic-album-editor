module Dalmatian.Editor.Vocabulary.PredicateKeyTerm exposing (toResourceIdentifier, fromResourceIdentifier)

import Dalmatian.Editor.Schema exposing( PredicateKey(..))
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier

dcterms = "dcterms"
foaf = "foaf"
dlm = "dlm"
owl = "owl"
rdfs = "comment"
schema = "schema"

toResourceIdentifier: PredicateKey -> ResourceIdentifier
toResourceIdentifier key =
    case key of
        VersionKey -> ResourceIdentifier.create schema "version"
        CreatedKey -> ResourceIdentifier.create dcterms "created"
        ModifiedKey -> ResourceIdentifier.create dcterms "modified"
        TitleKey -> ResourceIdentifier.create dcterms "title"
        DescriptionKey -> ResourceIdentifier.create dcterms "description"
        LanguageKey -> ResourceIdentifier.create dcterms "language"
        KeywordKey -> ResourceIdentifier.create schema "keywords"
        HomepageKey -> ResourceIdentifier.create foaf "homepage"
        ImageMetadataKey -> ResourceIdentifier.create dlm "image-metadata"
        NameKey -> ResourceIdentifier.create foaf name
        SameAsKey -> ResourceIdentifier.create owl "sameAs"
        PrintColorKey -> ResourceIdentifier.create dlm "color/print"
        ScreenColorKey -> ResourceIdentifier.create dlm "color/screen"
        InterlocutorKey -> ResourceIdentifier.create dlm "interlocutor"
        TranscriptKey -> ResourceIdentifier.create dlm "transcript"
        MediumKey -> ResourceIdentifier.create dcterms "medium"
        FormatKey -> ResourceIdentifier.create dcterms "format"
        LayoutKey -> ResourceIdentifier.create dlm "layout"
        CommentKey -> ResourceIdentifier.create rdfs "comment"

fromResourceIdentifier: ResourceIdentifier -> Maybe PredicateKey
fromResourceIdentifier id =
    case id of
        any ->
            Nothing