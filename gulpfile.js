var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    del = require('del'),
    concat = require('gulp-concat'),
    coffee = require('gulp-coffee'),
    uglify = require('gulp-uglify'),
    gulpif = require('gulp-if'),
    compress = false;

gulp.task('scripts', function () {
    del('./bin/**', {silent: true});
    gulp.src('./src/**/*.coffee')
        .pipe(sourcemaps.init())
        .pipe(coffee({join: true}).on('error', console.error))
        .pipe(gulpif(compress, concat('app.min.js'), concat('app.js')))
        .pipe(gulpif(compress, uglify()))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('./bin/js'));

    compress = false;
});

gulp.task('watch', function () {
    gulp.watch('./src/**/*.coffee', ['scripts']);
});

gulp.task('deploy', function () {
    compress = true;
    gulp.start('scripts');
});

gulp.task('default', ['watch', 'scripts']);
