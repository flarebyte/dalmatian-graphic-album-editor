module ListBoxTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, tuple, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Widget.ListBox as ListBox
import Fuzzing exposing (alpha, corruptedAlpha)

listToTabular: List (String, String) -> String
listToTabular list =
    list |> List.map (\tuple -> ListBox.create (Tuple.first tuple) (Tuple.second tuple)) |> ListBox.toTabularString

suite : Test
suite =
    describe "The ListBox Module"
    [
        describe "fromString"
        [
            fuzz (list (tuple (string, string))) "should parse tabular data" <|
                \li ->
                    listToTabular li
                        |> ListBox.parse
                        |> List.length
                        |> Expect.equal (List.length li)
        ]

    ]

