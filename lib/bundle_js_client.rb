module BundleJsClient

  def self.bundle(options)
    system('npm install') or raise 'npm install failed, is npm avail?'
    system('npm install -D webpack webpack-cli imports-loader')

    config_file = Pathname.new('webpack.config.js')
    config_file.write <<~END_OF_CONFIG
const path = require('path');

module.exports = {
  mode: 'production',
  entry: {
    bundle: './src/index.js',
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    publicPath: '/dist/',
    filename: '[name].js',
    library: 'A15kInteractionsClient',
    libraryTarget: 'umd'
  },
  module: {
    rules: [
      { test: /\.js/, loader: 'imports-loader?define=>false'}
    ]
  },
};
    END_OF_CONFIG

    system('$(npm bin)/webpack') or raise 'failed to to generate bundle'
    config_file.unlink

    pkg = JSON.parse(File.read('package.json'))
    pkg['main'] = 'dist/bundle.js'
    File.write('package.json', JSON.pretty_generate(pkg))
  end
end
