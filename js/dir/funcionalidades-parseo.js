"use strict";
const ParserGenerado = require('./gramatica/gramatica.js');
window.parseo = function () {
    const entrada = document.getElementById('entrada');
    const consola = document.getElementById('consola');
    let entradaTexto = entrada.value;
    consola.value = 'Salida: \n';
    ParserGenerado.parse(entradaTexto);
};
