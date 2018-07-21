module Widgets exposing (questionCard, answerCard)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class)


questionCard : String -> Html msg
questionCard message =
    div [ class "card" ] [ text message ]


answerCard : String -> Html msg
answerCard message =
    div [ class "card card--answer" ] [ text message ]
