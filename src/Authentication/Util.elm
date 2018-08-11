module Authentication.Util exposing (mapResult)

import Authentication.Types exposing (..)


mapResult : RawAuthenticationResult -> Result AuthenticationError LoggedInUser
mapResult result =
    case ( result.err, result.ok ) of
        ( Just msg, _ ) ->
            Err msg

        ( Nothing, Nothing ) ->
            Err
                { error = Nothing
                , errorDescription = Just "No information was received from the authentication provider"
                , statusCode = Nothing
                }

        ( Nothing, Just user ) ->
            Ok user
