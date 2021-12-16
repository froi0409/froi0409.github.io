"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Funcion = void 0;
/**
 * Clase que da la base de una funcion
 */
class Funcion {
    constructor(tipo, nombre, instrucciones, contexto, linea, columna) {
        this.tipo = tipo;
        this.nombre = nombre;
        this.contexto = contexto;
        this.instrucciones = instrucciones;
        this.linea = linea;
        this.columna = columna;
    }
    ejecutarAnalisisSemantico(tabla, listadoErrores) {
        throw new Error("Method not implemented.");
    }
    ejecutarFuncionalidad() {
        throw new Error("Method not implemented.");
    }
    traducir(tabla, ast) {
        throw new Error("Method not implemented.");
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
    getLinea() {
        return this.linea;
    }
    getColumna() {
        return this.columna;
    }
}
exports.Funcion = Funcion;
