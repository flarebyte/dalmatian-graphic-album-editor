module Fuzzing exposing (identifier, corruptedIdentifier, curie, path, corruptedCurie, corruptedPath)

import Fuzz as Fuzz exposing (Fuzzer, custom, intRange)
import Random as Random exposing (Generator)
import Random.Char as RandChar
import Random.Extra as RandExtra
import Random.String as RandString
import Shrink as Shrink exposing(Shrinker)


resourceIdentifier : Fuzzer String
resourceIdentifier =
    custom (RandString.string 5 RandChar.english) Shrink.string


alphaNumChar : Generator Char
alphaNumChar = 
    RandExtra.frequency
        ( 5, RandChar.english )
        [ 
            ( 1, RandChar.char 48 57 ) -- digits
        ]

unwantedChar : Generator Char
unwantedChar = 
    RandExtra.frequency
        ( 1, RandChar.arrow)
        [ 
            ( 1, RandChar.char 0 31 )
            , ( 1, RandChar.char 33 44)
            , ( 1, RandChar.char 59 63)
            , ( 1, RandChar.char 91 96)
            , ( 1, RandChar.char 123 126 )
            , ( 1, RandChar.char 127 159 )
            , ( 1, RandChar.boxDrawing)
            , ( 1, RandChar.geometricShape)
        ]        

coreIdentifierChar : Generator Char
coreIdentifierChar =
    RandExtra.frequency
        ( 5, alphaNumChar )
        [ 
            ( 1, Random.constant '-' )
            , ( 1, Random.constant '.' )
            , ( 1, Random.constant '/' )
        ]

pathChar : Generator Char
pathChar =
    RandExtra.frequency
        ( 5, alphaNumChar )
        [ 
            ( 1, Random.constant '-' )
            , ( 1, Random.constant '_' )
            , ( 1, Random.constant '.' )
            , ( 1, Random.constant '/' )
        ]

curieString : Generator String
curieString =
    RandString.rangeLengthString 1 20 alphaNumChar

pathString : Generator String
pathString =
    Random.pair 
    (RandString.rangeLengthString 1 1 alphaNumChar)
    (RandString.rangeLengthString 1 200 pathChar)
    |> Random.map (\p -> Tuple.first p ++ Tuple.second p)
 
identifierString : Generator String
identifierString =
    Random.pair 
    (RandString.rangeLengthString 1 1 alphaNumChar)
    (RandString.rangeLengthString 1 50 coreIdentifierChar)
    |> Random.map (\p -> Tuple.first p ++ Tuple.second p)
    
unwantedString: Generator String
unwantedString =
    RandString.rangeLengthString 1 3 unwantedChar

identifier : Fuzzer String
identifier =
    custom identifierString Shrink.noShrink

curie : Fuzzer String
curie =
    custom curieString Shrink.noShrink

path : Fuzzer String
path =
    custom pathString Shrink.noShrink


corruptString: Int -> String -> String -> String
corruptString pos bad good =
    let 
        pivot = remainderBy (good |> String.length) pos
        safePivot = if pivot == 0 then 1 else pivot
    in
        String.left safePivot good ++ bad ++ String.right safePivot good

corruptedIdentifier : Fuzzer String
corruptedIdentifier =
    Fuzz.map3 corruptString (intRange 3 15) (custom unwantedString Shrink.string) identifier

corruptedCurie : Fuzzer String
corruptedCurie =
    Fuzz.map3 corruptString (intRange 3 15) (custom unwantedString Shrink.string) curie

corruptedPath : Fuzzer String
corruptedPath =
    Fuzz.map3 corruptString (intRange 3 15) (custom unwantedString Shrink.string) path
