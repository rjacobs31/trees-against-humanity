port module State exposing (init, subscriptions, update)

import Authentication.State as AuthState
import Authentication.Types as Auth
import Authentication.Util as AuthUtil
import Http
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    let
        model =
            { auth = AuthState.init auth0authorise auth0logout
            , pageState = TransitioningFrom Blank
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

        TestRequest token ->
            let
                request =
                    Http.request
                        { method = "GET"
                        , headers =
                            [ Http.header "Authorization" ("Bearer " ++ token)
                            , Http.header "Access-Control-Allow-Headers" "Authorization"
                            ]
                        , url = "http://localhost:8000/api/test"
                        , body = Http.emptyBody
                        , expect = Http.expectString
                        , timeout = Nothing
                        , withCredentials = False
                        }
            in
                ( model, Http.send TestResponse request )

        TestResponse result ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    auth0authResult (AuthUtil.mapResult >> Auth.AuthenticationResult >> Authentication)



-- PORTS


port auth0authorise : Auth.Options -> Cmd msg


port auth0authResult : (Auth.RawAuthenticationResult -> msg) -> Sub msg


port auth0logout : Auth.Options -> Cmd msg
