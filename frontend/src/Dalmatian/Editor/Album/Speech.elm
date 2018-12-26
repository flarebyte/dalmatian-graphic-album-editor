module Dalmatian.Album.Speech exposing (Interlocutor, Transcript, Model)

import Dalmatian.Album.Thing as Thing

type Interlocutor =
    SpeakingCharacter String -- ex: id
    | ThinkingCharacter String -- ex: id
    | ListeningCharacter String -- ex: id
    | Narrator String -- ex: id

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



    




