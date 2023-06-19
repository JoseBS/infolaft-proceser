'use strict'
const yargs = require('yargs/yargs')
const { hideBin } = require('yargs/helpers')
const argv = yargs(hideBin(process.argv)).argv
if(!argv.nombre || !argv.nombreId ){
    throw new Error('No se proporcionaron archivos')
}
if(!argv.outFile){
    throw new Error('No se proporcionó un outFile')
}
const { processFiles } = require('./src')
processFiles(argv)