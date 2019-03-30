module TokenTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Tokens.Token as Token exposing (TokenValue)

tokens = [
    TokenValue 1 1 1000
    , TokenValue 2 2 2000
    , TokenValue 3 3 3000
    , TokenValue 4 4 4000
    , TokenValue 5 5 5000
    , TokenValue 6 6 6000
    , TokenValue 7 7 7000
    , TokenValue 8 8 8000
    ]

suite : Test
suite =
    describe "The Token Module"
    [
        describe "find"
        [
            fuzz (intRange 1 8) "should find token" <|
                \uid ->
                    Token.find uid tokens |> Maybe.map .value
                        |> Expect.equal (Just uid)
         ]
        , describe "delete"
        [
            fuzz (intRange 1 8) "should delete token" <|
                \uid ->
                    Token.delete uid tokens |> Token.find uid
                        |> Expect.equal Nothing
         ]
        , describe "update"
        [
            fuzz (intRange 1 8) "should update token value" <|
                \uid ->
                    Token.update tokens uid 17 |> Token.find uid |> Maybe.map .value
                        |> Expect.equal (Just 17)
         ]
        , describe "updateRank"
        [
            fuzz (intRange 1 8) "should update token rank" <|
                \uid ->
                    Token.updateRank tokens uid 777 |> Token.find uid |> Maybe.map .rank
                        |> Expect.equal (Just 777)
         ]
        , describe "getNextRank"
        [
            fuzz (intRange 1 8) "should get the next rank value" <|
                \start ->
                    Token.getNextRank (start*1000) tokens
                        |> Expect.equal (start*1000+500)
         ]
        , describe "getPreviousRank"
        [
            fuzz (intRange 1 8) "should get the previous rank value" <|
                \start ->
                    Token.getPreviousRank (start*1000) tokens
                        |> Expect.equal (start*1000-500)
         ]

    ]
