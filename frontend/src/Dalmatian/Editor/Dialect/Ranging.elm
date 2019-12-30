module Dalmatian.Editor.Dialect.Ranging exposing (SelectionRange(..))

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol, keyword)

type SelectionRange =
    SelectAll
    | Unselect
    | SelectOnly (List (Int, Int))
    | SelectAllExcept (List (Int, Int))

