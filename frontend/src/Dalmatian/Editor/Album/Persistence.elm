module Dalmatian.Album.Persistence

import Dalmatian.Album.Schema exposing(appUI, FieldType, PredicateKey)
import Dalmatian.Album.Identifier exposing (Id)
import Dalmatian.Album.Compositing exposing (Composition, Stencil, Illustration, BinaryData)
import module Dalmatian.Album.Speech exposing (Model)
import Dalmatian.Album.Coloring exposing (Model, Chroma)
import Dalmatian.Album.Speech exposing (Interlocutor, Transcript)
import Dalmatian.Album.PublishedWork exposing (Model)
import Dalmatian.Album.GraphicAlbum exposing (Model)
import Dalmatian.Album.LocalizedString exposing (Model)
import Dalmatian.Album.Unit exposing (Fraction, Position2D, Dimension2D, Position2DInt, Dimension2DInt)
import Dalmatian.Album.Tile exposing (TileInstruction)

type FieldValue = ShortLocalizedListValue (List LocalizedString.Model)
    | MediumLocalizedValue LocalizedString.Model
    | TextAreaLocalizedValue LocalizedString.Model
    | IdValue Id
    | VersionValue String
    | UrlListValue (List String)
    | DateTimeValue String
    | LanguageValue String
    | ChromaValue Chroma
    | CompositionValue (List Composition)
    | BinaryDataValue BinaryData
    | Dimension2DIntValue Dimension2DInt
    | ContributionValue (List Contribution)
    | ListBoxValue String
    | LayoutValue (List TileInstruction)
    | InterlocutorValue (List Interlocutor)
    | TranscriptValue (List Transcript)

 type alias StoreValue = {
     path: String
     , key: PredicateKey
     , fieldType: FieldType
     , value: FieldValue
 }   