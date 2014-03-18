module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        meta:
            src:
                coffee: 'src/coffee'
                spec: 'src/spec'
            build:
                js: 'build/js'
                spec: 'spec'
                coverage: 'coverage'

        watch:
            coffee:
                files: ['<%= meta.src.coffee %>/**/*.coffee', '<%= meta.src.spec %>/**/*.coffee']
                tasks: ['coffee:compile']
            spec:
                files: ['<%= meta.src.coffee %>/**/*.coffee', '<%= meta.src.spec %>/**/*.coffee']
                tasks: ['test']

        clean:
            all: ['<%= meta.build.js %>', '<%= meta.build.spec %>', '<%= meta.build.coverage %>']
            build: ['<%= meta.build.js %>', '<%= meta.build.spec %>']
            coverage: '<%= meta.build.coverage %>'

        coffee:
            compile:
                files:
                    '<%= meta.build.js %>/app.js': '<%= meta.src.coffee %>/*.coffee'
            compileBare:
                options:
                    bare: true
                files:
                    '<%= meta.build.js %>/app.js': '<%= meta.src.coffee %>/**/*.coffee'
            compileSpecs:
                expand: true
                bare: true
                cwd: '<%= meta.src.spec %>'
                src: '**/*.coffee'
                dest: '<%= meta.build.spec %>'
                ext: '.js'

        jasmine:
            coverage:
                src: ['<%= meta.build.js %>/*.js']
                options:
                    specs: ['<%= meta.build.spec %>/*.js']
                    template: require 'grunt-template-jasmine-istanbul'
                    templateOptions:
                        coverage: '<%= meta.build.coverage %>/coverage.json'
                        report: [
                            {
                                type: 'html'
                                options:
                                    dir: '<%= meta.build.coverage %>/html'
                            }
                            {
                                type: 'cobertura'
                                options:
                                    dir: '<%= meta.build.coverage %>/cobertura'
                            }
                        ]

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
    grunt.loadNpmTasks 'grunt-istanbul'

    grunt.registerTask 'default', ['compile', 'watch:coffee']
    grunt.registerTask 'compile', ['clean:build', 'coffee:compileBare', 'coffee:compileSpecs']
    grunt.registerTask 'test', ['clean:all', 'coffee:compileBare', 'coffee:compileSpecs', 'jasmine', 'compile']

