module Dalmatian.Editor.Applicative exposing (Model, processUIEvent)

import Dalmatian.Editor.Persistence
    exposing
        ( StoreValue
        , deleteByPanelKey
        , deleteToken
        , findByPanelKey
        , getNextRank
        , moveTokenDown
        , moveTokenUp
        , savePanelKey
        , saveToken
        , selectToken
        , updateStoreKeyValue
        )
import Dalmatian.Editor.Schema exposing (FieldKey, PanelKey, PanelZone, ScreenZone, UIEvent(..))
import Dalmatian.Editor.Tokens.Token exposing (TokenValue)


type alias Model =
    { counter : Int
    , languages : List String
    , panelKey : PanelKey
    , album : List StoreValue
    , albumDiff : List StoreValue
    , deletedPanelKey : List PanelKey
    , panelValues : List StoreValue
    , fieldKey : Maybe FieldKey
    , tokenValue : Maybe (TokenValue (List ( Int, String )))
    }


processUIEvent : UIEvent -> Model -> Model
processUIEvent event model =
    case event of
        OnNewPanelUI key ->
            { model
                | counter = model.counter + 1
                , panelKey = { key | uid = model.counter }
                , panelValues = []
                , fieldKey = Nothing
                , tokenValue = Nothing
            }

        OnLoadPanelUI key ->
            { model
                | panelKey = key
                , panelValues = findByPanelKey key model.album
                , fieldKey = Nothing
                , tokenValue = Nothing
            }

        OnDeletePanelKey key ->
            { model
                | deletedPanelKey = key :: model.deletedPanelKey
                , album = deleteByPanelKey key model.album
                , albumDiff = deleteByPanelKey key model.albumDiff
            }

        OnSavePanelKey ->
            { model
                | album = savePanelKey model.panelKey model.panelValues model.album
                , albumDiff = savePanelKey model.panelKey model.panelValues model.albumDiff
            }

        OnChangeField fkey str ->
            { model
                | panelValues = updateStoreKeyValue fkey str model.panelValues
            }

        OnSelectComplexField fkey ->
            { model
                | fieldKey = Just fkey
                , tokenValue = Nothing
            }

        OnSelectToken tokenId ->
            { model
                | tokenValue = selectToken model.fieldKey tokenId model.panelValues
            }

        OnNewToken ->
            { model
                | tokenValue =
                    Maybe.map2
                        (\fkey tokenValue ->
                            TokenValue model.counter [] (getNextRank fkey tokenValue model.panelValues)
                        )
                        model.fieldKey
                        model.tokenValue
                        |> Maybe.withDefault (TokenValue model.counter [] 1000)
                        |> Just
                , counter = model.counter + 1
            }

        OnDeleteToken ->
            { model
                | panelValues =
                    Maybe.map2 (\fkey tokenValue -> deleteToken fkey tokenValue model.panelValues) model.fieldKey model.tokenValue
                        |> Maybe.withDefault model.panelValues
                , tokenValue = Nothing
            }

        OnSaveToken ->
            { model
                | panelValues =
                    Maybe.map2 (\fkey tokenValue -> saveToken fkey tokenValue model.panelValues) model.fieldKey model.tokenValue
                        |> Maybe.withDefault model.panelValues
                , tokenValue = Nothing
            }

        OnMoveTokenUp ->
            { model
                | panelValues =
                    Maybe.map2 (\fkey tokenValue -> moveTokenUp fkey tokenValue model.panelValues) model.fieldKey model.tokenValue
                        |> Maybe.withDefault model.panelValues
            }

        OnMoveTokenDown ->
            { model
                | panelValues =
                    Maybe.map2 (\fkey tokenValue -> moveTokenDown fkey tokenValue model.panelValues) model.fieldKey model.tokenValue
                        |> Maybe.withDefault model.panelValues
                , tokenValue = Nothing
            }
