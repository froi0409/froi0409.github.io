"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Funcion = void 0;
/**
 * Clase que da la base de una funcion
 */
class Funcion {
    constructor(tipo, nombre, instrucciones, linea, columna) {
        this.tipo = tipo;
        this.nombre = nombre;
        this.instrucciones = instrucciones;
        this.tipoRetorno = '';
        this.valorRetorno = '';
        this.linea = linea;
        this.columna = columna;
    }
    /**
     * Permite agregar una instruccion a la lista de instrucciones
     * @param instruccion Instruccion que se desea agregar
     */
    agregarInstruccion(instruccion) {
        this.instrucciones.push(instruccion);
    }
    //setters y getters
    getTipo() {
        return this.tipo;
    }
    getNombre() {
        return this.nombre;
    }
    getTipoRetorno() {
        return this.tipoRetorno;
    }
    getValorRetorno() {
        return this.valorRetorno;
    }
    getLinea() {
        return this.linea;
    }
    getColumna() {
        return this.columna;
    }
}
exports.Funcion = Funcion;
