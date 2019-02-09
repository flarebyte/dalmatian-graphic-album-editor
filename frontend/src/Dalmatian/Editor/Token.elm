module Dalmatian.Editor.Token exposing (TokenValue, delete, find, findByPosition, findStringByPosition, getNextRank, getPreviousRank, update, upsert, updateRank)


type alias TokenValue v =
    { uid : Int
    , value : v
    , rank : Int
    }


findByPosition : Int -> List ( Int, String ) -> Maybe String
findByPosition idx list =
    list |> List.filter (\iv -> Tuple.first iv == idx) |> List.head |> Maybe.map Tuple.second


findStringByPosition : Int -> List ( Int, String ) -> String
findStringByPosition idx list =
    findByPosition idx list |> Maybe.withDefault ""


find : Int -> List (TokenValue a) -> Maybe (TokenValue a)
find tokenId tokens =
    tokens |> List.filter (\tk -> tk.uid == tokenId) |> List.head


delete : Int -> List (TokenValue a) -> List (TokenValue a)
delete tokenId tokens =
    tokens |> List.filter (\tk -> tk.uid /= tokenId)


update : List (TokenValue a) -> Int -> a -> List (TokenValue a)
update tokens tokenId token =
    tokens
        |> List.map
            (\t ->
                if t.uid == tokenId then
                    { t | value = token }

                else
                    t
            )

updateRank: List (TokenValue a) -> Int -> Int -> List (TokenValue a)
updateRank tokens tokenId rank =
    tokens
        |> List.map
            (\t ->
                if t.uid == tokenId then
                    { t | rank = rank }

                else
                    t
            )

upsert : TokenValue a -> List (TokenValue a) -> List (TokenValue a)
upsert token tokens =
    delete token.uid tokens |> (::) token


getNextRankAbove : Int -> List (TokenValue a) -> Int
getNextRankAbove start tokens =
    List.map .rank tokens |> List.filter (\rank -> rank > start) |> List.sort |> List.head |> Maybe.withDefault (start + 1000)


getNextRank : Int -> List (TokenValue a) -> Int
getNextRank start tokens =
    start + (getNextRankAbove start tokens - start) // 2

flippedComparison a b =
    case compare a b of
      LT -> GT
      EQ -> EQ
      GT -> LT

getPreviousRankBelow : Int -> List (TokenValue a) -> Int
getPreviousRankBelow start tokens =
    List.map .rank tokens  |> List.filter (\rank -> rank < start) |> List.sortWith flippedComparison |> List.head |> Maybe.withDefault (start - 1000)

getPreviousRank : Int -> List (TokenValue a) -> Int
getPreviousRank start tokens =
    start - (start - getPreviousRankBelow start tokens) // 2
