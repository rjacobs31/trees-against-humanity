module View exposing (view)

import Authentication.Types as Auth
import Html exposing (Html, button, div, h1, h2, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Types exposing (..)
import Widgets exposing (answerCard, blankCard, questionCard)


view : Model -> Html Msg
view model =
    case model.auth.state of
        Auth.LoggedIn user ->
            viewLoggedIn user model

        Auth.LoggedOut ->
            viewLoggedOut model


viewLoggedIn : Auth.LoggedInUser -> Model -> Html Msg
viewLoggedIn user model =
    div [ class "content" ]
        [ h1 [ class "main-title" ] [ text "Trees Against Humanity" ]
        , text "Yay! You're logged in!"
        , button [ onClick (Authentication Auth.Logout) ] [ text "Logout" ]
        , button [ onClick (TestRequest user.token) ] [ text "Test" ]
        , viewCards
        ]


viewLoggedOut : Model -> Html Msg
viewLoggedOut model =
    div [ class "content" ]
        [ h1 [ class "main-title" ] [ text "Trees Against Humanity" ]
        , text "Please login below to proceed."
        , button [ onClick (Authentication Auth.Login) ] [ text "Login" ]
        ]


viewCards : Html Msg
viewCards =
    div [ class "content" ]
        [ div [ class "play-area" ]
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
