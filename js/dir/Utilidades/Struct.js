"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Struct = void 0;
class Struct {
    constructor(nombre, linea, columna) {
        this.nombre = nombre;
        this.linea = linea;
        this.columna = columna;
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
