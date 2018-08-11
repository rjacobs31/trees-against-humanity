module Types exposing (..)

import Authentication.Types as Auth
import Http


type alias Model =
    { auth : Auth.Model
    , pageState : PageState
    }


type Msg
    = Authentication Auth.Msg
    | TestRequest Auth.Token
    | TestResponse (Result Http.Error String)


type Page
    = Blank
    | HomePage


type PageState
    = TransitioningFrom Page
    | PageLoaded Page
