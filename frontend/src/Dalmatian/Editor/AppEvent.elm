module Dalmatian.Editor.AppEvent exposing (UIEvent(..))

import Dalmatian.Editor.Selecting exposing (UISelector)
import Dalmatian.Editor.Dialect.LanguageIdentifier exposing (LanguageId)
import Dalmatian.Editor.FieldOperating exposing (FieldOperation)

type UIEvent
    = OnNewUI UISelector
    | OnLoadUI UISelector
    | OnDeleteUI UISelector
    | OnSaveUI
    | OnUpdateCurrentField FieldOperation String
    | OnUpdateField UISelector FieldOperation String
    | OnReshapeCurrentField FieldOperation
    | OnReshapeField UISelector FieldOperation

