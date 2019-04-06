module Dalmatian.Editor.Selecting exposing (UISelector(..), FieldKey, toFieldType, toLanguage, isMatching)

import Dalmatian.Editor.Schema as Schema exposing(PanelZone, PredicateKey, FieldType)
import Dalmatian.Editor.Dialect.LanguageIdentifier as LanguageIdentifier exposing (LanguageId)

type FieldKey = FieldKey LanguageId PanelZone Int PredicateKey

type UISelector
    = UnknownSelector
    | SelectPanel LanguageId PanelZone Int
    | SelectField LanguageId PanelZone Int PredicateKey
    | SelectToken LanguageId PanelZone Int PredicateKey Int
    | NotSelector UISelector


toFieldType: UISelector -> Maybe FieldType
toFieldType selector =
    case selector of
        SelectField lang pz uid predicateKey ->
            Schema.predicateKeyToFieldType predicateKey |> Just
        
        SelectToken lang pz uid predicateKey tokenId->
            Schema.predicateKeyToFieldType predicateKey |> Just

        otherwise ->
            Nothing

toLanguage: UISelector -> LanguageId
toLanguage selector =
    case selector of
        SelectField lang pz uid predicateKey ->
            lang
        SelectToken lang pz uid predicateKey tokenId ->
            lang
        otherwise ->
            LanguageIdentifier.createLanguage "en"
 
getParent: UISelector -> UISelector
getParent selector =
    case selector of
        SelectToken languageId panelZone uid predicateKey tokenId ->
            SelectField languageId panelZone uid predicateKey
        SelectField languageId panelZone uid predicateKey ->
            SelectPanel languageId panelZone uid
        otherwise ->
            UnknownSelector

isMatching: UISelector -> FieldKey -> Bool
isMatching selector key =
    False