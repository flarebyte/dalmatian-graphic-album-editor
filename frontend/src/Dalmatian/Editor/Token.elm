module Dalmatian.Editor.Token exposing (findByPosition, findStringByPosition, findToken, deleteToken)

findByPosition: Int -> List (Int, String) -> Maybe String
findByPosition idx list =
    list |> List.filter (\iv -> Tuple.first iv == idx) |> List.head |> Maybe.map Tuple.second

findStringByPosition: Int -> List (Int, String) -> String
findStringByPosition idx list =
    findByPosition idx list |> Maybe.withDefault ""

findToken: Int -> List (Int, a) -> Maybe a
findToken tokenId tokens =
    tokens |> List.filter (\tk -> (Tuple.first tk) == tokenId) |> List.head |> Maybe.map Tuple.second

deleteToken: Int -> List (Int, a) -> List (Int, a)
deleteToken tokenId tokens =
    tokens |> List.filter (\tk -> (Tuple.first tk) /= tokenId)