module PersistenceTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PredicateKey(..), ScreenZone(..), PanelZone(..))
import Dalmatian.Editor.Persistence exposing (StoreValue, findByPanelKey, deleteByPanelKey, savePanelKey)
import Dalmatian.Editor.FieldPersistence exposing (FieldValue(..), isValidFieldValue)

screenZones = [GraphicAlbumScreen, RightsScreen, ContributionScreen, ContributorScreen, ColorScreen, FontScreen, IllustrationScreen]
panelZones = [CopyrightsPanel, DefaultPanel, LicensePanel, ContributorListPanel, ContributorEditPanel, AttributionPanel, StencilListPanel, StencilEditPanel]
languages = ["en-GB", "fr-FR", "en-US", "zh", "cs", "ja", "ko"]
predicateKeys = [IdKey, VersionKey, CreatedKey, ModifiedKey, TitleKey, DescriptionKey, LanguageKey, KeywordKey]    
fieldTypes = [ShortLocalizedListType, MediumLocalizedType, TextAreaLocalizedType, IdType, UrlListType, DateTimeType, VersionType]
panelKeys = [
    PanelKey GraphicAlbumScreen CopyrightsPanel "en-GB" 1
    , PanelKey RightsScreen DefaultPanel "en-US" 2
    , PanelKey GraphicAlbumScreen LicensePanel "fr" 3
    , PanelKey ContributionScreen CopyrightsPanel "en" 4
    , PanelKey ContributorScreen DefaultPanel "ja" 5
    , PanelKey GraphicAlbumScreen LicensePanel "ko" 6
    , PanelKey ColorScreen CopyrightsPanel "en-GB" 7
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
