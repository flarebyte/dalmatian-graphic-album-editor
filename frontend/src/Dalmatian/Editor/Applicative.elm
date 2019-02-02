module Dalmatian.Editor.Applicative exposing (Model)

import Dalmatian.Editor.Persistence exposing (StoreValue, deleteByPanelKey, findByPanelKey,
    savePanelKey, updateStoreKeyValue,
    findDialogValues, saveFieldDialog, deleteFieldDialog, changeFieldDialog)
import Dalmatian.Editor.Schema exposing (PanelKey, PanelZone, ScreenZone, UIEvent(..))


type alias Model =
    { counter : Int
    , languages : List String
    , panelKey : PanelKey
    , album : List StoreValue
    , albumDiff : List StoreValue
    , deletedPanelKey : List PanelKey
    , panelValues : List StoreValue
    , dialogValues: List (Int, String)
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

        OnChangeField fkey str ->
            { model
                | panelValues = updateStoreKeyValue fkey str model.panelValues
            }
        
        OnShowFieldDialog fkey tokenId ->
            { model 
            | dialogValues = findDialogValues fkey tokenId model.panelValues
            }

        OnSaveFieldDialog fkey tokenId ->
            { model 
            | panelValues = saveFieldDialog fkey tokenId model.dialogValues
            | dialogValues = []
            }

        OnDeleteFieldDialog fkey tokenId ->
            { model 
            | panelValues = deleteFieldDialog fkey tokenId model.panelValues
            | dialogValues = []
            }

        OnCancelFieldDialog fkey ->
            { model 
            | dialogValues = []
            }

        OnChangeFieldDialog fkey tokenId position value->
            { model 
            | dialogValues = changeFieldDialog fkey tokenId position value model.dialogValues
            }

