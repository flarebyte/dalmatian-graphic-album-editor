module Dalmatian.Editor.Version exposing (SemanticVersion, parse)

import Parser exposing (Parser, (|.), (|=), succeed, symbol, int, spaces, run, getChompedString, map, chompWhile)


type alias SemanticVersion =
  { major : Int
  , minor : Int
  , patch: Int
  }

toIntOrZero: String -> Int
toIntOrZero str =
    String.toInt str |> Maybe.withDefault 0

versionParser : Parser SemanticVersion
versionParser =
  succeed SemanticVersion
    |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)
    |. symbol "."
    |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)
    |. symbol "."
    |= (map toIntOrZero <| getChompedString <| chompWhile Char.isDigit)

parse: String -> Result String SemanticVersion
parse str =
    case run versionParser str of
        Ok foundVersion ->
            Ok foundVersion
        Err msg ->
                Err "The format for version should be like 1.0.0"
