module Types exposing (..)

import Authentication.Types as Auth


type alias Model =
    { auth : Auth.Model }


type Msg
    = Authentication Auth.Msg
