module Fuzzing exposing (unwanted,
     identifier, corruptedIdentifier, curie, path,
     corruptedCurie, corruptedPath, url, corruptedUrl,
     positiveNumber, positiveNumberOrZero, fraction, version, alpha, corruptedAlpha)

import Fuzz as Fuzz exposing (Fuzzer, custom, intRange)
import Random as Random exposing (Generator)
import Random.Char as RandChar
import Random.Extra as RandExtra
import Random.String as RandString
import Shrink as Shrink exposing(Shrinker)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)
import Dalmatian.Editor.Dialect.Version exposing (SemanticVersion)

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

asciiList = List.range 1 159 |> List.map Char.fromCode

unwantedAscii: List Char -> Generator Char
unwantedAscii excluding =
    asciiList |> List.filter (\c -> List.member c excluding  || Char.isAlphaNum c |> not) |> List.map (\c -> ( 1, Random.constant c )) |> RandExtra.frequency ( 1, Random.constant '!' )

wantedAscii: List Char -> Generator Char
wantedAscii including =
    including |> List.map (\c -> ( 1, Random.constant c )) |> RandExtra.frequency ( 5, alphaNumChar )


unwantedChar : List Char -> Generator Char
unwantedChar excluding = 
    RandExtra.frequency
        ( 1, unwantedAscii excluding)
        [   
            ( 1, RandChar.arrow)
            , ( 1, RandChar.boxDrawing)
            , ( 1, RandChar.geometricShape)
        ]        

pathString : Generator String
pathString =
    Random.pair 
    (RandString.rangeLengthString 1 1 alphaNumChar)
    (RandString.rangeLengthString 1 200 (wantedAscii ['-', '_', '.', '/']))
    |> Random.map (\p -> Tuple.first p ++ Tuple.second p)
 
identifierString : Generator String
identifierString =
    Random.pair 
    (RandString.rangeLengthString 1 1 alphaNumChar)
    (RandString.rangeLengthString 1 50 (wantedAscii ['-', '.', '/']))
    |> Random.map (\p -> Tuple.first p ++ Tuple.second p)

urlString : Generator String
urlString =
    pathString
    |> Random.map (\p -> "https://" ++ p)

unwantedString: List Char -> Generator String
unwantedString excluding =
    RandString.rangeLengthString 1 3 (unwantedChar excluding)

identifier : Fuzzer String
identifier =
    custom identifierString Shrink.noShrink

curie : Fuzzer String
curie =
    custom (RandString.rangeLengthString 1 20 alphaNumChar) Shrink.noShrink

alpha : Fuzzer String
alpha =
    custom (RandString.rangeLengthString 1 20 RandChar.english) Shrink.noShrink    

path : Fuzzer String
path =
    custom pathString Shrink.noShrink

url : Fuzzer String
url =
    custom urlString Shrink.noShrink

unwanted : List Char -> Fuzzer String
unwanted excluding =
    custom (unwantedString excluding) Shrink.noShrink

corruptString: Int -> String -> String -> String
corruptString pos bad good =
    let 
        pivot = remainderBy (good |> String.length) pos
        safePivot = if pivot == 0 then 1 else pivot
    in
        String.left safePivot good ++ bad ++ String.dropLeft safePivot good

corruptedIdentifier : Fuzzer String
corruptedIdentifier =
    Fuzz.map3 corruptString (intRange 3 15) (unwanted ['-', '.', '/', ' ']) identifier

corruptedCurie : Fuzzer String
corruptedCurie =
    Fuzz.map3 corruptString (intRange 3 15) (unwanted []) curie

corruptedPath : Fuzzer String
corruptedPath =
    Fuzz.map3 corruptString (intRange 3 15)  (unwanted ['-', '_', '.', '/', ' ']) path

corruptedUrl : Fuzzer String
corruptedUrl =
    Fuzz.map3 corruptString (intRange 8 20) (unwanted ['-', '_', '.', '/', '<', '>']) url

corruptedAlpha : Fuzzer String
corruptedAlpha =
    Fuzz.map3 corruptString (intRange 8 20) (unwanted ['-', '_', ' ']) alpha

positiveNumber : Fuzzer Int
positiveNumber = 
    intRange 1 1000000000

positiveNumberOrZero : Fuzzer Int
positiveNumberOrZero = 
    intRange 0 1000000000

fraction: Fuzzer Fraction
fraction =
    Fuzz.custom
            (Random.map2 Fraction (Random.int 0 1000000000) (Random.int 1 1000000000))
            (\{ numerator, denominator } -> Shrink.map Fraction (Shrink.int numerator) |> Shrink.andMap (Shrink.int denominator))

version: Fuzzer SemanticVersion
version =
    Fuzz.custom
            (Random.map3 SemanticVersion (Random.int 0 1000000000) (Random.int 0 1000000000) (Random.int 0 1000000000))
            (\{ major, minor, patch } -> Shrink.map SemanticVersion (Shrink.int major) |> Shrink.andMap (Shrink.int minor) |> Shrink.andMap (Shrink.int patch))

