"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Primitivo = void 0;
class Primitivo {
    constructor(valor, linea, columna) {
        this.linea = linea;
        this.columna = columna;
        this.valor = valor;
    }
    getTipo(simbolos, arbol) {
        throw new Error("Method not implemented.");
    }
    getValorImplicito(simbolos, arbol) {
        throw new Error("Method not implemented.");
    }
    traducir(simbolos, arbol) {
        throw new Error("Method not implemented.");
    }
}
exports.Primitivo = Primitivo;
