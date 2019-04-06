module Dalmatian.Editor.AppContext exposing (Model, incCounter, reset, setSelector, asSelectorIn)

import Dalmatian.Editor.Selecting exposing (UISelector(..))

type alias Model =
    { counter : Int
    , selector : UISelector
    }

reset: Model
reset = {
    counter = 1
    , selector = UnknownSelector
    }

incCounter: Model -> Model
incCounter model =
    { model | counter = model.counter + 1 }

setSelector: UISelector -> Model -> Model
setSelector selector model =
    { model | selector = selector }

asSelectorIn: Model -> UISelector -> Model
asSelectorIn model selector =
    { model | selector = selector }