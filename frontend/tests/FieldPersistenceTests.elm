module FieldPersistenceTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, intRange, list, string, constant, oneOf)
import Test exposing (..)
import Dalmatian.Editor.Schema exposing (FieldKey, FieldType(..))
import Dalmatian.Editor.Version as Version exposing (SemanticVersion)
import Dalmatian.Editor.FieldPersistence exposing (FieldValue(..), isValidFieldValue, toStringFieldValue)


createVersion: Int -> Int -> Int -> String
createVersion a b c =
    (String.fromInt a) ++ "." ++ (String.fromInt b ) ++ "." ++ (String.fromInt c)

suite : Test
suite =
    describe "The Field Persistence Module"
    [
        describe "toStringFieldValue"
        [
            fuzz3 (intRange 0 1000) (intRange 0 100000) (intRange 0 100000) "should support valid version" <|
                \a b c ->
                    toStringFieldValue VersionType "en" 0 (createVersion a b c) (VersionValue (SemanticVersion 1 1 0))
                        |> Expect.equal (VersionValue (SemanticVersion a b c))

            , fuzz string "should reject invalid version" <|
                \newStr ->
                    toStringFieldValue VersionType "en" 0 newStr (VersionValue (SemanticVersion 1 1 0))
                        |> isValidFieldValue
                        |> Expect.equal False
        ]
    ]
