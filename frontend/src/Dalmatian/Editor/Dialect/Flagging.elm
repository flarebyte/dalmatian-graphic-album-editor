module Dalmatian.Editor.Dialect.Flagging exposing (OperationFlag)

import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, int, map, run, spaces, succeed, symbol, keyword)

type OperationFlag =
    NoFlag
    | IntFlag