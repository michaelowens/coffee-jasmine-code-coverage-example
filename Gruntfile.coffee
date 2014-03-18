module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        meta:
            src:
                root: 'src'
                coffee: 'src/coffee'
                spec: 'src/spec'
            bin:
                root: 'bin'
                js: '<%= meta.bin.root %>/js'
                spec: '<%= meta.bin.root %>/spec'
                coverage: '<%= meta.bin.root %>/coverage'

        watch:
            coffee:
                options:
                    atBegin: true
                files: ['<%= meta.src.coffee %>/**/*.coffee', '<%= meta.src.spec %>/**/*.coffee']
                tasks: ['coffee:compile']
            spec:
                options:
                    atBegin: true
                files: ['<%= meta.src.coffee %>/**/*.coffee', '<%= meta.src.spec %>/**/*.coffee']
                tasks: ['test']

        clean:
            all: ['<%= meta.bin.root %>']
            js: ['<%= meta.bin.js %>', '<%= meta.bin.spec %>']
            coverage: '<%= meta.bin.coverage %>'

        coffee:
            compile:
                options:
                    join: true
                    sourceMap: true
                files:
                    '<%= meta.bin.js %>/app.js': '<%= meta.src.coffee %>/*.coffee'
            compileBare:
                options:
                    join: true
                    bare: true
                    sourceMap: true
                files:
                    '<%= meta.bin.js %>/app.js': '<%= meta.src.coffee %>/**/*.coffee'
            compileSpecs:
                expand: true
                bare: true
                cwd: '<%= meta.src.spec %>'
                src: '**/*.coffee'
                dest: '<%= meta.bin.spec %>'
                ext: '.js'

        jasmine:
            coverage:
                src: ['<%= meta.bin.js %>/*.js']
                options:
                    specs: ['<%= meta.bin.spec %>/*.js']
                    template: require 'grunt-template-jasmine-istanbul'
                    templateOptions:
                        coverage: '<%= meta.bin.coverage %>/coverage.json'
                        report: [
                            {
                                type: 'html'
                                options:
                                    dir: '<%= meta.bin.coverage %>/html'
                            }
                            {
                                type: 'cobertura'
                                options:
                                    dir: '<%= meta.bin.coverage %>/cobertura'
                            }
                        ]

    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
    grunt.loadNpmTasks 'grunt-istanbul'

    grunt.registerTask 'default', ['compile', 'watch:coffee']
    grunt.registerTask 'compile', ['clean:js', 'coffee:compileBare', 'coffee:compileSpecs']
    grunt.registerTask 'test', ['clean:all', 'coffee:compileBare', 'coffee:compileSpecs', 'jasmine', 'compile']

