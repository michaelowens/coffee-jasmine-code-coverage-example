(function() {
  describe('Calculator', function() {
    var calc;
    calc = {};
    beforeEach(function() {
      return calc = new Calculator();
    });
    it('should be able to add two numbers', function() {
      expect(calc.add(1, 1)).toBe(2);
      return expect(calc.add(3, 4)).toBe(7);
    });
    it('should be able to subtract two numbers', function() {
      return expect(calc.subtract(32, 18)).toBe(14);
    });
    return it('should be able to multiply two numbers', function() {
      expect(calc.multiply(6, 4)).toBe(24);
      return expect(calc.multiply(1, 1)).toBe(1);
    });
  });

}).call(this);
