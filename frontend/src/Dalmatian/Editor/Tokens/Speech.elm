module Dalmatian.Editor.Tokens.Speech exposing (Interlocutor, Transcript, fromStringInterlocutor)

import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier exposing (ResourceId)


type Interlocutor
    = SpeakingCharacter ResourceId
    | ThinkingCharacter ResourceId
    | ListeningCharacter ResourceId
    | Narrator ResourceId


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
    Narrator (ResourceIdentifier.create "inter" "abc")
