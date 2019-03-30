module Dalmatian.Editor.Dialect.Coloring exposing (Chroma, parser, fromString, toString, createRGBA, createHSLA, createCMYK, create)

import Parser exposing ((|.), (|=), Parser, oneOf, chompWhile, getChompedString, int, variable, map, run, spaces, succeed, symbol, keyword)
import Set
import Dalmatian.Editor.Dialect.FractionUnit as FractionUnit exposing (Fraction)
import Dalmatian.Editor.Dialect.ResourceIdentifier as ResourceIdentifier exposing(ResourceId)
import Dalmatian.Editor.Dialect.Failing as Failing exposing (FailureKind(..), Failure)

type Chroma
    = RedGreenBlueAlpha Int Int Int Int
    | HueSLA Fraction Fraction Fraction Fraction
    | CMYK Fraction Fraction Fraction Fraction
    | ColorId ResourceId
    | InvalidChroma Failure


createRGBA: Int -> Int -> Int -> Int -> Chroma
createRGBA r g b a =
    RedGreenBlueAlpha r g b a

createHSLA: Fraction -> Fraction -> Fraction -> Fraction -> Chroma
createHSLA h s l a =
    HueSLA h s l a

createCMYK: Fraction -> Fraction -> Fraction -> Fraction -> Chroma
createCMYK c m y k =
    CMYK c m y k

create: ResourceId -> Chroma
create resId =
    ColorId resId

toString : Chroma -> String
toString chroma =
        case chroma of
        RedGreenBlueAlpha r g b a ->
            "RGBA=" ++ (String.fromInt r) ++ " " ++  (String.fromInt g) ++ " " 
            ++ (String.fromInt b) ++ " " ++ (String.fromInt a)

        HueSLA h s l a ->
            "HSLA=" ++ (FractionUnit.toString h) ++ " " ++  (FractionUnit.toString s) ++ " " 
            ++ (FractionUnit.toString l) ++ " " ++ (FractionUnit.toString a)
        
        CMYK c m y k ->
            "CMYK=" ++ (FractionUnit.toString c) ++ " " ++  (FractionUnit.toString m) ++ " " 
            ++ (FractionUnit.toString y) ++ " " ++ (FractionUnit.toString k)
        
        ColorId id ->
            "COLOR=" ++ (ResourceIdentifier.toString id)
        
        InvalidChroma failure ->
            failure.message

parser : Parser Chroma
parser =
  oneOf
    [succeed RedGreenBlueAlpha
        |. keyword "RGBA"
        |. symbol "="
        |= int
        |.spaces
        |= int
        |.spaces
        |= int
        |.spaces
        |= int
    , succeed HueSLA
        |. keyword "HSLA"
        |. symbol "="
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
    , succeed CMYK
        |. keyword "CMYK"
        |. symbol "="
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
        |.spaces
        |= FractionUnit.parser   
    , succeed ColorId
        |. keyword "COLOR"
        |. symbol "="
        |= ResourceIdentifier.parser   
   ]

fromString : String -> Chroma
fromString str =
    case run parser str of
        Ok id ->
            id

        Err msg ->
           InvalidChroma (Failing.fromDeadEndList msg str)
