module ApplicativeTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Applicative as Applicative exposing (processUIEvent)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PredicateKey(..), ScreenZone(..), PanelZone(..), UIEvent(..))

model: Applicative.Model
model =
    {   counter = 100
        , languages = [ "en-gb" ]
        , panelKey = { screen = GraphicAlbumScreen, panel = DefaultPanel, uid = 0, language = "en-gb" }
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
        describe "toStringFieldValue"
        [
            fuzz (intRange 0 1000) "should support valid version" <|
                \uid ->
                    processUIEvent (OnNewPanelUI { screen = GraphicAlbumScreen, panel = DefaultPanel, uid = uid, language = "en-gb" }) model
                        |> Expect.equal model

         ]
    ]
