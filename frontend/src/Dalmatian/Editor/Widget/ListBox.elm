module Dalmatian.Editor.Widget.ListBox exposing (ListBoxItem, create, toString, toTabularString, sequenceParser)

import Parser exposing ((|.), (|=), Parser, chompWhile, chompUntil, chompUntilEndOr, oneOf, getChompedString, int, map, run, spaces, succeed, symbol, sequence, Step(..), Trailing(..), loop)
import Dalmatian.Editor.Dialect.Separator as Separator

type alias ListBoxItem =
    { value : String
    , display : String
    }

create: String -> String -> ListBoxItem
create value display =
    { value = value
    , display = display
    }

parser : Parser ListBoxItem
parser =
    succeed ListBoxItem
        |= getChompedString (chompUntil "-->")
        |. symbol "--->"
        |= getChompedString (chompUntilEndOr "\n")

toString: ListBoxItem -> String
toString value =
    value.value ++ "--->" ++ value.display

toTabularString: List ListBoxItem -> String
toTabularString list =
    list |> List.map toString |> String.join "\n"

sequenceParser : Parser (List ListBoxItem)
sequenceParser=
    loop [] sequenceHelp

sequenceHelp : List ListBoxItem -> Parser (Step (List ListBoxItem) (List ListBoxItem))
sequenceHelp revStmts =
      oneOf
        [ succeed (\stmt -> Loop (stmt :: revStmts))
            |. spaces
            |= parser
            |. Separator.newline
        , succeed ()
            |> map (\_ -> Done (List.reverse revStmts))
        ]
