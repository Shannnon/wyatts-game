module Main exposing (Bubble, bubblesHit, main)

import Playground exposing (..)


main =
    game view update initModel



--Model--


initModel : Model
initModel =
    { wyatt = ( -300, 0 )
    , block = ( 50, 10, 20 )
    }


type alias Model =
    { wyatt : ( Number, Number )
    , block : ( Length, Number, Number )
    }


type alias Length =
    Number



--Update--


update : Computer -> Model -> Model
update computer model =
    let
        ( x, y ) =
            model.wyatt

        updatedWyatt =
            ( x + toX computer.keyboard
            , y + toY computer.keyboard
            )

        wyattBubble =
            bubbleizeWyatt updatedWyatt

        blockBubble =
            bubbleizeBlock model.block

        resetWyattOrContinue =
            updateTheyHit wyattBubble blockBubble updatedWyatt
    in
    { model
        | wyatt = resetWyattOrContinue
    }


updateTheyHit : Bubble -> Bubble -> ( Number, Number ) -> ( Number, Number )
updateTheyHit wyattBubble blockBubble newWyatt =
    if bubblesHit wyattBubble blockBubble then
        initModel.wyatt

    else
        newWyatt


bubblesHit : Bubble -> Bubble -> Bool
bubblesHit bubbleOne bubbleTwo =
    True


type alias Bubble =
    { top : Number, right : Number, left : Number, bottom : Number }


bubbleizeWyatt : ( Number, Number ) -> Bubble
bubbleizeWyatt ( x, y ) =
    { top = y + 20, right = x + 10, left = x - 10, bottom = y - 20 }


bubbleizeBlock : ( Number, Number, Number ) -> Bubble
bubbleizeBlock ( length, x, y ) =
    { top = y + 40, right = x + 15, left = x - 15, bottom = y - 40 }



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
        [ square orange length |> move x y ]



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
