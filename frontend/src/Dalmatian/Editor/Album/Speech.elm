module Dalmatian.Album.Speech exposing (Interlocutor, Transcript, Model)

import Dalmatian.Album.Thing as Thing
import Dalmatian.Album.Identifier exposing (Id)

type Interlocutor =
    SpeakingCharacter Id
    | ThinkingCharacter Id
    | ListeningCharacter Id
    | Narrator Id

type Transcript =
    TranscriptLanguage String
    | SpeechText String
    | StrongText
    | EmphasizedText
    | DeletedText
    | SubscriptText
    | SuperscriptText
    | MarkedText
    | TextFont Thing.Model Int -- , size

type alias Model =
    {
        interlocutor: List Interlocutor
        , transcript: List Transcript
    }



    




