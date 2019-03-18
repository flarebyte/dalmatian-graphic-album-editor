module ResourceIdentifierTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier exposing (ResourceId(..))
import Fuzzing exposing (curie, path, corruptedCurie, corruptedPath)

longPrefix = String.repeat 300 "a"

suite : Test
suite =
    describe "The Resource Identifier Module"
    [
        describe "fromString"
        [
            fuzz2 curie path "should support ResId" <|
                \c p->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (ResId c p))
                        |> Expect.equal (ResId c p)

            -- , fuzz2 curie corruptedPath "should reject corrupted identifier" <|
            --     \c p ->
            --         ResourceIdentifier.fromString (ResourceIdentifier.toString (ResId c p))
            --             |>ResourceIdentifier.isInvalid |> Expect.equal True
            
            -- , fuzz2 curie path "should reject very long identifier" <|
            --     \c p ->
            --         ResourceIdentifier.fromString (ResourceIdentifier.toString (longPrefix ++ p |> ResId c))
            --             |>ResourceIdentifier.isInvalid |> Expect.equal True
        ]
    ]
