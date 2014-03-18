describe 'Calculator', ->
    calc = {}
    beforeEach -> calc = new Calculator()

    it 'should be able to add two numbers', ->
        expect(calc.add 1, 1).toBe 2
        expect(calc.add 3, 4).toBe 7

    it 'should be able to subtract two numbers', ->
        expect(calc.subtract 32, 18).toBe 14
        expect(calc.subtract 10, 5).toBe 5

    it 'should be able to multiply two numbers', ->
        expect(calc.multiply 6, 4).toBe 24
        expect(calc.multiply 1, 1).toBe 1
