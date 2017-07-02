'use strict'

var http = require('http')
var request = require('request')
var parser = require('./parser.js')
var Move = require('./model.js').Move
var game = require('./game.js')

const url_base = "http://tictactoe.homedir.eu/game/"

var args = process.argv.slice(2)
var game_id = args[0]
var mode = parseInt(args[1])
const url = url_base + game_id + '/player/' + mode
const path = '/' + game_id + '/player/' + mode

if (mode !== 1 && mode !== 2) {
    console.log("Enter valid game mode: 1 or 2")
    return
}

const myChar = mode == 1 ? 'x' : 'o'
const enemyChar = mode == 2 ? 'x' : 'o'

global.myChar = myChar
global.enemyChar = enemyChar


var firstMove = new Move(1, 1, myChar)

startGame();

function startGame() {
    if (mode === 1)
        postMoves([firstMove], playGame)
    else
        playGame()

}

function playGame() {
    request({
        url: url,
        method: 'GET',
        headers: {
            "Accept": "application/bencode+list"
        }
    }, function (err, res, body) {
        if (err || res.statusCode !== 200) {
            console.log('err' + err + ' status' + res.statusCode)
            return
        }

        console.log('body ' + body)
        //parse body into moves
        var moves = parser.stringToMoves(body)

        if (!game.isGameOver(moves)) {

            moves.push(game.getOneMove(moves))

            postMoves(moves, playGame);
        }

    })

}

function postMoves(moves, cb) {
    var m = moves.slice(0)
    request({
        url: url,
        method: 'POST',
        body: parser.movesToString(moves),
        headers: {
            'Content-Type': 'application/bencode+list'
        }
    }, function (err, res, body) {
        if (err) {
            console.log(ee)
        } else {
            console.log(res.statusCode, body)

            if (!game.isGameOver(m))
                cb()
        }
    })
}





