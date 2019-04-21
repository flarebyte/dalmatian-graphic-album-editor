module Dalmatian.Editor.Widget.SnatchField exposing (..)

import Dalmatian.Editor.Dialect.Separator as Separator

separator = "--->"

type alias SnatchItem =
    { value : String
    , display : String
    }

create: String -> String -> ListBoxItem
create value display =
    { value = value
    , display = display
    }


toString: ListBoxItem -> String
toString value =
    value.value ++ separator ++ value.display

toTabularString: List ListBoxItem -> String
toTabularString list =
    list |> List.map toString |> String.join "\n"


parseListBoxItem: String -> Maybe ListBoxItem
parseListBoxItem line =
    let
        splits = String.split separator line
    in
        case splits of
            [value, display] ->
                create (value |> String.trim) (display |> String.trim) |> Just
            otherwise ->
                Nothing

parse: String -> List ListBoxItem
parse text =
    String.lines text |> List.filterMap parseListBoxItem