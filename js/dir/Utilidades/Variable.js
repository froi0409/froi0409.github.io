"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Variable = void 0;
/**
 * Clase que nos permite manejar una variable como un objeto
 */
class Variable {
    constructor(tipo, nombre, valor) {
        this.tipo = tipo;
        this.nombre = nombre;
        this.valor = valor;
    }
}
exports.Variable = Variable;
