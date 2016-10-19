# TicTacToe 

#### Goal 
validate given TicTacToe board stae

#### How it works 
the program takes a string encoded in Bencode(without dictionaries)
which represents TicTacToe board state at any point in the game and outputs if board state valid(if invalid - why so)

#### Running 
ghci
beginParse "ll1:xi1e1:yi0e1:v1:xel1:xi2e1:yi2e1:v1:xee"

Example input : "ll1:xi1e1:yi0e1:v1:xel1:xi2e1:yi2e1:v1:xee"
Represents board :
+-+-+-+
| | | |
+-+-+-+
|X| | |
+-+-+-+
| | |X|
+-+-+-+

More inputs can be generated here : http://tictactoe.homedir.eu/test/31
