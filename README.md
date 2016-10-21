# TicTacToe 

#### Goal 
validate given TicTacToe board stae

#### How it works 
the program takes a string encoded in Bencode(without dictionaries)
which represents TicTacToe board state at any point in the game and outputs if board state is valid

#### Functions
beginParse "ll1:xi1e1:yi0e1:v1:xel1:xi2e1:yi2e1:v1:xee" -- outputs list of moves made
validate "ll1:xi1e1:yi0e1:v1:xel1:xi2e1:yi2e1:v1:xee" -- outputs if board state is valid

#### Running 
ghci <br/>
:l main <br/>
validate "ll1:xi1e1:yi0e1:v1:xel1:xi2e1:yi2e1:v1:xee"

Example input : "ll1:xi1e1:yi0e1:v1:xel1:xi2e1:yi2e1:v1:xee"
Represents board : <br/>
+-+-+-+<br/>
|-|-|-|<br/>
+-+-+-+<br/>
|X|-|-|<br/>
+-+-+-+<br/>
|-|-|X|<br/>
+-+-+-+<br/>

More inputs can be generated [here](http://tictactoe.homedir.eu/test/31)
