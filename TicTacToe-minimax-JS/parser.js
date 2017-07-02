'use strict';

var Move = require('./model.js').Move;

const colon_s = ':'
const end_s = 'e'
const i_start = 'i'
const l_start = 'l'

function parseList(input) {
    if (input[0] === l_start && input[input.length - 1] === end_s) {
        return input.slice(1);
    } else
        return false
}

function parseNum(input) {
    if (input[0] === i_start) {
        var num = parseInt(input.slice(1))
        var len = num.toString().length

        if (input[len + 1] !== end_s)
            return false

        return [num, input.slice(len + 2)];
    } else
        return false
}

function parseByteStr(input) {
    var len = parseInt(input)
    var l_len = len.toString().length + 1

    if (!len || input[l_len - 1] !== colon_s)
        return false

    var str = input.slice(l_len, len + l_len)

    return [str, input.slice(str.length + l_len)]
}

function parseMove(input) {
    var x = parseByteStr(parseList(input));
    var xc = parseNum(x[1]);
    var y = parseByteStr(xc[1]);
    var yc = parseNum(y[1]);
    var v = parseByteStr(yc[1]);
    var p = parseByteStr(v[1]);

    return [new Move(xc[0], yc[0], p[0]), p[1].slice(1)];
}

function beginParseStr(input) {
    var moves = [];
    var list = parseList(input);

    return parseMoves(list, moves);
}

function parseMoves(input, moves) {
    if (input !== end_s) {
        var m = parseMove(input);
        moves.push(m[0]);

        parseMoves(m[1], moves);
    }

    return moves;
}

//MOVES TO STRING

function moveTostring(move) {
    return "l1:xi" + move.x + "e1:yi" + move.y + "e1:v1:" + move.v + "e";
}

function movesToString(output, moves) {
    if (moves.length !== 0) {
        output = moveTostring(moves.pop()) + output;

        return movesToString(output, moves);
    }
    return 'l' + output + 'e';
}

function beginParseMov(moves) {
    return movesToString('', moves);
}

module.exports.movesToString = beginParseMov;
module.exports.stringToMoves = beginParseStr;