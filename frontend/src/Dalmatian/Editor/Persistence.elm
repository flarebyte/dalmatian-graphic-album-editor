module Dalmatian.Editor.Persistence exposing
    ( StoreValue
    )

import Dalmatian.Editor.FieldPersistence as FieldPersistence exposing (FieldValue(..))
import Dalmatian.Editor.Tokens.Token as Token exposing (TokenValue)
import Dalmatian.Editor.Selecting as Selecting exposing (UISelector(..), FieldKey)


type alias StoreValue =
    { key : FieldKey
    , value : FieldValue
    }

-- General purpose helpers

create: FieldKey -> FieldValue -> StoreValue
create key value =
    { key = key, value = value }

isMatching: UISelector -> StoreValue -> Bool
isMatching selector storeValue =
    Selecting.isMatching selector storeValue.key
