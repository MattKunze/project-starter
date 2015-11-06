webpack = require 'webpack'

module.exports = (paths) ->
  entry:
    index: "#{paths.src}/index.coffee"
  output:
    path: paths.build
    filename: '[name].js'
  resolve:
    extensions: [
      ''
      '.coffee'
      '.js'
    ]
  module:
    loaders: [
      test: /\.coffee$/
      loader: 'coffee-loader'
    ,
      test: /\.css$/
      loader: 'style-loader!css-loader'
    ]
  plugins: [
    new webpack.ProvidePlugin
      React: 'react'
      ReactDOM: 'react-dom'
  ]
