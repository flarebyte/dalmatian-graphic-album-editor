module Dalmatian.Editor.Speech exposing (Interlocutor, Transcript)

import Dalmatian.Editor.Identifier exposing (Id)


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
