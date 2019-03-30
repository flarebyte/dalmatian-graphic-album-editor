module Dalmatian.Editor.Dialect.Version exposing (SemanticVersion, parser, toString, create)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol, keyword)


type alias SemanticVersion =
    { major : Int
    , minor : Int
    , patch : Int
    }

create: Int -> Int -> Int -> SemanticVersion
create major minor patch =
    {
        major = major
        , minor = minor
        , patch = patch
    }

toIntOrZero : String -> Int
toIntOrZero str =
    String.toInt str |> Maybe.withDefault 0


parser : Parser SemanticVersion
parser =
    succeed SemanticVersion
        |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)
        |. symbol "."
        |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)
        |. symbol "."
        |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)


toString: SemanticVersion -> String
toString v =
    (String.fromInt v.major) ++ "." ++ (String.fromInt v.minor ) ++ "." ++ (String.fromInt v.patch)
