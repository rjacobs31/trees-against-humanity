module Authentication.Util exposing (mapResult)

import Authentication.Types exposing (..)


mapResult : RawAuthenticationResult -> Result AuthenticationError LoggedInUser
mapResult result =
    case ( result.err, result.ok ) of
        ( Just msg, _ ) ->
            Err msg

        ( Nothing, Nothing ) ->
            Err { name = Nothing, code = Nothing, statusCode = Nothing, description = "No information was received from the authentication provider" }

        ( Nothing, Just user ) ->
            Ok user
