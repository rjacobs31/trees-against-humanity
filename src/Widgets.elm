module Widgets exposing (whiteCard)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (class)


whiteCard : String -> Html msg
whiteCard message =
    div [ class "card" ] [ text message ]
