module Main exposing (..)

import Html exposing (Html, div, h1, program, text)
import Html.Attributes exposing (class)
import Widgets exposing (answerCard, blankCard, questionCard)


-- MODEL


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( Model, Cmd.none )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [ class "main-title" ] [ text "Trees Against Humanity" ]
        , questionCard "This is some card, huh?"
        , answerCard "And this is another awesome card."
        , blankCard Nothing
        , blankCard <| Just "This is a witty answer submitted by the user."
        , div [ class "hand-container" ]
            [ answerCard "And this."
            , answerCard "Is my."
            , answerCard "Handsome hand."
            , answerCard "Of cards."
            ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
