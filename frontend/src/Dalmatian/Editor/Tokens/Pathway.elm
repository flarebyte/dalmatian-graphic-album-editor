module Dalmatian.Editor.Tokens.Path exposing (..)

type Pathway = SpeechPath | CompositionPath | TilingPath | PropsPath | PanelPath

type TokenPath =
    RootPath Pathway Int
    | Path2 Pathway Int Pathway Int
    | Path3 Pathway Int Pathway Int Pathway Int Pathway Int

