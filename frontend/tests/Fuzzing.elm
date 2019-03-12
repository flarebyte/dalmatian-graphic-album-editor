module Fuzzing exposing (identifier)

import Fuzz exposing (Fuzzer, custom)
import Random as Random exposing (Generator)
import Random.Char as RandChar
import Random.Extra as RandExtra
import Random.String as RandString
import Shrink


resourceIdentifier : Fuzzer String
resourceIdentifier =
    custom (RandString.string 5 RandChar.english) Shrink.string


alphaNumChar : Generator Char
alphaNumChar = 
    RandExtra.frequency
        ( 5, RandChar.upperCaseLatin )
        [ 
            ( 1, RandChar.char 48 57 ) -- digits
        ]

identifierChar : Generator Char
identifierChar =
    RandExtra.frequency
        ( 5, alphaNumChar )
        [ 
            ( 1, Random.constant '-' )
            , ( 1, Random.constant '_' )
            , ( 1, Random.constant '.' )
            , ( 1, Random.constant '/' )
        ]


identifier : Fuzzer String
identifier =
    custom (RandString.rangeLengthString 1 50 identifierChar) Shrink.noShrink
