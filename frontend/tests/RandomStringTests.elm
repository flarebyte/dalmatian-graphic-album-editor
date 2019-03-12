module RandomStringTests exposing (..)

import Expect as Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, custom)
import Test exposing (..)
import Random.String as RandomString
import Shrink exposing (Shrinker)
import Random.Char exposing(upperCaseLatin)

character : Shrinker Char
character =
    Shrink.atLeastChar (Char.fromCode 40)

shrinkString: Shrinker String
shrinkString = 
    Shrink.convert String.fromList String.toList (Shrink.list character)

suite : Test
suite =
    describe "The Random String Module"
    [
        describe "string"
        [
            fuzzWith { runs = 10000 } (custom (RandomString.string 2 upperCaseLatin) Shrink.noShrink) "should generate a string of a given size" <|
                \str ->
                       String.length str |> Expect.equal 2
        ]
        , describe "rangeLengthString"
        [
            fuzzWith { runs = 10000 } (custom (RandomString.rangeLengthString 2 60 upperCaseLatin) Shrink.noShrink) "should generate a string within a range size" <|
                \str ->
                       String.length str |> Expect.all [ Expect.atLeast 2, Expect.atMost 60]
        ]
             
    ]
