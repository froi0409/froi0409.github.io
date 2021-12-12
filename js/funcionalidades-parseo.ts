const ParserGenerado = require('./gramatica/gramatica.js');

declare global {
    interface Window { parseo:any; }
}

window.parseo = function() {
    const entrada = document.getElementById('entrada') as HTMLTextAreaElement;
    const consola = document.getElementById('consola') as HTMLTextAreaElement;
    let entradaTexto = entrada.value;
    consola.value = 'Salida: \n';

    ParserGenerado.parse(entradaTexto);

}
