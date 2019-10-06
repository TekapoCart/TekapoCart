const path = require('path');
const FixStyleOnlyEntriesPlugin = require('webpack-fix-style-only-entries');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');

const minimizers = [];
const plugins = [
  new FixStyleOnlyEntriesPlugin(),
  new MiniCssExtractPlugin({
    filename: '[name].css',
  }),
];

const config = {
  entry: {
    'js/bo_order': './_dev/js/bo_order.js',
    'js/ec_in_context': './_dev/js/ec_in_context.js',
    'js/order_confirmation': './_dev/js/order_confirmation.js',
    'js/payment_ppp': './_dev/js/payment_ppp.js',
    'js/shortcut_payment': './_dev/js/shortcut_payment.js',
    'js/shortcut': './_dev/js/shortcut.js',
    'js/adminSetup': './_dev/js/adminSetup.js',
    'js/adminCheckout': './_dev/js/adminCheckout.js',
    'js/helpAdmin': './_dev/js/helpAdmin.js',

    'css/paypal_bo': './_dev/scss/paypal_bo.scss',
  },

  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, './views/'),
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env'],
            },
          },
        ],
      },

      {
        test: /\.(s)?css$/,
        use: [
          {loader: MiniCssExtractPlugin.loader},
          {loader: 'css-loader'},
          {loader: 'postcss-loader'},
          {loader: 'sass-loader'},
        ],
      },

    ],
  },

  externals: {
    $: '$',
    jquery: 'jQuery',
  },

  plugins,

  optimization: {
    minimizer: minimizers,
  },

  resolve: {
    extensions: ['.js', '.scss', '.css'],
    alias: {
      '~': path.resolve(__dirname, './node_modules'),
      '$img_dir': path.resolve(__dirname, './views/img'),
    },
  },
};

module.exports = (env, argv) => {
  // Production specific settings
  if (argv.mode === 'production') {
    const terserPlugin = new TerserPlugin({
      cache: true,
      extractComments: /^\**!|@preserve|@license|@cc_on/i, // Remove comments except those containing @preserve|@license|@cc_on
      parallel: true,
      terserOptions: {
        drop_console: true,
      },
    });

    config.optimization.minimizer.push(terserPlugin);
  }

  return config;
};
