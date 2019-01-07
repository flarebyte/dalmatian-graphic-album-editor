module Dalmatian.Album.Coloring exposing (Chroma)

import Dalmatian.Album.Unit exposing (Fraction)

type Chroma =
    RGBA Int Int Int Int
    | HSLA Fraction Fraction Fraction Fraction
    | CMYK Fraction Fraction Fraction Fraction
    | ColorName String

