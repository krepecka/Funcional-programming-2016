doubleMe :: Int -> Int
doubleMe x = x + x

doubleUs :: Int -> Int -> Int
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber :: Int -> Int
doubleSmallNumber x = if x >= 100
                        then x 
                        else x * 2

{-
message to validate
board:
+-+-+-+
| | |X|
+-+-+-+
| | | |
+-+-+-+
| | | |
+-+-+-+
-}

message :: String
message = "ll1:xi0e1:yi2e1:v1:xee"

type Move = (Int, Int, Char)
type Moves = [Move]

type Row = (Char, Char, Char)
type Board = (Row, Row, Row)

boomBang :: [Int] -> [String]
boomBang xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

beginParse :: String -> Moves
beginParse ('l':rest) = parseMoves

parseTuples acc "]" = acc
parseTuples acc rest =
  let
    (tuple, restt) = parseTuple rest
    sepRest = readSeparator restt
  in
    parseTuples (tuple:acc) sepRest

readDigit :: String -> (Int, String)
readDigit ('0':rest) = (0, rest)
readDigit ('1':rest) = (1, rest) 
readDigit ('2':rest) = (2, rest) 
readDigit _ = error "Digit expected" 



--board :: Board
--board = []


