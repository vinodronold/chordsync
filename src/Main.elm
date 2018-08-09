module Main exposing (..)

import Html as H exposing (Html)
import Html.Attributes as A exposing (class)
import Html.Events as E
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>))
import Dict exposing (Dict)
import Ports


type Page
    = Blank
    | NotFound
    | Songs
    | Player


type PageState
    = Loading
    | Loaded Page



---- MODEL ----


type YouTubeID
    = YouTubeID String


youTubeIDParser : Url.Parser (YouTubeID -> a) a
youTubeIDParser =
    Url.custom "SONG" (Ok << YouTubeID)


youTubeIDtoString : YouTubeID -> String
youTubeIDtoString (YouTubeID s) =
    s


type URL
    = URL String


type alias Song =
    { youtube_id : YouTubeID
    , title : String
    , imgUrlDefault : URL
    }


type alias Model =
    { pageState : PageState, songs : Maybe (Dict YouTubeID Song) }


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute (fromLocation location) { pageState = Loaded Blank, songs = Nothing }



---- UPDATE ----


type Msg
    = SetRoute (Maybe Route)
    | MenuClick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetRoute route ->
            setRoute route model

        MenuClick ->
            model ! [ Ports.pushDataToJS Ports.MenuClick ]



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.pageState of
        Loading ->
            masterView loading

        Loaded Blank ->
            masterView blank

        Loaded NotFound ->
            masterView notFound

        Loaded Songs ->
            masterView songs

        Loaded Player ->
            masterView player


loading : Html msg
loading =
    H.div [] [ H.text "Loading" ]


blank : Html msg
blank =
    H.div [] [ H.text "Blank" ]


notFound : Html msg
notFound =
    H.div [] [ H.text "Not Found" ]


songs : Html msg
songs =
    H.div [] [ H.text "Songs" ]


player : Html msg
player =
    H.div [] [ H.text "Player" ]



-- masterView songList


masterView : Html Msg -> Html Msg
masterView content =
    H.div [ class "mdc-typography" ]
        [ header
        , content
        ]


header : Html Msg
header =
    H.div []
        [ H.header [ class "mdc-top-app-bar  mdc-top-app-bar--fixed" ]
            [ H.div [ class "mdc-top-app-bar__row" ]
                [ H.section [ class "mdc-top-app-bar__section mdc-top-app-bar__section--align-start" ]
                    [ H.span [ class "mdc-top-app-bar__title" ] [ H.text "Chord Sync" ]
                    ]
                , H.section [ class "mdc-top-app-bar__section mdc-top-app-bar__section--align-end" ]
                    [ H.div [ class "mdc-menu-anchor" ]
                        [ H.div [ class "mdc-menu", A.id "MenuOption" ]
                            [ H.ul [ class "mdc-menu__items mdc-list", A.attribute "role" "menu" ]
                                [ H.li [ class "mdc-list-item", A.attribute "role" "menuitem" ] [ H.text "Profile" ]
                                , H.li [ class "mdc-list-item", A.attribute "role" "menuitem" ] [ H.text "Sign Out" ]
                                ]
                            ]
                        , H.button
                            [ class "mdc-button mdc-button--raised"
                            , E.onClick MenuClick
                            ]
                            [ H.text "Menu" ]
                        ]
                    ]
                ]
            ]
        , H.div [ class "mdc-top-app-bar--fixed-adjust" ] []
        ]


songList : Html msg
songList =
    H.div [ class "mdc-elevation--z4 song-list" ]
        [ H.div
            [ class "mdc-list mdc-list--two-line mdc-list--avatar-list" --aria-orientation="vertical"
            ]
            [ H.div [ class "mdc-list-item" ]
                [ H.span
                    [ class "mdc-list-item__graphic song-youtube-image"
                    , A.style [ ( "height", "90px" ), ( "width", "120px" ) ]
                    ]
                    [ H.img [ A.src "https://i.ytimg.com/vi/PiL5UTTTrxk/default.jpg" ] [] ]
                , H.span [ class "mdc-list-item__text" ]
                    [ H.span [ class "mdc-list-item__primary-text" ]
                        [ H.text "Thalli Pogathey" ]
                    , H.span
                        [ class "mdc-list-item__secondary-text mdc-typography--caption"
                        , A.style [ ( "margin", "0.3rem 0" ) ]
                        ]
                        [ H.text "Am - F - C - D" ]
                    ]
                ]
            ]
        , H.hr
            [ class "mdc-list-divider" ]
            []
        , H.div
            [ class "mdc-list mdc-list--two-line mdc-list--avatar-list" --aria-orientation="vertical"
            ]
            [ H.div [ class "mdc-list-item" ]
                [ H.span
                    [ class "mdc-list-item__graphic song-youtube-image"
                    , A.style [ ( "height", "90px" ), ( "width", "120px" ) ]
                    ]
                    [ H.img [ A.src "https://i.ytimg.com/vi/PiL5UTTTrxk/default.jpg" ] [] ]
                , H.span [ class "mdc-list-item__text" ]
                    [ H.span [ class "mdc-list-item__primary-text" ]
                        [ H.text "Thalli Pogathey" ]
                    , H.span
                        [ class "mdc-list-item__secondary-text mdc-typography--caption"
                        , A.style [ ( "margin", "0.3rem 0" ) ]
                        ]
                        [ H.text "Am - F - C - D" ]
                    ]
                ]
            ]
        , H.hr
            [ class "mdc-list-divider" ]
            []
        , H.div
            [ class "mdc-list mdc-list--two-line mdc-list--avatar-list" --aria-orientation="vertical"
            ]
            [ H.div [ class "mdc-list-item" ]
                [ H.span
                    [ class "mdc-list-item__graphic song-youtube-image"
                    , A.style [ ( "height", "90px" ), ( "width", "120px" ) ]
                    ]
                    [ H.img [ A.src "https://i.ytimg.com/vi/PiL5UTTTrxk/default.jpg" ] [] ]
                , H.span [ class "mdc-list-item__text" ]
                    [ H.span [ class "mdc-list-item__primary-text" ]
                        [ H.text "Thalli Pogathey" ]
                    , H.span
                        [ class "mdc-list-item__secondary-text mdc-typography--caption"
                        , A.style [ ( "margin", "0.3rem 0" ) ]
                        ]
                        [ H.text "Am - F - C - D" ]
                    ]
                ]
            ]
        ]



---- ROUTES ----


type Route
    = Root
    | Home
    | Play YouTubeID


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    case maybeRoute of
        Nothing ->
            { model | pageState = Loaded NotFound } ! []

        Just Root ->
            model ! [ modifyUrl Home ]

        Just Home ->
            { model | pageState = Loaded Songs } ! []

        Just (Play youtubeID) ->
            { model | pageState = Loaded Player } ! []


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Home (Url.s "")
        , Url.map Play (Url.s "play" </> youTubeIDParser)
        ]


href : Route -> String
href page =
    let
        pieces =
            case page of
                Home ->
                    []

                Root ->
                    []

                Play youTubeID ->
                    [ "play", youTubeIDtoString youTubeID ]
    in
        "#/" ++ String.join "/" pieces


modifyUrl : Route -> Cmd msg
modifyUrl =
    href >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Root
    else
        Url.parseHash route location



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program (fromLocation >> SetRoute)
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
