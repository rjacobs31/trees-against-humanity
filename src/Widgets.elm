module Widgets exposing (answerCard, blankCard, questionCard)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class)
import Maybe exposing (withDefault)


questionCard : String -> Html msg
questionCard message =
    div [ class "card" ] [ text message ]


answerCard : String -> Html msg
answerCard message =
    div [ class "card card--answer" ] [ text message ]


blankCard : Maybe String -> Html msg
blankCard message =
    div [ class "card card--answer" ] [ text <| withDefault "_____" message ]
