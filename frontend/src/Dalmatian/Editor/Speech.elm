module Dalmatian.Editor.Speech exposing (Interlocutor, Transcript, fromStringInterlocutor)

import Dalmatian.Editor.Dialect.Identifier exposing (Id(..))


type Interlocutor
    = SpeakingCharacter Id
    | ThinkingCharacter Id
    | ListeningCharacter Id
    | Narrator Id


type Transcript
    = TranscriptLanguage String
    | SpeechText String
    | StrongText
    | EmphasizedText
    | DeletedText
    | SubscriptText
    | SuperscriptText
    | MarkedText Int Int -- fontId, size


fromStringInterlocutor : String -> Interlocutor
fromStringInterlocutor text =
    Narrator (StringId "")
