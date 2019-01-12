module Dalmatian.Editor.Curve exposing (ArcFlag, Draw)

import Dalmatian.Editor.Unit exposing (Dimension2DInt, Position2DInt)


type ArcFlag
    = LargeArcA
    | SmallArcA
    | LargeArcB
    | SmallArcB


type Draw
    = Point Position2DInt Int -- x, y, sid
    | MoveTo Position2DInt -- x, y
    | LineTo Position2DInt -- x, y
    | Horizontal Int -- x
    | Vertical Int -- y
    | CubicCurve Position2DInt Position2DInt Position2DInt
    | SmoothCubicCurve Position2DInt Position2DInt
    | QuadraticCurve Position2DInt Position2DInt
    | SmoothQuadraticCurve Position2DInt
    | EllipticalArc Position2DInt Float ArcFlag Position2DInt
