module Dalmatian.Editor.StringParser exposing (stringParser, toDialectString, postParsing)

import Parser exposing (..)
import Set
import Regex

quoteMarker = "❘"
quoteMarkerChar = '❘'
escapeMarker = "\\"
escapeMarkerChar = '\\'

internMarker = "❚"

replaceAll : String -> String -> String -> String
replaceAll userRegex replacement str =
  case Regex.fromString userRegex of
    Nothing ->
      str

    Just regex ->
      Regex.replace regex (\_ -> replacement) str

-- STRINGS

stringParser : Parser String
stringParser =
  succeed identity
    |. token quoteMarker
    |= loop [] stringHelp

toDialectString: String -> String
toDialectString str =
  quoteMarker ++ (str |> replaceAll quoteMarker "" |> replaceAll "\\\\" internMarker ) ++ quoteMarker

postParsing: String -> String
postParsing str =
  str |> replaceAll internMarker "\\"

stringHelp : List String -> Parser (Step (List String) String)
stringHelp revChunks =
  oneOf
    [ succeed (\chunk -> Loop (chunk :: revChunks))
        |. token escapeMarker
        |= oneOf
            [ map (\_ -> "\n") (token "n")
            , map (\_ -> "\t") (token "t")
            , map (\_ -> "\r") (token "r")
            , succeed String.fromChar
                |. token "u{"
                |= unicode
                |. token "}"
            ]
    , token quoteMarker
        |> map (\_ -> Done (String.join "" (List.reverse revChunks)))
    , chompWhile isUninteresting
        |> getChompedString
        |> map (\chunk -> Loop (chunk :: revChunks))
    ]

isUninteresting : Char -> Bool
isUninteresting char =
  char /= escapeMarkerChar && char /= quoteMarkerChar

-- UNICODE

unicode : Parser Char
unicode =
  getChompedString (chompWhile Char.isHexDigit)
    |> andThen codeToChar


codeToChar : String -> Parser Char
codeToChar str =
  let
    length = String.length str
    code = String.foldl addHex 0 str
  in
  if 4 <= length && length <= 6 then
    problem "code point must have between 4 and 6 digits"
  else if 0 <= code && code <= 0x10FFFF then
    succeed (Char.fromCode code)
  else
    problem "code point must be between 0 and 0x10FFFF"


addHex : Char -> Int -> Int
addHex char total =
  let
    code = Char.toCode char
  in
  if 0x30 <= code && code <= 0x39 then
    16 * total + (code - 0x30)
  else if 0x41 <= code && code <= 0x46 then
    16 * total + (10 + code - 0x41)
  else
    16 * total + (10 + code - 0x61)