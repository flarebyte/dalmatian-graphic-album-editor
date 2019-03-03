module Dalmatian.Editor.Dialect.Version exposing (SemanticVersion, parse)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol)


type alias SemanticVersion =
    { major : Int
    , minor : Int
    , patch : Int
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


parse : String -> Result String SemanticVersion
parse str =
    case run parser str of
        Ok foundVersion ->
            Ok foundVersion

        Err msg ->
            Err "The format for version should be like 1.0.0"