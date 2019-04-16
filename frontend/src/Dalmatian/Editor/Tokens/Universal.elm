module Dalmatian.Editor.Tokens.Universal exposing (..)

import Dalmatian.Editor.Tokens.Pathway exposing (TokenPath)
import Dalmatian.Editor.Dialect.ResourceIdentifier exposing (ResourceId)
import Dalmatian.Editor.Dialect.Position2DUnit exposing (Position2D)
import Dalmatian.Editor.Dialect.Dimension2DUnit exposing (Dimension2D)
import Dalmatian.Editor.Dialect.FractionUnit exposing (Fraction)

type OperationFlag =
    NoFlag
    | IntFlag


type RecursiveData =
    RecursiveAbout TokenPath
    | RecursiveUnaryOp ResourceId OperationFlag RecursiveData
    | RecursiveBinaryOp ResourceId OperationFlag RecursiveData RecursiveData


type TokenData = 
    RangeData ResourceId ResourceId SelectionRange -- font fontId range
    | ResourceIdData ResourceId ResourceId -- predicate entity-id
    | ResourceIdListData ResourceId (List ResourceId) -- predicate entity-id
    | RelationshipData ResourceId ResourceId ResourceId --
    | RelationshipsData ResourceId ResourceId (List ResourceId) --
    | FractionData ResourceId Fraction
    | Position2DData ResourceId Position2D
    | Dimension2DData ResourceId Dimension2D
    | IntData ResourceId Int

type alias UniversalToken = {
    path: TokenPath
    , value: TokenData
}