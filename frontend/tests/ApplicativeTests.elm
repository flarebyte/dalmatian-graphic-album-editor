module ApplicativeTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Applicative as Applicative exposing (processUIEvent)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PredicateKey(..), ScreenZone(..), PanelZone(..), UIEvent(..))
import Dalmatian.Editor.Persistence exposing (StoreValue)
import Dalmatian.Editor.FieldPersistence exposing (FieldValue(..))
import Dalmatian.Editor.LocalizedString as LocalizedString
import Dalmatian.Editor.Dialect.LanguageIdentifier as LanguageIdentifier exposing (LanguageId)

enGB = LanguageIdentifier.createLanguageAndCountry "en" "gb"
frFR = LanguageIdentifier.createLanguageAndCountry "fr" "fr"

defaultPanelKey: PanelKey
defaultPanelKey =  { screen = GraphicAlbumScreen, panel = DefaultPanel, uid = 0, language = enGB }

defaultFrPanelKey: PanelKey
defaultFrPanelKey =  { screen = GraphicAlbumScreen, panel = DefaultPanel, uid = 0, language = frFR }

contributorPanelKey: PanelKey
contributorPanelKey =  { screen = ContributorScreen, panel = DefaultPanel, uid = 1, language = enGB }

defaultPanelValues: List StoreValue
defaultPanelValues =
    [ 
        StoreValue (FieldKey defaultPanelKey TitleKey MediumLocalizedType) (LocalizedListValue [LocalizedString.Model enGB "title 0" ])
        , StoreValue (FieldKey defaultPanelKey DescriptionKey TextAreaLocalizedType) (LocalizedListValue [LocalizedString.Model enGB "description 0" ])
        , StoreValue (FieldKey defaultPanelKey LanguageKey LanguageType) (LanguageValue enGB)
    ]

modifiedDefaultPanelValues: List StoreValue
modifiedDefaultPanelValues =
    [ 
        StoreValue (FieldKey defaultPanelKey TitleKey MediumLocalizedType) (LocalizedListValue [LocalizedString.Model enGB "title 00" ])
        , StoreValue (FieldKey defaultPanelKey DescriptionKey TextAreaLocalizedType) (LocalizedListValue [LocalizedString.Model enGB "description 00" ])
        , StoreValue (FieldKey defaultPanelKey LanguageKey LanguageType) (LanguageValue enGB)
    ]

defaultFrPanelValues: List StoreValue
defaultFrPanelValues =
    [ 
        StoreValue (FieldKey defaultFrPanelKey TitleKey MediumLocalizedType) (LocalizedListValue [LocalizedString.Model (LanguageIdentifier.createLanguageAndCountry "en" "fr") "titre 0" ])
        , StoreValue (FieldKey defaultFrPanelKey DescriptionKey TextAreaLocalizedType) (LocalizedListValue [LocalizedString.Model (LanguageIdentifier.createLanguageAndCountry "en" "fr") "commentaire 0" ])
        , StoreValue (FieldKey defaultFrPanelKey LanguageKey LanguageType) (LanguageValue frFR)
    ]

contributorPanelValues: List StoreValue
contributorPanelValues =
    [ 
        StoreValue (FieldKey contributorPanelKey TitleKey MediumLocalizedType) (LocalizedListValue [LocalizedString.Model enGB "title 1" ])
        , StoreValue (FieldKey contributorPanelKey DescriptionKey TextAreaLocalizedType) (LocalizedListValue [LocalizedString.Model enGB "description 1" ])
        , StoreValue (FieldKey contributorPanelKey LanguageKey LanguageType) (LanguageValue enGB)
    ]

guessPanelKey: List StoreValue -> Maybe PanelKey
guessPanelKey list =
    if list == defaultPanelValues then Just defaultPanelKey
    else if list == defaultFrPanelValues then Just defaultFrPanelKey
    else if list == contributorPanelValues then Just contributorPanelKey
    else Nothing

defaultAlbum: List StoreValue
defaultAlbum = defaultFrPanelValues ++ contributorPanelValues ++ defaultPanelValues

fuzzyPanelKey: Fuzzer PanelKey
fuzzyPanelKey = [defaultPanelKey, defaultFrPanelKey, contributorPanelKey] |> List.map constant |> oneOf

model: Applicative.Model
model =
    {   counter = 100
        , languages = [ enGB ]
        , panelKey = defaultPanelKey
        , panelValues = []
        , deletedPanelKey = []
        , album = defaultAlbum
        , albumDiff = []
        , fieldKey = Nothing
        , tokenValue = Nothing
    }

suite : Test
suite =
    describe "The Applicative Module"
    [
        describe "processUIEvent"
        [
            fuzz (intRange 0 1000) "OnNewPanelUI should create a panel" <|
                \uid ->
                    processUIEvent (OnNewPanelUI { screen = GraphicAlbumScreen, panel = DefaultPanel, uid = uid, language = enGB }) model
                        |> Expect.equal { model | counter = 101 , panelKey = { defaultPanelKey | uid =100 }}
            
            , fuzz fuzzyPanelKey "OnLoadPanelUI should open an existing panel" <|
                \panelKey ->
                    processUIEvent (OnLoadPanelUI panelKey) model |> .panelValues |> guessPanelKey
                        |> Expect.equal (Just panelKey)

            , fuzz fuzzyPanelKey "OnDeletePanelKey should delete existing panel" <|
                \panelKey ->
                    processUIEvent (OnDeletePanelKey panelKey) model |> .album |> List.length
                        |> Expect.equal 6
            
            , test "OnSavePanelKey should save existing panel" <|
                \_ -> processUIEvent (OnSavePanelKey) { model | panelValues = modifiedDefaultPanelValues }|> .album
                        |> Expect.equal (modifiedDefaultPanelValues ++ defaultFrPanelValues ++ contributorPanelValues)

         ]
    ]
