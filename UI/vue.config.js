module.exports = {
outputDir: "../docs",
publicPath: process.env.NODE_ENV === 'production'
    ? '/cs425project/'
    : '/'
};
