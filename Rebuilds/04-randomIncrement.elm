import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random



-- MAIN


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }



-- MODEL


type alias Model =
  { dieFace : Int
  , value : Int
  , content : String
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1 1 ""
  , Cmd.none
  )



-- UPDATE


type Msg
  = Roll
  | NewFace Int
  | Increment
  | Decrement
  | Increment10
  | Decrement10
  | Reset
  | Change String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( model
      , Random.generate NewFace (Random.int 1 6)
      )

    NewFace newFace ->
      ( Model newFace model.value model.content
      , Cmd.none
      )
    Increment ->
        ({model | value = model.value + 1}
        , Cmd.none
        )

    Increment10 ->
        ({model | value = model.value + 10}
        , Cmd.none
        )

    Decrement ->
        ({model | value = model.value - 1}
        , Cmd.none
        )

    Decrement10 ->
        ({model | value = model.value - 10}
        , Cmd.none
        )


    Reset ->
        (Model 1 1 ""
        , Cmd.none
        )

    Change newContent ->
          ({ model | content = newContent }
          , Cmd.none
          )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (String.fromInt model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    , div [] []
    , button[ onClick Decrement][text "-"]
    , button[ onClick Decrement10][text "-10"]
    , div [] [text (String.fromInt model.value)]
    , button [ onClick Increment] [text "+"]
    , button[ onClick Increment10][text "+10"]
    , div[] []
    , button [ onClick Reset] [text "Reset"]
    , div []
      [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
      , div [] [ text (String.reverse model.content) ]
      ]
    ]