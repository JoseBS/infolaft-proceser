'use strict'

const xlsx = require('xlsx')

module.exports.processFiles = function ({nombre, nombreId, outFile}){
    let nameSearch = xlsx.utils.sheet_to_json(xlsx.readFile(`..\\filesToProcess\\${nombre}`).Sheets['resultado']) 
    let nameIdSearch = xlsx.utils.sheet_to_json(xlsx.readFile(`..\\filesToProcess\\${nombreId}`).Sheets['resultado'])
    nameSearch = filterRowsByDate(nameSearch)
    nameIdSearch = filterRowsByDate(nameIdSearch)
    let merged = [...nameSearch, ...nameIdSearch]
    merged.sort((a,b)=>{
        const [aFirstPos] = a["VALOR BÚSQUEDA"].split(" / ")
        const [bFirstPos] = b["VALOR BÚSQUEDA"].split(" / ")
        if(aFirstPos < bFirstPos) return -1
        if(aFirstPos > bFirstPos) return 1
        return 0
    })
    merged = mapSistPrev(merged)
    const sistPrev = merged.filter(row => isSistPrev(row)) 
    const noSistPrev = merged.filter(row => !isSistPrev(row))

    const sistPrevSheet = xlsx.utils.json_to_sheet(sistPrev)
    const noSistPrevSheet = xlsx.utils.json_to_sheet(noSistPrev)
    const newBook = xlsx.utils.book_new()
    xlsx.utils.book_append_sheet(newBook, sistPrevSheet, "LISTAS PREV. ")
    xlsx.utils.book_append_sheet(newBook, noSistPrevSheet, "LISTAS NO PREV")
    xlsx.writeFile(newBook, `..\\filesToProcess\\${outFile}.xlsx`)
}

function filterRowsByDate(sheet){
    return sheet.filter(row => {
        let rowDate = new Date(row["FECHA BÚSQUEDA"])
        rowDate = rowDate.setHours(0,0,0,0)
        const currentDate = (new Date()).setHours(0,0,0,0)
        return currentDate === rowDate
    })
}
function isSistPrev(row) {
    return row['LISTA'].toLowerCase() === "Sist Prev".toLowerCase()
}
function mapSistPrev(sheet){
    return sheet.map(row => {
        let RESULTADO = ""
        if(isSistPrev(row)){
            RESULTADO = `Coincidencia: El Tercero Se Encuentra Relacionado como ${row["COMENTARIO EN LA LISTA COINCIDENTE"]} se confirma Lista Sistema de Prevención`
        }
        return {
            ...row,
            RESULTADO
        }
    })
}
