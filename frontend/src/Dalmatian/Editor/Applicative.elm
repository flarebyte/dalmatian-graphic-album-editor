module Dalmatian.Editor.Applicative exposing (Model)

import Dalmatian.Editor.Persistence exposing (StoreValue, deleteByPanelKey, findByPanelKey, savePanelKey, updateStoreKeyValue)
import Dalmatian.Editor.Schema exposing (PanelKey, PanelZone, ScreenZone, UIEvent(..))


type alias Model =
    { counter : Int
    , languages : List String
    , panelKey : PanelKey
    , album : List StoreValue
    , albumDiff : List StoreValue
    , deletedPanelKey : List PanelKey
    , panelValues : List StoreValue
    }


processUIEvent : UIEvent -> Model -> Model
processUIEvent event model =
    case event of
        OnNewPanelUI key ->
            { model
                | counter = model.counter + 1
                , panelKey = { key | uid = model.counter }
                , panelValues = []
            }

        OnLoadPanelUI key ->
            { model
                | panelKey = key
                , panelValues = findByPanelKey key model.album
            }

        OnDeletePanelKey key ->
            { model
                | deletedPanelKey = key :: model.deletedPanelKey
                , album = deleteByPanelKey key model.album
                , albumDiff = deleteByPanelKey key model.albumDiff
            }

        OnSavePanelKey key ->
            { model
                | album = savePanelKey key model.panelValues model.album
                , albumDiff = savePanelKey key model.panelValues model.albumDiff
            }

        OnChangeField key tokenId str ->
            { model
                | panelValues = updateStoreKeyValue key tokenId str model.album
            }
