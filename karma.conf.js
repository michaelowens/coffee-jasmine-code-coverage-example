module.exports = function(config) {
  config.set({
    frameworks: ['jasmine'],

    files: [
      'src/**/*.coffee',
      'test/**/*.coffee'
    ],

    // coverage reporter generates the coverage
    reporters: ['progress', 'coverage'],

    preprocessors: {
      // source files, that you wanna generate coverage for
      // do not include tests or libraries
      // (these files will be instrumented by Istanbul via Ibrik unless
      // specified otherwise in coverageReporter.instrumenter)
      'src/**/*.coffee': ['coverage'],

      // note: project files will already be converted to
      // JavaScript via coverage preprocessor.
      // Thus, you'll have to limit the CoffeeScript preprocessor
      // to uncovered files.
      'test/**/*.coffee': ['coffee']
    },

    // optionally, configure the reporter
    coverageReporter: {
      type : 'html',
      dir : 'coverage/'
    }
  });
};