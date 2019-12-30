module Dalmatian.Editor.Pathway exposing (SnatchPath(..), PrimaryPathway(..))

type PrimaryPathway = SpeechPath | NarrativePath | PagePath | TilePath

type SnatchPath =
    PrimaryPath PrimaryPathway Int
    | PrimaryPathProps PrimaryPathway Int
