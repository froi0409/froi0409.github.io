"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Struct = void 0;
class Struct {
    constructor(nombre, linea, columna, contexto) {
        this.nombre = nombre;
        this.contexto = contexto;
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
    ejecutarAnalisis(tablaDeSimbolos, listadoErrores) {
        //Agregar a tabla de simbolos los struct con sus parametros 
        //Comprobar errores
    }
    //getters y setters
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
exports.Struct = Struct;
