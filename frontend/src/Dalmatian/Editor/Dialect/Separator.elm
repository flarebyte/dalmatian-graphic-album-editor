module Dalmatian.Editor.Dialect.Separator exposing (space)

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
