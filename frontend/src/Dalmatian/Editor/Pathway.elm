module Dalmatian.Editor.Pathway exposing (SnatchPath, Pathway)

type Pathway = SpeechPath | CompositionPath | TilingPath | PropsPath | PanelPath

type SnatchPath =
    RootPath Pathway Int
    | Path2 Pathway Int Pathway Int
    | Path3 Pathway Int Pathway Int Pathway Int Pathway Int

