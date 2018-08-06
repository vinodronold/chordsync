module Main exposing (..)

import Html as H exposing (Html)
import Html.Attributes exposing (class)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    H.div [ class "mdc-typography" ]
        [ header
        , H.text "ChordSync"
        ]


header : Html msg
header =
    H.div []
        [ H.header [ class "mdc-top-app-bar  mdc-top-app-bar--fixed" ]
            [ H.div [ class "mdc-top-app-bar__row" ]
                [ H.section [ class "mdc-top-app-bar__section mdc-top-app-bar__section--align-start" ]
                    [ H.span [ class "mdc-top-app-bar__title" ] [ H.text "Chord Sync" ]
                    ]
                , H.section [ class "mdc-top-app-bar__section mdc-top-app-bar__section--align-end" ]
                    [ H.button [ class "mdc-button mdc-button--raised" ] [ H.text "Menu" ]
                    ]
                ]
            ]
        , H.div [ class "mdc-top-app-bar--fixed-adjust" ] []
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    H.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
