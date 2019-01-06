module Dalmatian.Album.Coloring exposing (Model, Chroma)

import Dalmatian.Album.LocalizedString as LocalizedString
import Dalmatian.Album.Identifier exposing (Id)
import Dalmatian.Album.Unit exposing (Fraction)

type Chroma =
    RGBA Int Int Int Int
    | HSLA Fraction Fraction Fraction Fraction
    | CMYK Fraction Fraction Fraction Fraction
    | ColorName String

type alias Model =
    { 
        identifier: Id  
        , name: List LocalizedString.Model
        , description: List LocalizedString.Model
        , sameAs: List String --ex: wikipedia page
        , printColor: Chroma
        , screenColor: Chroma
    }
