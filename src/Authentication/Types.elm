module Authentication.Types exposing (..)


type alias Model =
    { state : AuthenticationState
    , lastError : Maybe AuthenticationError
    , authorise : Options -> Cmd Msg
    }


type Msg
    = AuthenticationResult (Result AuthenticationError LoggedInUser)
    | Login
    | Logout


type alias LoggedInUser =
    { token : Token
    }


getToken : Model -> Maybe Token
getToken model =
    case model.state of
        LoggedIn user ->
            Just user.token

        LoggedOut ->
            Nothing


type AuthenticationState
    = LoggedOut
    | LoggedIn LoggedInUser


type alias Options =
    {}


defaultOptions : Options
defaultOptions =
    {}


type alias UserProfile =
    { email : String
    , email_verified : Bool
    }


type alias Token =
    String


type alias AuthenticationError =
    { error : Maybe String
    , errorDescription : Maybe String
    , statusCode : Maybe Int
    }


type alias RawAuthenticationResult =
    { err : Maybe AuthenticationError
    , ok : Maybe LoggedInUser
    }
