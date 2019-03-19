module ResourceIdentifierTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier exposing (ResourceId(..))
import Fuzzing exposing (curie, path, corruptedCurie, corruptedPath, url, corruptedUrl)
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)

longPrefix = String.repeat 350 "a"

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

            , fuzz2 curie corruptedPath "should reject corrupted path" <|
                \c p ->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (ResId c p))
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
            
            , fuzz2 curie path "should reject very long path" <|
                \c p ->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (longPrefix ++ p |> ResId c))
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidLengthFailure)
           
           , fuzz2 corruptedCurie path "should reject corrupted curie" <|
                \c p ->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (ResId c p))
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
            
            , fuzz2 curie path "should reject very long curie" <|
                \c p ->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString ( ResId (longPrefix ++ c) p))
                       |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidLengthFailure)
            
            , fuzz url "should support FullResId" <|
                \u->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (FullResId u))
                        |> Expect.equal (FullResId u)
        ]
    ]
