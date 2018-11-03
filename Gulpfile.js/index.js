const { dest, parallel, series, src } = require('gulp')

const gulpClean = require('gulp-clean')
const elm = require('gulp-elm')
const rename = require('gulp-rename')

function clean() {
    return src(['dist/**/*.css', 'dist/**/*.html', 'dist/**/*.js'])
        .pipe(gulpClean())
}

function html() {
    return src('client/**/*.html')
        .pipe(dest('dist/'))
}

function scripts() {
    return src('client/**/*.js')
        .pipe(dest('dist/'))
}

function styles() {
    return src('client/**/*.css')
        .pipe(dest('dist/'))
}

function transpile() {
    return src('client/Main.elm')
        .pipe(elm())
        .pipe(rename(path => path.basename = 'elm'))
        .pipe(dest('dist/js/'))
}

exports.clean = clean
exports.build = parallel(html, scripts, styles, transpile)
exports.default = series(exports.clean, exports.build)