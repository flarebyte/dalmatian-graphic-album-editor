module Dalmatian.Editor.Applicative exposing (Model, reset, processUIEvent,
    setAppContext
    , asAppContextIn
    , setAlbum
    , asAlbumIn
    , setPanelValues
    , asPanelValuesIn
    )

import Dalmatian.Editor.Persistence
    exposing
        ( StoreValue
        )
import Dalmatian.Editor.Tokens.Token exposing (TokenValue)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.AppContext as AppContext
import Dalmatian.Editor.AppEvent exposing (UIEvent(..))

type alias Model =
    { appContext : AppContext.Model
    , languages : List LanguageId
    , album : List StoreValue
    , panelValues : List StoreValue
    , tokenValue : Maybe (TokenValue (List ( Int, String )))
    }

reset: Model
reset = { 
    appContext = AppContext.reset
    , languages = []
    , album = []
    , panelValues = []
    , tokenValue= Nothing
    }

-- set methods

setAppContext: AppContext.Model -> Model -> Model
setAppContext appContext model =
    { model | appContext = appContext }

asAppContextIn: Model -> AppContext.Model -> Model
asAppContextIn model appContext =
    { model | appContext = appContext }

setAlbum: List StoreValue -> Model -> Model
setAlbum album model =
    { model | album = album }

asAlbumIn:  Model -> List StoreValue -> Model
asAlbumIn model album =
    { model | album = album }

setPanelValues: List StoreValue -> Model -> Model
setPanelValues panelValues model =
    { model | panelValues = panelValues }

asPanelValuesIn:  Model -> List StoreValue -> Model
asPanelValuesIn model panelValues =
     { model | panelValues = panelValues }

processUIEvent : UIEvent -> Model -> Model
processUIEvent event model =
    case event of
        OnNewUI selector ->
            onNewUI selector model 

        OnLoadUI selector ->
           onLoadUI selector model 

        OnDeleteUI selector ->
           onDeleteUI selector model 

        OnSaveUI ->
            onSaveUI model
            
        OnUpdateCurrentField fieldOp str ->
            onUpdateCurrentField fieldOp str model

        OnUpdateField selector fieldOp str ->
            onUpdateField fieldOp str model

        OnReshapeCurrentField fieldOp ->
            onReshapeCurrentField fieldOp model

        OnReshapeField selector fieldOp ->
            onReshapeField selector fieldOp model           


onNewUI selector model
    = model

onLoadUI selector model
    = model

onDeleteUI selector model
    = model

onSaveUI model
    = model

onUpdateCurrentField fieldOp str model
    = model

onUpdateField fieldOp str model
    = model

onReshapeCurrentField fieldOp model
    = model

onReshapeField selector fieldOp model
    = model
