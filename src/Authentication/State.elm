module Authentication.State exposing (init, update)

import Authentication.Types exposing (..)


init : (Options -> Cmd Msg) -> (Options -> Cmd Msg) -> Model
init auth logout =
    { state = LoggedOut
    , lastError = Nothing
    , authorise = auth
    , logout = logout
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AuthenticationResult (Ok user) ->
            ( { model | state = LoggedIn user, lastError = Nothing }, Cmd.none )

        AuthenticationResult (Err error) ->
            ( { model | lastError = Just error }, Cmd.none )

        Login ->
            ( model, model.authorise {} )

        Logout ->
            ( { model | state = LoggedOut }, Cmd.none )
