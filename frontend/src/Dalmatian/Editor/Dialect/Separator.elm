module Dalmatian.Editor.Dialect.Separator exposing (space, newline)

import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, keyword, chompUntilEndOr, end)
import Set


space : Parser ()
space =
  oneOf
    [succeed ()
        |. symbol " "
    , succeed ()
        |. end
    ]

newline : Parser ()
newline =
  oneOf
    [succeed ()
        |. symbol "\n"
     , succeed ()
        |. symbol "\r"
    , succeed ()
        |. end
    ]
