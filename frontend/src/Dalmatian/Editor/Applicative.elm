module Dalmatian.Editor.Applicative exposing (Model)

import Dalmatian.Editor.Persistence exposing (StoreValue, findByPanelKey, updateStoreKeyValue, savePanelKey, deletePanelKey)
import Dalmatian.Editor.Schema exposing (ScreenZone, PanelZone, UIEvent(..), PanelKey)

type alias Model =
    { counter : Int
      , languages: List String  
      , panelKey: PanelKey
      , album : List StoreValue
      , albumDiff: List StoreValue
      , deletedPanelKey: List PanelKey
      , panelValues: List StoreValue
    }

processUIEvent: UIEvent -> Model -> Model
processUIEvent event model =
    case event of
        OnNewPanelUI key ->
            { model | counter = model.counter + 1
            , panelKey = { key | uid = model.counter }
            , panelValues = []
            }
        OnLoadPanelUI key ->
            { model | panelKey = key
            , panelValues = findByPanelKey key model.album
            }
        OnDeletePanelKey key ->
            {
                model | deletedPanelKey = key :: model.deletedPanelKey
                , album = deletePanelKey key model.album
                , albumDiff = deletePanelKey key model.albumDiff
            }
        OnSavePanelKey ->
            { model | 
                album = savePanelKey model.panelValues model.album
                , albumDiff = savePanelKey model.panelValues model.albumDiff
            }
        OnChangeField key values ->
            { model | 
                panelValues = updateStoreKeyValue key values model.album
            }

         

