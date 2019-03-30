module ResourceIdentifierTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, intRange, char, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier exposing (ResourceId, create, createByUrl)
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
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (ResourceIdentifier.create c p))
                        |> Expect.equal (ResourceIdentifier.create c p)

            , fuzz2 curie corruptedPath "should reject corrupted path" <|
                \c p ->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (ResourceIdentifier.create c p))
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
            
            , fuzz2 curie path "should reject very long path" <|
                \c p ->
                    ResourceIdentifier.fromString ( c  ++ ":" ++ longPrefix ++ p )
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidLengthFailure)
           
           , fuzz2 corruptedCurie path "should reject corrupted curie" <|
                \c p ->
                    ResourceIdentifier.fromString (c  ++ ":" ++ p)
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
            
            , fuzz2 curie path "should reject very long curie" <|
                \c p ->
                    ResourceIdentifier.fromString (longPrefix ++ c  ++ ":" ++ p)
                       |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidLengthFailure)
            
            , fuzz url "should support url" <|
                \u->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (ResourceIdentifier.createByUrl u))
                        |> Expect.equal (ResourceIdentifier.createByUrl u)
            
            , fuzz corruptedUrl "should reject corrupted url" <|
                \u ->
                    ResourceIdentifier.fromString (ResourceIdentifier.toString (ResourceIdentifier.createByUrl u))
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
             
             , fuzz corruptedUrl "should reject very long url" <|
                \u ->
                    ResourceIdentifier.fromString ("<" ++ longPrefix ++ u ++ ">")
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidLengthFailure)
             
             , fuzz2 char url "should reject url not starting with http" <|
                \c u->
                    ResourceIdentifier.fromString ("h" ++ String.fromChar c ++ u)
                        |>ResourceIdentifier.getInvalidResourceId |> Maybe.map .kind |> Expect.equal (Just InvalidFormatFailure)
        ]
    ]
