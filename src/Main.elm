port module Main exposing (..)

import Authentication.Types as Auth
import Authentication.Util as AuthUtil
import Authentication.State as AuthState
import Html exposing (program)
import Types exposing (..)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( { auth = AuthState.init auth0authorise }, auth0authorise {} )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- PORTS


port auth0authorise : Auth.Options -> Cmd msg


port auth0authResult : (Auth.RawAuthenticationResult -> msg) -> Sub msg



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Authentication authMsg ->
            let
                ( innerModel, innerMsg ) =
                    AuthState.update authMsg model.auth
            in
                ( { model | auth = innerModel }, Cmd.map Authentication innerMsg )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    auth0authResult (AuthUtil.mapResult >> Auth.AuthenticationResult >> Authentication)
