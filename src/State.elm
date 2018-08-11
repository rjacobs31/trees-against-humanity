port module State exposing (init, subscriptions, update)

import Authentication.State as AuthState
import Authentication.Types as Auth
import Authentication.Util as AuthUtil
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    let
        model =
            { auth = AuthState.init auth0authorise
            }
    in
        ( model, Cmd.none )



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



-- PORTS


port auth0authorise : Auth.Options -> Cmd msg


port auth0authResult : (Auth.RawAuthenticationResult -> msg) -> Sub msg
