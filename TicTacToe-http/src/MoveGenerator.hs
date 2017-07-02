module MoveGenerator(addSingleMove) where 

import System.Random (randomRIO)
import GameConfiguration
import BoardLogic
import Types
import Control.Monad
import Data.List

addSingleMove :: Moves -> IO Moves
addSingleMove moves = 
    let
        moveA = msum $ getAtt moves : getDeff moves : []
    in  case length moveA of
            0 -> do
                a <- getRandomMove moves
                return $ a:moves
            _ -> do return $ (head moveA):moves


pick :: [a] -> IO a
pick xs = fmap (xs !!) $ randomRIO (0, length xs - 1)

getRandomMove :: Moves -> IO Move
getRandomMove mo = do
    m <- (pick . myPossibleMoves) mo
    let a = map(\(x,y) -> (x,y,myChar)) [m]
    let a' = head a
    return a'

allPossibleMoves = [(x,y) | x <- [0,1,2], y <- [0,1,2]]

existingMoves' moves = map(\(x,y,c) -> (x,y)) moves

myPossibleMoves m = filter (\a -> a `notElem` (existingMoves' m)) allPossibleMoves

getAtt m = msum $ getRows m myChar : getCols m myChar : getDiags m myChar : [] 

getDeff m =
    let
        a = msum $ getRows m enemyChar : getCols m enemyChar : getDiags m enemyChar : []
    in map(\(x,y,_) -> (x,y,myChar)) a


getRows :: Moves -> Char -> [Move]
getRows moves char = 
    do
        let b = map(\[a] -> a) poss
        let e = filter(\(x,y,v) -> (x,y) `elem` myPossibleMoves moves) b
        if length e == 1
            then e
            else []
   where 
       a = [e | rowN <-[0..2], let e = checkForLast' moves char rowN rowN 0 2]
       poss = filter(\c -> length c == 1) a

getCols :: Moves -> Char -> [Move]
getCols moves char =
    do
        let b = map(\[a] -> a) poss
        let e = filter(\(x,y,v) -> (x,y) `elem` myPossibleMoves moves) b
        if length e == 1
            then e
            else []
   where 
       a = [e | colN <-[0..2], let e = checkForLast' moves char 0 2 colN colN]
       poss = filter(\c -> length c == 1) a


getDiags  moves char = 
    let
       a = getDiag1 moves char
       b = getDiag2 moves char
       c = a ++ b
       d = filter(\(x,y,v) -> (x,y) `elem` myPossibleMoves moves) c
    in d

getDiag1 :: Moves -> Char -> Moves
getDiag1 moves char =
    let
        a = [e | colN <-[0..2], rowN <-[0..2], let e = checkForLast' moves char rowN rowN colN colN, (colN == 2 && rowN == 0 || colN == 0 && rowN == 2 || colN == 1 && rowN == 1)]
        c = mfilter(\c -> length c == 1) a
        b = map(\[a] -> a) c
    in case length b of
        1 -> b
        _ -> []

getDiag2 :: Moves -> Char -> Moves
getDiag2 moves char =
    let
        a = [e | colN <-[0..2], rowN <-[0..2], let e = checkForLast' moves char rowN rowN colN colN, rowN == colN]
        c = mfilter(\c -> length c == 1) a
        b = map(\[a] -> a) c
    in case length b of
        1 -> b
        _ -> []

checkForLast' :: Moves -> Char -> Int -> Int -> Int -> Int -> Moves
checkForLast' moves char row_s row_n col_s col_n = 
    let
        hor = [(x,y, char) | x <- [row_s..row_n], y <- [col_s..col_n]]
        poss = filter(\a -> a `notElem` moves) hor
    in case length poss of
        1 -> poss
        _ -> []