module Main exposing (main)

import Playground exposing (..)


main =
    game view update { wyatt = ( -300, 0 ), block = ( 5, 0, 0 ) }



--Model--


type alias Model =
    { wyatt : ( Number, Number )
    , block : ( Number, Number, Number )
    }



-- need to pattern match block in update. DONE!
-- wyatt is simply an x,y... block is the length of a side and then x,y
--Update--


update : Computer -> Model -> Model
update computer model =
    let
        ( x, y ) =
            model.wyatt
    in
    { model
        | wyatt =
            ( x + toX computer.keyboard
            , y + toY computer.keyboard
            )
        , block = ( 50, 0, -100 )
    }



-- View --


view : Computer -> Model -> List Shape
view computer model =
    let
        ( x, y ) =
            model.wyatt
    in
    [ myWyatt -100
        |> move x y
        |> scale 0.5
    , theBlock model.block
    , theBlocks
    , theGround computer |> moveDown 385
    ]


theBlock ( length, x, y ) =
    group
        [ square orange length ]



-- added computer.width


theGround computer =
    group
        [ rectangle lightGreen computer.screen.width 500
        ]


theBlocks =
    group
        [ square darkPurple 30 |> moveUp 265 |> moveLeft 180
        , square darkPurple 30 |> moveUp 265 |> moveRight 80
        , square darkPurple 30 |> moveUp 265 |> moveRight 280
        , square darkPurple 30 |> moveUp 450 |> moveLeft 180
        , square darkPurple 30 |> moveUp 450 |> moveRight 80
        ]


myWyatt computer =
    group
        [ square (rgb 212 162 106) 40 |> moveDown 40
        , oval (rgb 212 162 106) 20 40
            |> moveLeft 40
            |> moveUp 10
        , oval (rgb 212 162 106) 20 40
            |> moveRight 40
            |> moveUp 10
        , square (rgb 212 162 106) 80
        , wyEyes |> moveUp 10
        , triangle yellow 30
            |> moveUp 50
        , triangle yellow 30
            |> moveUp 50
            |> moveRight 20
        , triangle yellow 30
            |> moveUp 50
            |> moveLeft 20
        , polygon black [ ( -25, -20 ), ( 0, 2 ), ( 25, -20 ) ]
            |> rotate 180
            |> moveDown 30
        , rectangle white 40 3 |> moveDown 13
        , wyBody |> moveDown 95
        ]


wyEyes =
    group
        [ circle white 15 |> moveLeft 17
        , circle white 15 |> moveRight 17
        , circle blue 10 |> moveLeft 17
        , circle blue 10 |> moveRight 17
        , circle black 4 |> moveLeft 17
        , circle black 4 |> moveRight 17
        ]


wyBody =
    group
        [ rectangle blue 100 120 |> moveDown 10
        , rectangle black 100 100 |> moveDown 120
        , circle (rgb 212 162 106) 12 |> moveLeft 60 |> moveDown 115
        , circle (rgb 212 162 106) 12 |> moveRight 60 |> moveDown 115
        , rectangle blue 30 160 |> moveLeft 60 |> moveDown 30
        , rectangle blue 30 160 |> moveRight 60 |> moveDown 30
        , circle white 25 |> moveDown 180 |> moveLeft 25
        , circle white 25 |> moveDown 180 |> moveRight 25
        , rectangle black 100 5 |> moveDown 170
        , rectangle darkBlue 5 85 |> moveLeft 42 |> moveDown 28
        , rectangle darkBlue 5 85 |> moveRight 42 |> moveDown 28
        ]
