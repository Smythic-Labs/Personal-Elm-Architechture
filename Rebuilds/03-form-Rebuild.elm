import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , validationErrors : List String
  }


init : Model
init =
  Model "" "" "" []



-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
        let
            modelWithPassword = { model | password = password }
            validationErrors = validPassword modelWithPassword
        in
            { modelWithPassword | validationErrors = validationErrors }


    PasswordAgain password ->
        let
            modelWithPasswordAgain = { model | passwordAgain = password }
            validationErrors = validPassword modelWithPasswordAgain
        in
            { modelWithPasswordAgain | validationErrors = validationErrors }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []



viewValidation : Model -> Html msg
viewValidation model =
  let
    errorListItems =
      List.map
        (\errorMessage -> li [Html.Attributes.style "color" "red"] [ text errorMessage ])
        model.validationErrors

  in
    ul [] errorListItems

type alias Validation =
  { condition : Bool
  , errorMessage : String
  }


validPassword : Model -> List String
validPassword {password, passwordAgain} =
    let
        validations =
          [ Validation (String.length password < 8) "password too short"
          , Validation (String.contains "!" password) "! is a forbidden character"
          , Validation (password /= passwordAgain) "Passwords do not match!"
          , Validation ((String.any Char.isUpper password == False) || (String.any Char.isLower password == False ) || (String.any Char.isDigit password == False))
                "Passwords Must contain a Numeric, an Uppercase letter and a Lowercase Letter"
          ]

        validationErrorMessages =
            validations
              |> List.filter .condition
              |> List.map .errorMessage

    in
      validationErrorMessages