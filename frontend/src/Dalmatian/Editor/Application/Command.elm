module Dalmatian.Application.Command exposing (Zone, AppCommand)

import Dalmatian.Album.Identifier exposing (Id)
import Dalmatian.Album.Compositing exposing (Stencil, Illustration)
import module Dalmatian.Album.Speech exposing (Model)
import Dalmatian.Album.Coloring exposing (Model)
import module Dalmatian.Album.Speech exposing (Model)
import Dalmatian.Album.PublishedWork exposing (Model)
import Dalmatian.Album.GraphicAlbum exposing (Model)

type Zone =
    GraphicAlbumZone
    | ContributionZone
    | ColorZone
    | FontZone
    | IllustrationZone
    | StencilZone
    | SpeechZone
    | PublishedWorkZone
    | LanguageZone

type AppCommand =
    QuitApplication
    | SwitchEditView Zone
    | SwitchListView Zone
    | SwitchLanguage String
    | NewAlbumFile String
    | OpenAlbumFile String
    | SaveAlbumFile
    | ListZone Zone
    | DeleteZone Zone Id
    | EditColoring Coloring.Model
    | EditIllustration Illustration
    | EditStencil Stencil
    | EditFont Thing
    | EditSpeech Speech.Model
    | EditPublishedWork PublishedWork.Model
    | EditGraphicAlbum GraphicAlbum.Model
    | EditLanguage String


    
    