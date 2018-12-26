module Dalmatian.Album.Contributor exposing (Contribution)

-- Creator | Contributor | Publisher | Sponsor | Translator | Artist | Author | Colorist | Inker | Letterer | Penciler | Editor | Sponsor
 
type Contribution =
    ContributionHeader String String-- ex: main, minor
    | ContributionLanguage String -- ex: en-gb
    | ContributionFooter String String -- ex: type, description
    | Contributor Thing String String -- type, comment
    




