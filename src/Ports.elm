port module Ports exposing (..)

import Json.Encode as Encode


type ElmDataOut
    = MenuClick


pushDataToJS : ElmDataOut -> Cmd msg
pushDataToJS data =
    case data of
        MenuClick ->
            elmData { tag = "MenuClick", data = Encode.null }


type alias PortData =
    { tag : String
    , data : Encode.Value
    }


port elmData : PortData -> Cmd msg


port jsData : (PortData -> msg) -> Sub msg
