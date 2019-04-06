module Dalmatian.Editor.Data.Defaults exposing(..)

import Dalmatian.Editor.Schema exposing(DataId(..))
import Dalmatian.Editor.Widget.ListBox as ListBox exposing (ListBoxItem)

getListBoxItems: DataId -> List ListBoxItem
getListBoxItems dataId =
    case dataId of
        MediumId ->
            mediumIdData
        FormatId ->
            formatIdData

mediumIdData =
    """
    dlm:medium/monochrome/brochure ---> Monochrome brochure
    dlm:medium/polychrome/brochure ---> Polychrome brochure
    dlm:medium/monochrome/screen ---> Monochrome screen
    dlm:medium/polychrome/screen ---> Polychrome screen
    """ |> ListBox.parse

formatIdData =
    """
    dlm:format/a5 ---> A5
    dlm:format/a4 ---> A4
    dlm:format/a3 ---> A3
    dlm:format/comic-book ---> Comic Book (6.63 x 10.25 inch)
    dlm:format/us-trade ---> US Trade ( 6 x 9 inch)
    dlm:format/us-letter ---> US Letter (8.5 x 11 inch)
    dlm:format/square-8.5 ---> square (8.5 x 8.5 inch)
    dlm:format/japanese-b6 ---> Japanese B6
    dlm:format/screen/landscape ---> Screen Landscape
    dlm:format/screen/portrait ---> Screen Portrait
    """ |> ListBox.parse