module Dalmatian.Editor.Dialect.Coloring exposing (Chroma, parser, parse, toString)

import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol)
import Set
import Dalmatian.Editor.Dialect.FractionUnit as FractionUnit exposing (Fraction)
import Dalmatian.Editor.Dialect.Stringy as Stringy

type Chroma
    = RGBA Int Int Int Int
    | HSLA Fraction Fraction Fraction Fraction
    | CMYK Fraction Fraction Fraction Fraction
    | ColorName String


toString : Chroma -> String
toString chroma =
        case chroma of
        RGBA r g b a ->
            "RGBA"

        HSLA h s l a ->
            "HSLA"
        
        CMYK c m y k ->
            "CMYK"
        
        ColorName name ->
            "ColorName"

parser : Parser Chroma
parser =
  oneOf
    [succeed RGBA
        |. symbol "RGBA"
        |.spaces
        |= int
        |.spaces
        |= int
        |.spaces
        |= int
        |.spaces
        |= int
        |.spaces
    , succeed HSLA
        |. symbol "HSLA"
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
    , succeed CMYK
        |. symbol "CMYK"
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
    , succeed ColorName
        |. symbol "ColorName"
        |.spaces
        |= Stringy.parser   
        |.spaces
    ]

parse : String -> Result String Chroma
parse str =
    case run parser str of
        Ok ab ->
            Ok ab

        Err msg ->
            Err "The format for chroma is invalid"
