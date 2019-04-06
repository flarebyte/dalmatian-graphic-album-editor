module Dalmatian.Editor.AppContext exposing (Model, incCounter, reset)

import Dalmatian.Editor.Selecting exposing (UISelector(..))

type alias Model =
    { counter : Int
    , selector : UISelector
    }

reset: Model
reset = {
    counter = 1
    , selector = NoSelector
    }

incCounter: Model -> Model
incCounter model =
    { model | counter = model.counter + 1 }
