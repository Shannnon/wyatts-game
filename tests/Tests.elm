module Tests exposing (..)

import Expect
import Main exposing (..)
import Test exposing (..)



-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!


all : Test
all =
    describe "bubblesHit"
        [ test "returns true when passed same bubble because duh" <|
            \_ ->
                let
                    pooperStein =
                        { top = 5, right = 5, left = 0, bottom = 0 }
                in
                Expect.true "same bubble should have an intersection with  itself" (bubblesHit pooperStein pooperStein)
        , test "returns false when they do not intersect" <|
            \_ ->
                let
                    bubble1 =
                        { top = 5, right = 5, left = 4, bottom = 4 }

                    bubble2 =
                        { top = 3, right = 3, left = 2, bottom = 2 }
                in
                Expect.false "cmon man" (bubblesHit bubble1 bubble2)
        , test "returns true when they have edges that intersect" <|
            \_ ->
                let
                    brown =
                        { top = 5, right = 5, left = 0, bottom = 0 }

                    pink =
                        { top = 3, right = 3, left = 2, bottom = 2 }
                in
                Expect.equal True (bubblesHit brown pink)
        , test "returns true when they have points in them that intersect" <|
            \_ ->
                let
                    brown =
                        { top = 5, right = 5, left = 0, bottom = 0 }

                    pink =
                        { top = 3, right = 3, left = 1, bottom = 1 }
                in
                Expect.true "cmon man" (bubblesHit brown pink)
        ]
