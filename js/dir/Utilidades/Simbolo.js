"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Simbolo = void 0;
//Clase que nos permite manejar un simbolo
class Simbolo {
    //Inicializa los valores fundamentales de un simbolo
    constructor(identificador, tipo, valor, linea, columna) {
        this.contexto = 'ninguno';
        this.identificador = identificador;
        this.tipo = tipo;
        this.valor = valor;
        this.linea = linea;
        this.columna = columna;
    }
    //Funcion que permite establecer un contexto para el simbolo. No está definido en el 
    //constructor para permitir variables sin contexto
    setContexto(contexto) {
        this.contexto = contexto;
    }
    //Obtenemos el tipo de simbolo
    getTipo() {
        return this.tipo;
    }
}
exports.Simbolo = Simbolo;
