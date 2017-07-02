{-# LANGUAGE OverloadedStrings #-}

module Main(main, isGameOver) where

import Data.List
import Data.Maybe
import Control.Monad
import Types
import Parsing
import GameConfiguration as Cfg
import BoardLogic
import MoveGenerator
import Protocol

message :: String
message = "ll1:xi0e1:yi2e1:v1:xee"

firstMove :: Move
firstMove = (1,1, myChar)

main :: IO ()
main = do
    if (attack == True)
        then makeFirstMove
        else playGame True
    print "done"

playGame :: Bool -> IO ()
playGame True = do
    boardState <- getMoves
    if isGameOver boardState
        then playGame False          
        else do
            newMoves <- addSingleMove boardState
            postMoves newMoves
            if isGameOver newMoves
                then playGame False    
                else playGame True
playGame False = return ()


makeFirstMove = do
    postMoves [firstMove]
    playGame True

isGameOver :: Moves -> Bool
isGameOver boardState = iWon || iLost || boardFull
    where 
        iWon = checkBoard boardState myChar
        iLost = checkBoard boardState enemyChar
        boardFull = isBoardFull boardState














