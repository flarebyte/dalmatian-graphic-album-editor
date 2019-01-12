module Dalmatian.Editor.Coloring exposing (Chroma)

import Dalmatian.Editor.Unit exposing (Fraction)


type Chroma
    = RGBA Int Int Int Int
    | HSLA Fraction Fraction Fraction Fraction
    | CMYK Fraction Fraction Fraction Fraction
    | ColorName String
