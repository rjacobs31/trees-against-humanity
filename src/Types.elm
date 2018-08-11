module Types exposing (..)

import Authentication.Types as Auth


type alias Model =
    { auth : Auth.Model
    , pageState : PageState
    }


type Msg
    = Authentication Auth.Msg


type Page
    = Blank
    | HomePage


type PageState
    = TransitioningFrom Page
    | PageLoaded Page
