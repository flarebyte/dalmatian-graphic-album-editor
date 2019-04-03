module PersistenceTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PredicateKey(..), ScreenZone(..), PanelZone(..))
import Dalmatian.Editor.Persistence exposing (StoreValue, findByPanelKey, deleteByPanelKey, savePanelKey)
import Dalmatian.Editor.FieldPersistence exposing (FieldValue(..))
import Dalmatian.Editor.Dialect.LanguageIdentifier as LanguageIdentifier exposing (LanguageId)

enGB= LanguageIdentifier.createLanguageAndCountry "en" "GB"
frFR= LanguageIdentifier.createLanguageAndCountry "fr" "FR"
enUS= LanguageIdentifier.createLanguageAndCountry "en" "US"
zh= LanguageIdentifier.createLanguage "zh"
cs= LanguageIdentifier.createLanguage "cs"
ja= LanguageIdentifier.createLanguage "ja"
ko= LanguageIdentifier.createLanguage "ko"
en= LanguageIdentifier.createLanguage "en"
fr= LanguageIdentifier.createLanguage "fr"

screenZones = [GraphicAlbumScreen, RightsScreen, ContributionScreen, ContributorScreen, ColorScreen, FontScreen, IllustrationScreen]
panelZones = [CopyrightsPanel, DefaultPanel, LicensePanel, ContributorListPanel, ContributorEditPanel, AttributionPanel, StencilListPanel, StencilEditPanel]
languages = [enGB, frFR, enUS, zh, cs, ja, ko]
predicateKeys = [VersionKey, CreatedKey, ModifiedKey, TitleKey, DescriptionKey, LanguageKey, KeywordKey]    
fieldTypes = [ShortLocalizedListType, MediumLocalizedType, TextAreaLocalizedType, UrlListType, DateTimeType, VersionType]
panelKeys = [
    PanelKey GraphicAlbumScreen CopyrightsPanel enGB 1
    , PanelKey RightsScreen DefaultPanel enUS 2
    , PanelKey GraphicAlbumScreen LicensePanel fr 3
    , PanelKey ContributionScreen CopyrightsPanel en 4
    , PanelKey ContributorScreen DefaultPanel ja 5
    , PanelKey GraphicAlbumScreen LicensePanel ko 6
    ]

fieldKeys:  List FieldKey
fieldKeys = List.map3 FieldKey panelKeys predicateKeys fieldTypes

storageValues: List StoreValue
storageValues = fieldKeys |> List.map (\fk -> StoreValue fk (WarningMessage (fk.panelKey.uid |> String.fromInt)))

fuzzyPredicateKey: Fuzzer PredicateKey
fuzzyPredicateKey = predicateKeys |> List.map constant |> oneOf

fuzzyFieldType: Fuzzer FieldType
fuzzyFieldType = fieldTypes |> List.map constant |> oneOf

fuzzyPanelKey: Fuzzer PanelKey
fuzzyPanelKey = panelKeys |> List.map constant |> oneOf

suite : Test
suite =
    describe "The Persistence Module"
    [
        describe "findByPanelKey"
        [
            fuzz fuzzyPanelKey "should find one value" <|
                \panelKey ->
                    findByPanelKey panelKey storageValues
                        |> List.length
                        |> Expect.equal 1
        ]
        , describe "deleteByPanelKey"
        [
            fuzz fuzzyPanelKey "should delete one value" <|
                \panelKey ->
                    deleteByPanelKey panelKey storageValues
                        |> List.length
                        |> Expect.equal (List.length panelKeys - 1)
        ]
         , describe "savePanelKey"
        [
            fuzz fuzzyPanelKey "should update the values associated with panel" <|
                \panelKey ->
                    savePanelKey panelKey [
                        StoreValue (FieldKey panelKey TitleKey ShortLocalizedListType) TodoField
                        , StoreValue (FieldKey panelKey DescriptionKey ShortLocalizedListType) TodoField
                        ] storageValues
                        |> List.length
                        |> Expect.equal (List.length panelKeys + 1)
        ]
    ]
