module Dalmatian.Editor.Persistence exposing (StoreValue, deleteByPanelKey,
    findByPanelKey, savePanelKey, updateStoreKeyValue, 
    selectToken, deleteToken, saveToken, moveTokenUp, moveTokenDown, getNextRank)

import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..), PanelKey, PredicateKey, ScreenZone, appUI)
import Dalmatian.Editor.FieldPersistence as FieldPersistence exposing (FieldValue(..), upsertContributionValue)
import Dalmatian.Editor.Contributing as Contributing
import Dalmatian.Editor.Token as Token exposing (TokenValue)

type alias StoreValue =
    { key : FieldKey
    , value : FieldValue
    }

-- General purpose helpers

findOneValueByFieldKey: FieldKey ->  List StoreValue ->  FieldValue
findOneValueByFieldKey fkey list =
    list |> List.filter (\sv -> sv.key == fkey) |> List.head |> Maybe.map .value |> Maybe.withDefault NoValue

deleteByFieldKey: FieldKey ->  List StoreValue -> List StoreValue
deleteByFieldKey fkey list =
    list |> List.filter (\sv -> sv.key /= fkey)

upsertStoreValue: List StoreValue -> StoreValue -> List StoreValue
upsertStoreValue list value =
    deleteByFieldKey value.key list |> (::) value

findByPanelKey : PanelKey -> List StoreValue -> List StoreValue
findByPanelKey key list =
    List.filter (\store -> store.key.panelKey == key) list

deleteByPanelKey : PanelKey -> List StoreValue -> List StoreValue
deleteByPanelKey key list =
    List.filter (\store -> store.key.panelKey /= key) list

savePanelKey : PanelKey -> List StoreValue -> List StoreValue -> List StoreValue
savePanelKey key newValues oldValues =
    deleteByPanelKey key oldValues |> (++) newValues

-- Persistence


updateStoreKeyValue : FieldKey  ->  String -> List StoreValue -> List StoreValue
updateStoreKeyValue key str list =
    list

selectToken: Maybe FieldKey ->  Int -> List StoreValue -> Maybe (TokenValue (List (Int, String)))
selectToken maybeFkey tokenId list =
    case maybeFkey of
        Just fkey ->
            case (findOneValueByFieldKey fkey list) of
                ContributionValue tokens ->
                    Token.find tokenId tokens |> Maybe.map Contributing.toStringListToken

                anythingElse ->
                    Nothing
        Nothing ->
            Nothing

getNextRank: FieldKey  -> (TokenValue (List (Int, String)))  -> List StoreValue -> Int
getNextRank fieldKey tokenValue list =
    findOneValueByFieldKey fieldKey list |> FieldPersistence.getNextRank tokenValue.rank

deleteToken:  FieldKey -> TokenValue (List (Int, String)) -> List StoreValue -> List StoreValue
deleteToken fkey tokenValue panelValues =
    case (findOneValueByFieldKey fkey panelValues) of
            ContributionValue tokens ->
                deleteByFieldKey fkey panelValues |> (::) {key = fkey, value = Token.delete tokenValue.uid tokens |> ContributionValue}
            anythingElse ->
                panelValues

saveToken: FieldKey -> TokenValue (List (Int, String)) -> List StoreValue -> List StoreValue
saveToken fkey tokenValue panelValues =
    case (findOneValueByFieldKey fkey panelValues) of
            ContributionValue tokens ->
                panelValues
                -- Contributing.fromStringList dialogValues 
                -- |> Maybe.map (updateValueToken fkey tokenId tokens panelValues) 
                -- |> Maybe.withDefault panelValues
            anythingElse ->
                panelValues

moveTokenUp: FieldKey -> TokenValue (List (Int, String)) -> List StoreValue -> List StoreValue
moveTokenUp fkey tokenValue panelValues =
    panelValues

moveTokenDown: FieldKey -> TokenValue (List (Int, String)) -> List StoreValue -> List StoreValue
moveTokenDown fkey tokenValue panelValues =
    panelValues

