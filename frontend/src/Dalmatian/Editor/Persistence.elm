module Dalmatian.Editor.Persistence exposing
    ( StoreValue
      , create
      , createNone
      , setValue
      , asValueIn
    )

import Dalmatian.Editor.FieldPersistence as FieldPersistence exposing (FieldValue(..))
import Dalmatian.Editor.Tokens.Token as Token exposing (TokenValue)
import Dalmatian.Editor.Selecting as Selecting exposing (UISelector(..), FieldKey)


type alias StoreValue =
    { key : FieldKey
    , value : FieldValue
    }

-- Factory methods

create: FieldKey -> FieldValue -> StoreValue
create key value =
    { key = key, value = value }

createNone: FieldKey -> StoreValue
createNone key =
    { key = key, value = NoValue }

-- setter methods

setValue: FieldValue -> StoreValue -> StoreValue
setValue value storeValue =
    { storeValue | value = value }

asValueIn: StoreValue -> FieldValue -> StoreValue
asValueIn storeValue value =
    { storeValue | value = value }

isMatching: UISelector -> StoreValue -> Bool
isMatching selector storeValue =
    Selecting.isMatching selector storeValue.key

isNotMatching: UISelector -> StoreValue -> Bool
isNotMatching selector storeValue =
    isMatching selector storeValue |> not

update: UISelector -> (FieldValue -> FieldValue) -> List StoreValue -> List StoreValue
update selector transf list =
    List.map
        (\storeValue ->
            if isMatching selector storeValue then
                transf storeValue.value |> asValueIn storeValue
            else
                storeValue
        ) list

delete: UISelector -> List StoreValue -> List StoreValue
delete selector list =
    List.filter (isNotMatching selector) list
