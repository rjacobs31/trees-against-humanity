const { dest, parallel, series, src, watch } = require('gulp')

const clean = require('gulp-clean')
const livereload = require('gulp-livereload')
const elm = require('gulp-elm')
const rename = require('gulp-rename')

function defaultExec() {
    return series(cleanTask(), build())
}

function cleanTask() {
    return parallel(cleanElm, cleanHtml, cleanScripts, cleanStyles)
}

function cleanElm() {
    return src(['dist/js/elm.js'], {allowEmpty: true})
        .pipe(clean())
}

function cleanHtml() {
    return src(['dist/**/*.html'], {allowEmpty: true})
        .pipe(clean())
}

function cleanScripts() {
    return src(['dist/**/*.js', '!dist/js/elm.js'], {allowEmpty: true})
        .pipe(clean())
}

function cleanStyles() {
    return src(['dist/**/*.css'], {allowEmpty: true})
        .pipe(clean())
}

function build() {
    return parallel(html, scripts, styles, transpile)
}

function html() {
    return src('client/**/*.html')
        .pipe(dest('dist/'))
        .pipe(livereload())
}

function scripts() {
    return src('client/**/*.js')
        .pipe(dest('dist/'))
        .pipe(livereload())
}

function styles() {
    return src('client/**/*.css')
        .pipe(dest('dist/'))
        .pipe(livereload())
}

function transpile() {
    return src('client/Main.elm')
        .pipe(elm())
        .pipe(rename(path => path.basename = 'elm'))
        .pipe(dest('dist/js/'))
        .pipe(livereload())
}

function watchAll() {
    livereload.listen({basePath: 'dist/', port: 35729, start: true})

    watch('client/**/*.elm', { ignoreInitial: false }, series(cleanElm, transpile))
    watch('client/**/*.html', { ignoreInitial: false }, series(cleanHtml, html))
    watch('client/**/*.js', { ignoreInitial: false }, series(cleanScripts, scripts))
    watch('client/**/*.css', { ignoreInitial: false }, series(cleanStyles, styles))
}

exports.clean = cleanTask()
exports.build = build()
exports.html = html
exports.scripts = scripts
exports.styles = styles
exports.transpile = transpile
exports.watch = watchAll

exports.default = defaultExec()