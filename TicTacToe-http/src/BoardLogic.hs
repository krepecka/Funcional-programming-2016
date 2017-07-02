module BoardLogic(validate, checkBoard, isBoardFull) where 

import Types
import Parsing

validate :: String -> Bool
validate str = 
    let
        moves = strToMoves str
        a = isMoveCountOk moves
        b = (isCoordUniq . map(\(x,y,c) -> [x,y])) moves 
    in
        a && b

isMoveCountOk :: Moves -> Bool
isMoveCountOk moves =
    let
        xCount = countPlayerMoves moves 'x'
        yCount = countPlayerMoves moves 'o'
    in 
        abs(xCount - yCount) < 2

countPlayerMoves :: Moves -> Char -> Int
countPlayerMoves [] _ = 0
countPlayerMoves moves char = length (filter (\(x, y, c) -> c == char) moves)

-- REGULAR RECURSION
-- Another possible solution would be to define Move as data type and then override Eq
-- Eq a is context. Says that a elements can be compared 
-- (Eq [Int]) => 
isCoordUniq :: [[Int]] -> Bool
isCoordUniq [] = True
isCoordUniq (h:rest) = (h `notElem` rest) && isCoordUniq rest

isBoardFull :: Moves -> Bool
isBoardFull moves = length moves > 8 

---
--- Checking for winner by Ignas J.
---
boardSize = 3

checkBoard :: Moves -> Char -> Bool
checkBoard board char = row || column || diagonal || reverseDiagonal
  where 
    row = checkRow 0 board char || checkRow 1 board char || checkRow 2 board char
    column = checkCol 0 board char || checkCol 1 board char || checkCol 2 board char
    diagonal = checkDiag board char
    reverseDiagonal = checkRevDiag board char

checkRow :: Int -> Moves -> Char -> Bool
checkRow rowNum board char = length (filter(\(row, _, symbol) -> row == rowNum && symbol == char) board) == boardSize

checkCol :: Int -> Moves -> Char -> Bool
checkCol colNum board char = length (filter(\(_, column, symbol) -> column == colNum && symbol == char) board) == boardSize

checkDiag :: Moves -> Char -> Bool
checkDiag board char = length (filter(\(row, column, symbol) -> row == 0 && column == 0 && symbol == char) board) +
    length (filter(\(row, column, symbol) -> row == 1 && column == 1 && symbol == char) board) +
    length (filter(\(row, column, symbol) -> row == 2 && column == 2 && symbol == char) board) == boardSize

checkRevDiag:: Moves -> Char -> Bool
checkRevDiag board char = length (filter(\(row, column, symbol) -> row == 0 && column == 2 && symbol == char) board) + 
    length (filter(\(row, column, symbol) -> row == 1 && column == 1 && symbol == char) board) +
    length (filter(\(row, column, symbol) -> row == 2 && column == 0 && symbol == char) board) == boardSize