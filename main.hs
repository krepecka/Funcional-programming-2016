import Data.List

type Move = (Int, Int, Char)
type Moves = [Move]

-- type Row = (Char, Char, Char)
-- type Board = (Row, Row, Row)

message :: String
message = "ll1:xi0e1:yi2e1:v1:xee"
-- x -- 1:x i0e
-- y -- 1:y i2e
-- v -- 1:v 1:x

validate :: String -> Bool
validate str = 
    let
        moves = beginParse str
        a = isMoveCountOk moves
        b = isCoordUniq (map(\(x,y,c) -> [x,y]) moves) 
    in
        a && b

beginParse :: String -> Moves
beginParse ('l':rest) =  reverse (parseMoves [] rest)
beginParse _ = error "beginParse error : wrong list format"

parseMoves :: [Move] -> String -> Moves
parseMoves val ['e'] = val
parseMoves val rest =
    let 
        (move, rest1) = parseMove rest
    in
        parseMoves (move:val) rest1

parseMove :: String -> ((Int, Int, Char), String)
parseMove ('l':rest) =
    let
        (x, restx)  = readDigit rest
        (y, resty)  = readDigit restx
        (p, restxy) = readPlayer resty
    in
      case restxy of
          ('e':remain) -> ((x, y, p), remain)
          _            -> error "parseMove error : unclosed move"  
 
readDigit :: String -> (Int, String)
readDigit ('1' : ':' : _ : 'i' : '0' : 'e' : rest)  = (0, rest)
readDigit ('1' : ':' : _ : 'i' : '1' : 'e' : rest)  = (1, rest) 
readDigit ('1' : ':' : _ : 'i' : '2' : 'e' : rest)  = (2, rest) 
readDigit _ = error "readDigit error : wrong format"

--TODO X and O in smarter way
readPlayer :: String -> (Char, String)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'x' : rest)  = ('x', rest)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'X' : rest)  = ('x', rest)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'o' : rest)  = ('o', rest)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'O' : rest)  = ('o', rest)
readPlayer _ = error "readPlayer error : wrong format"

{-
Validating a board :
    1. Count moves for each player
    2. Count writes to each cell
-}

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

-- Eq a is context .. ? 
isCoordUniq :: (Eq a) => [a] -> Bool
isCoordUniq [] = True
isCoordUniq (h:rest) = (h `notElem` rest) && isCoordUniq rest

--for fun
foldInts :: Int -> [Int] -> Int
foldInts acc [] = acc
foldInts acc (h:rest) = foldInts (acc + h) rest 


