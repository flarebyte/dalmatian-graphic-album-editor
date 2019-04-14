module Dalmatian.Editor.Tokens.Speech exposing (Transcript, fromString)

import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Ranging exposing (SelectionRange(..))

type Transcript
    = TranscriptFont ResourceId SelectionRange -- fontId range
    | Interlocutor ResourceId ResourceId -- character id, activity id (speaking, thinking, listening, narrating)
    | TranscriptSemantic ResourceId SelectionRange -- (strong, emphasized, deleted, Subscript, Superscript, rtl) list range
    | TranscriptExtra ResourceId ResourceId SelectionRange -- ex: fictional-language goblin


fromString : String -> Transcript
fromString text =
    TranscriptFont (ResourceIdentifier.create "font" "arial") SelectAll
