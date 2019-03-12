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

coreIdentifierChar : Generator Char
coreIdentifierChar =
    RandExtra.frequency
        ( 5, alphaNumChar )
        [ 
            ( 1, Random.constant '-' )
            , ( 1, Random.constant '_' )
            , ( 1, Random.constant '.' )
            , ( 1, Random.constant '/' )
        ]


identifierString : Generator String
identifierString =
    Random.pair 
    (RandString.rangeLengthString 1 1 alphaNumChar)
    (RandString.rangeLengthString 1 50 coreIdentifierChar)
    |> Random.map (\p -> Tuple.first p ++ Tuple.second p)
    

identifier : Fuzzer String
identifier =
    custom identifierString Shrink.noShrink
