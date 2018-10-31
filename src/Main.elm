module Main exposing (main)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Html exposing (Html, div, text)
import Url exposing (Url)


type alias Model =
    {}


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest


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
init flags url key =
    ( {}, Cmd.none )


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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
