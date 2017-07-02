
var Move = require('./model.js').Move;

// global.myChar = 'x'
// global.enemyChar = 'o'


function isGameOver(moves){
    return isWinner(moves, 'x') || isWinner(moves, 'o') || moves.length === 9
}

function isWinner(moves, char){
    return checkRow(moves, char, 0) || checkRow(moves, char, 1) || checkRow(moves, char, 2) ||
            checkCol(moves, char, 0) || checkCol(moves, char, 1) || checkCol(moves, char, 2) ||
            checkDiag(moves, char) || checkDiagRev(moves, char);
}

function checkRow(moves, char, row){
    return moves.filter((move) => {
        return move.x == row && move.v == char;
    }).length === 3;
}

function checkCol(moves, char, col){
    return moves.filter((move) => {
        return move.y == col && move.v == char;
    }).length === 3;
}

function checkDiag(moves, char){
    return moves.filter((move) => {
        return ((move.y == 0 && move.x == 0) || (move.y == 1 && move.x == 1) || (move.y == 2 && move.x == 2))
                        && move.v == char;
    }).length === 3;
}

function checkDiagRev(moves, char){
    return moves.filter((move) => {
        return ((move.y == 0 && move.x == 2) || (move.y == 1 && move.x == 1) || (move.y == 2 && move.x == 0))
                        && move.v == char;
    }).length === 3;
}

function getOneMove(moves){
    return minimax(moves).move;
}

var MoveScore = function(move, score){
    this.move = move;
    this.score = score;
}

// MINIMAX
function minimax(game){
    if(isGameOver(game))
        return new MoveScore(game, score(game))

    var scores = []
    var moves = []

    getAvailableMoves(game).forEach((move) => {
        var char = activeTurn(game) == global.myChar ? global.myChar : global.enemyChar
        var newM = new Move(move.x, move.y, char)
        var possGame = game.slice(0)
        possGame.push(newM)
        scores.push(minimax(possGame).score)
        moves.push(newM)

    })
    
    if(activeTurn(game) == global.myChar){
        var max_index = scores.indexOf(Math.max(...scores))
        var choice = moves[max_index]
        return new MoveScore(choice, scores[max_index])
    }else{
        var min_index = scores.indexOf(Math.min(...scores))
        var choice = moves[min_index]
        return new MoveScore(choice, scores[min_index])
    }

}

function activeTurn(moves){
    var count_x = moves.filter((m) => m.v === 'x').length
    var count_o = moves.filter((m) => m.v === 'o').length

    if(count_x === count_o)
        return 'x'
    else return 'o'
}

function score(moves){
    if(isWinner(moves, global.myChar))
        return 10
    else if(isWinner(moves, global.enemyChar))
        return -10
    else
        return 0
}

function getAvailableMoves(moves){
    var x = [0,1,2]
    var y = [0,1,2]

    var a = x.map((x) => {
        return y.map((y) => {
            return {x: x, y: y}
        })
    })

    var mov = [].concat.apply([], a)

    return mov.filter((move) => {
        return moves.filter((m) => {
            return m.x == move.x && m.y == move.y
        }).length == 0
    })
}

var test = [new Move(1,1,'x'), new Move(0,0,'o'),new Move(0,1,'x'),new Move(1,0,'o')]

console.log(minimax(test))
console.log(getAvailableMoves([{x:1, y:0}]))

module.exports.isGameOver = isGameOver
module.exports.getOneMove = getOneMove
module.exports.getAvailableMoves = getAvailableMoves
