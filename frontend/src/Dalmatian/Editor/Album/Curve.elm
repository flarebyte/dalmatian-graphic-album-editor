module Dalmatian.Album.Curve exposing (Draw, ArcFlag)

import Dalmatian.Album.Thing as Thing

type ArcFlag = LargeArcA | SmallArcA | LargeArcB | SmallArcB

type Draw =
    Point Int Int Int -- x, y, sid
    | MoveTo Int Int -- x, y
    | LineTo Int Int -- x, y
    | Horizontal Int -- x
    | Vertical Int -- y
    | CubicCurve Int Int Int Int Int Int
    | SmoothCubicCurve Int Int Int Int
    | QuadraticCurve Int Int Int Int
    | SmoothQuadraticCurve Int Int
    | EllipticalArc Int Int Float ArcFlag Int Int

 



    




