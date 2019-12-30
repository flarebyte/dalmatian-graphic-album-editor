module Dalmatian.Editor.Applicative exposing (Model, reset, processUIEvent,
    setSelector
    , asSelectorIn
    , setAlbum
    , asAlbumIn
    , setPanelValues
    , asPanelValuesIn
    )

import Dalmatian.Editor.Persistence
    exposing
        ( StoreValue
        )
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.AppEvent exposing (UIEvent(..))
import Dalmatian.Editor.Selecting exposing (UISelector(..))
import Dalmatian.Editor.Persistence as Persistence
import Dalmatian.Editor.Snatching exposing (Snatch)

type alias Model =
    { selector : UISelector
    , languages : List LanguageId
    , album : List StoreValue
    , panelValues : List StoreValue
    , snatch : Maybe Snatch
    }

reset: Model
reset = { 
    selector = UnknownSelector
    , languages = []
    , album = []
    , panelValues = []
    , snatch= Nothing
    }

-- set methods

setSelector: UISelector -> Model -> Model
setSelector selector model =
    { model | selector = selector }

asSelectorIn: Model -> UISelector -> Model
asSelectorIn model selector =
    { model | selector = selector }

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

isPanelValid: Model -> Bool
isPanelValid model =
    model.panelValues |> List.all Persistence.isValid

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
            onUpdateField model.selector fieldOp str model

        OnUpdateField selector fieldOp str ->
            onUpdateField selector fieldOp str model

        OnReshapeCurrentField fieldOp ->
            onReshapeField model.selector fieldOp model

        OnReshapeField selector fieldOp ->
            onReshapeField selector fieldOp model           


onNewUI selector model
    = model

onLoadUI selector model = 
    { model | panelValues = model.album |> List.filter (Persistence.isMatching selector)}

onDeleteUI selector model =
    Persistence.delete selector model.panelValues |> asPanelValuesIn model

onSaveUI model =
   Persistence.replaceWith model.selector model.panelValues model.album |> asAlbumIn model

onUpdateField selector fieldOp str model = 
    Persistence.update selector fieldOp str model.panelValues |> asPanelValuesIn model

onReshapeField selector fieldOp model =
    model
