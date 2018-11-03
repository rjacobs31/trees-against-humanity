module Main exposing (main)

--import PortFunnels
--import PortFunnels.Websocket as Websocket

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Debug
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Decode exposing (Value)
import Url exposing (Url)


type alias Model =
    { message : String
    , log : List String
    , url : String
    , useSimulator : Bool
    }


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | Connect
    | Close
    | Send
    | Process Value


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model "" [] "" False, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Blarg"
    , body =
        [ div []
            [ text "Here's an empty web app"
            ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangedUrl _ ->
            ( model, Cmd.none )

        ClickedLink _ ->
            ( model, Cmd.none )

        Connect ->
            ( { model
                | log =
                    (if model.useSimulator then
                        "Connecting to simulator"

                     else
                        "Connecting to " ++ model.url
                    )
                        :: model.log
              }
            , Cmd.none
              --WebSocket.makeOpenWithKey model.key model.url |> send model
            )

        Send ->
            ( { model
                | log =
                    ("Sending \"" ++ model.message ++ "\"") :: model.log
              }
            , Cmd.none
              -- WebSocket.makeSend model.key model.send |> send model
            )

        Close ->
            ( { model
                | log = "Closing" :: model.log
              }
            , Cmd.none
              --WebSocket.makeClose model.key |> send model
            )

        Process value ->
            {--|case
                PortFunnels.processValue funnelDict value model.state model
            of
                Err error ->
                    { model | error = Just error } |> withNoCmd

                Ok res ->
                    res
            |--}
            ( model, Cmd.none )



{--|
send : Model -> WebSocket.Message -> Cmd Msg
send model message =
    WebSocket.send (getCmdPort WebSocket.moduleName model) message
|--}


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
