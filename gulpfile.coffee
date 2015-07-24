del = require 'del'
path = require 'path'

gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

webpack = require 'webpack'
WebpackDevServer = require 'webpack-dev-server'
ReloadPlugin = require 'webpack-reload-plugin'

projectPath = path.resolve __dirname
paths =
  base: projectPath
  src:   "#{projectPath}/src"
  build: "#{projectPath}/build"

webpackConfig = (require './webpack.config.coffee') paths

githubAuth = require './githubauth'
oauth = require './oauth.json'

gulp.task 'default', [ 'run' ]

gulp.task 'statics', ->
  gulp.src "#{paths.src}/*.html"
    .pipe gulp.dest paths.build

gulp.task 'build', [ 'statics' ], (cb) ->
  webpack webpackConfig, (err, stats) ->
    $.util.log '[app:src]', stats.toString colors: true
    cb err

gulp.task 'run', [ 'statics' ], ->
  port = $.util.env.listenport or 8080
  webpackConfig.plugins.push new ReloadPlugin 'localhost'
  compiler = webpack webpackConfig
  server = new WebpackDevServer compiler,
    contentBase: paths.build
    stats: { colors: true }
  server.use '/auth', githubAuth oauth
  server.listen port, (err) ->
    if err
      throw new $.util.PluginError 'webpack-dev-server', err

    $.util.log ($.util.colors.cyan '[webpack-dev-server]'),
      "Listening at http://localhost:#{port}"

gulp.task 'clean', (cb) ->
  del [ paths.build ], cb
