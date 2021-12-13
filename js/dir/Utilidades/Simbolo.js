"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Simbolo = void 0;
/**
 * Clase que nos permite manejar la tabla de simbolos
 */
class Simbolo {
    //Inicializa los valores fundamentales de un simbolo
    constructor(identificador, tipo, esArreglo, longitud, contexto, tipoSimbolo, posMemoria, valor, linea, columna) {
        this.identificador = identificador;
        this.tipo = tipo;
        this.esArreglo = esArreglo;
        this.longitud = longitud;
        this.contexto = contexto;
        this.tipoSimbolo = tipoSimbolo;
        this.posMemoria = posMemoria;
        this.valor = valor;
        this.linea = linea;
        this.columna = columna;
        this.contextoPadre = '-'; //Deberia iniciar siendo nulo
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
