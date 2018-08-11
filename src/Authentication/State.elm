module Authentication.State exposing (init, update)

import Authentication.Types exposing (..)


init : (Options -> Cmd Msg) -> Model
init auth =
    { state = LoggedOut
    , lastError = Nothing
    , authorise = auth
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AuthenticationResult (Ok user) ->
            ( { model | state = LoggedIn user, lastError = Nothing }, Cmd.none )

        AuthenticationResult (Err error) ->
            ( { model | lastError = Just error }, Cmd.none )

        Login ->
            ( model, Cmd.none )

        Logout ->
            ( { model | state = LoggedOut }, Cmd.none )
