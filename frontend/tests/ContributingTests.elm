module ContributingTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Parser exposing (run)
import Dalmatian.Editor.Contributing as Contributing exposing (Contribution(..))
import Dalmatian.Editor.Identifier as Identifier exposing (Id(..))
import Dalmatian.Editor.Token as Token exposing (TokenValue)
import Dalmatian.Editor.StringParser as StringParser

fuzzyContribution: Fuzzer Contribution
fuzzyContribution =
    [
        ContributionHeader "contribution:main" "Main contributor"
        , ContributionLanguage "en"
        , ContributionFooter "contribution:main" "Contributors with more than two contributions"
        , Contributor (StringId "a/b/c") "contribution:colorist" "Pencil colored the drawings"
    ] |> List.map constant |> oneOf


suite : Test
suite =
    describe "The Contributing Module"
    [
        describe "toStringList"
        [
            fuzz fuzzyContribution "should conversion both ways to string list" <|
                \contrib ->
                    Contributing.toStringList contrib
                    |> Contributing.fromStringList
                    |> Expect.equal (Just contrib)
        ]
        , describe "toStringListToken"
        [
            fuzz3 int fuzzyContribution int "should conversion both ways to string list" <|
                \uid contrib rank ->
                    TokenValue uid contrib rank |> Contributing.toStringListToken
                    |> Contributing.fromStringListToken
                    |> Expect.equal (TokenValue uid contrib rank |> Just)
        ]
        , describe "contribution parser"
        [
            fuzz fuzzyContribution "should conversion both ways to string" <|
                \contrib ->
                    Contributing.toString contrib
                    |> run Contributing.contributionParser
                    |> Expect.equal (Ok contrib)
        ]
    ]
