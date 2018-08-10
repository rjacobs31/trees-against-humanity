module View exposing (view)

import Html exposing (Html, div, h1, h2, program, text)
import Html.Attributes exposing (class)
import Types exposing (..)
import Widgets exposing (answerCard, blankCard, questionCard)


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [ class "main-title" ] [ text "Trees Against Humanity" ]
        , div [ class "play-area" ]
            [ h2 [ class "play-area__heading" ] [ text "Question" ]
            , div [ class "play-area__card-container" ]
                [ questionCard "This is some card, huh?"
                ]
            ]
        , div [ class "play-area" ]
            [ h2 [ class "play-area__heading" ] [ text "Responses" ]
            , div [ class "play-area__card-container" ]
                [ answerCard "And this is an awesome answer card."
                , answerCard "And another awesome answer card."
                , answerCard "And yet another awesome answer card."
                , blankCard Nothing
                , blankCard <| Just "This is a witty answer submitted by the user."
                ]
            ]
        , div [ class "play-area" ]
            [ h2 [ class "play-area__heading" ] [ text "Your hand" ]
            , div [ class "play-area__card-container play-area__card-container--hand-container" ]
                [ answerCard "And this."
                , answerCard "Is my."
                , answerCard "Handsome hand."
                , answerCard "Of cards."
                ]
            ]
        ]
