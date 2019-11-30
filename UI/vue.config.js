module.exports = {
    outputDir: "../docs",
    publicPath: process.env.NODE_ENV === 'production'
        ? '/cs425project/'
        : '/',
    chainWebpack: config => {
        config.performance
          .maxEntrypointSize(400000)
          .maxAssetSize(400000)
      }
};
