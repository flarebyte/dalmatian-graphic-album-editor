module Dalmatian.Editor.Vocabulary.PredicateKeyTerm exposing (toResourceIdentifier, fromResourceIdentifier)

import Dalmatian.Editor.Schema exposing( PanelZone(..))
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier

dcterms = "dcterms"
foaf = "foaf"
dlm = "dlm"
schema = "schema"

toResourceIdentifier: PanelZone -> ResourceIdentifier
toResourceIdentifier key =
    case key of
        CopyrightsPanel ->
            ResourceIdentifier.create dcterms "rights"
        LicensePanel ->
            ResourceIdentifier.create dcterms "license"
        ContributorPanel ->
            ResourceIdentifier.create dcterms "contributor"
        ContributionPanel ->
            ResourceIdentifier.create dlm "contribution"
        AttributionPanel ->
            ResourceIdentifier.create dlm "attribution"
        StencilPanel ->
            ResourceIdentifier.create dlm "stencil"
        FontPanel ->
            ResourceIdentifier.create dlm "font"
        ColorPanel ->
            ResourceIdentifier.create dlm "color"
        CharacterPanel ->
            ResourceIdentifier.create schema "character"
        SpeechPanel ->
            ResourceIdentifier.create dlm "speech"
        PublishedPanel ->
            ResourceIdentifier.create dlm "published"

fromResourceIdentifier: ResourceIdentifier -> Maybe PanelZone
fromResourceIdentifier id =
    case id of
        any ->
            Nothing