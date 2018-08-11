module Main exposing (..)

import Html exposing (program)
import State exposing (init, subscriptions, update)
import Types exposing (..)
import View exposing (view)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
