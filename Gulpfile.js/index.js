const { dest, parallel, series, src, watch } = require('gulp')

const gulpClean = require('gulp-clean')
const elm = require('gulp-elm')
const rename = require('gulp-rename')

function defaultExec() {
    return series(clean(), build())
}

function clean() {
    return parallel(cleanElm, cleanHtml, cleanScripts, cleanStyles)
}

function cleanElm() {
    return src(['dist/js/elm.js'])
        .pipe(gulpClean())
}

function cleanHtml() {
    return src(['dist/**/*.html'])
        .pipe(gulpClean())
}

function cleanScripts() {
    return src(['dist/**/*.js', '!dist/js/elm.js'])
        .pipe(gulpClean())
}

function cleanStyles() {
    return src(['dist/**/*.css'])
        .pipe(gulpClean())
}

function build() {
    return parallel(html, scripts, styles, transpile)
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

function watchAll() {
    return watch(
        [
            'client/**/*.html',
            'client/**/*.js',
            'client/**/*.css',
            'client/**/*.elm'
        ],
        series(clean(), build())
    )
}

exports.clean = clean()
exports.build = build()
exports.html = html
exports.scripts = scripts
exports.styles = styles
exports.transpile = transpile
exports.watch = watchAll

exports.default = defaultExec()