module Parsing(strToMoves, movesToStr) where

import Types

strToMoves :: String -> Moves
strToMoves ('l':rest) =  reverse (parseMoves [] rest)
strToMoves _ = error "strToMoves error : wrong list format"

parseMoves :: [Move] -> String -> Moves
parseMoves val ['e'] = val
parseMoves val rest =
    let 
        (move, rest1) = parseMove rest
    in
        parseMoves (move:val) rest1

parseMove :: String -> (Move, String)
parseMove ('l':rest) =
    let
        (x, restx) = readDigit rest
        (y, resty) = readDigit restx
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

readPlayer :: String -> (Char, String)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'x' : rest)  = ('x', rest)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'X' : rest)  = ('x', rest)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'o' : rest)  = ('o', rest)
readPlayer ('1' : ':' : 'v' : '1' : ':' : 'O' : rest)  = ('o', rest)
readPlayer _ = error "readPlayer error : wrong format"

readHead :: String -> (String, String)
readHead ('1' : ':' : 'x' : rest) = ("1:x", rest)
readHead ('1' : ':' : 'y' : rest) = ("1:y", rest)
readHead ('1' : ':' : 'v' : rest) = ("1:v", rest)

movesToStr :: Moves -> String
movesToStr moves = 
    let
        rev = moves
        str = encodeMoves rev ""
        res = "l" ++ str ++ "e"
    in res

encodeMoves :: Moves -> String -> String
encodeMoves [] str = str
encodeMoves (h:rest) a = 
    let
        m = encodeMove h
    in encodeMoves rest a ++ m  

encodeMove :: Move -> String
encodeMove move = "l" ++ x ++ y ++ v ++ "e"
    where
        duple = makeDuple move
        x = "1:xi" ++ (show . fst) duple ++ "e"
        y = "1:yi" ++ (show . snd) duple ++ "e"
        v = "1:v1:" ++ getPlayerChar move

makeDuple (x,y,_) = (x,y)
getPlayerChar (_,_,c) = [c]