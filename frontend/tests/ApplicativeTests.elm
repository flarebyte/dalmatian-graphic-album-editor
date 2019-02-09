module ApplicativeTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Applicative as Applicative exposing (processUIEvent)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PredicateKey(..), ScreenZone(..), PanelZone(..), UIEvent(..))

defaultPanelKey: PanelKey
defaultPanelKey =  { screen = GraphicAlbumScreen, panel = DefaultPanel, uid = 0, language = "en-gb" }

model: Applicative.Model
model =
    {   counter = 100
        , languages = [ "en-gb" ]
        , panelKey = defaultPanelKey
        , panelValues = []
        , deletedPanelKey = []
        , album = []
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
            fuzz (intRange 0 1000) "new panel should create a panel" <|
                \uid ->
                    processUIEvent (OnNewPanelUI { screen = GraphicAlbumScreen, panel = DefaultPanel, uid = uid, language = "en-gb" }) model
                        |> Expect.equal { model | counter = 101 , panelKey = { defaultPanelKey | uid =100 }}

         ]
    ]
