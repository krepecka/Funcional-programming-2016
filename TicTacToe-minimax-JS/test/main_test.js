var expect = require('chai').expect
var assert = require('assert')
var game = require('../game.js')


require('mocha-testcheck').install();

describe("PROPERTY TESTS", function () {

    check.it('if move within board, it should lower move count', [gen.int, gen.int], function (x, y) {
        assert((game.getAvailableMoves([{x: x, y: y}]).length === 9 && (x < 0 || x > 2 || y < 0 || y > 2))
        || game.getAvailableMoves([{x: x, y: y}]).length === 8 && !(x < 0 || x > 2 || y < 0 || y > 2));
    });

})

