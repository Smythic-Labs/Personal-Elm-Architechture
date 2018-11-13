import Browser
import Html exposing (Html, Attribute, button, div, text, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Model =
    {value : Int, content : String}


init : Model
init =
  {value = 0, content = ""}


-- UPDATE

type Msg = Increment | Decrement | Reset | Increment10 | Decrement10 | Change String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            {model | value = model.value + 1}

        Increment10 ->
            {model | value = model.value + 10}

        Decrement ->
            {model | value = model.value - 1}

        Decrement10 ->
            {model | value = model.value - 10}

        Reset ->
            {model | value = 0}

        Change newContent ->
              { model | content = newContent }


  --VIEW

view: Model -> Html Msg
view model = 
    div []
        [button[ onClick Decrement][text "-"]
        , button[ onClick Decrement10][text "-10"]
        , div [] [text (String.fromInt model.value)]
        , button [ onClick Increment ] [text "+"]
        , button[ onClick Increment10][text "+10"]
        , div[] []
        , button [ onClick Reset] [text "Reset"]
        , div []
            [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
            , div [] [ text (String.reverse model.content) ]
            ]
        ]