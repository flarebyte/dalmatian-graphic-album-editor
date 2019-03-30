module VersionTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.Version as Version
import Fuzzing exposing (version)
import Parser exposing(run)

suite : Test
suite =
    describe "The Version Module"
    [
        describe "parse"
        [
            fuzz version "should parse valid version" <|
                \fn ->
                    Version.toString fn |> run Version.parser
                        |> Expect.equal (Ok fn)
        ]

    ]
