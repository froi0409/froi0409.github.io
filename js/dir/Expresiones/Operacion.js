"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Operacion = exports.Operador = void 0;
var Operador;
(function (Operador) {
    Operador[Operador["SUMA"] = 0] = "SUMA";
    Operador[Operador["RESTA"] = 1] = "RESTA";
    Operador[Operador["MULTIPLICACION"] = 2] = "MULTIPLICACION";
    Operador[Operador["DIVISION"] = 3] = "DIVISION";
    Operador[Operador["MODULO"] = 4] = "MODULO";
    Operador[Operador["POW"] = 5] = "POW";
    Operador[Operador["SQRT"] = 6] = "SQRT";
    Operador[Operador["LOG10"] = 7] = "LOG10";
    Operador[Operador["SIN"] = 8] = "SIN";
    Operador[Operador["COS"] = 9] = "COS";
    Operador[Operador["TAN"] = 10] = "TAN";
    Operador[Operador["MENOS_UNARIO"] = 11] = "MENOS_UNARIO";
    Operador[Operador["IGUAL_IGUAL"] = 12] = "IGUAL_IGUAL";
    Operador[Operador["DIFERENTE_IGUAL"] = 13] = "DIFERENTE_IGUAL";
    Operador[Operador["MAYOR_IGUAL"] = 14] = "MAYOR_IGUAL";
    Operador[Operador["MENOR_IGUAL"] = 15] = "MENOR_IGUAL";
    Operador[Operador["MAYOR"] = 16] = "MAYOR";
    Operador[Operador["MENOR"] = 17] = "MENOR";
    Operador[Operador["AND"] = 18] = "AND";
    Operador[Operador["OR"] = 19] = "OR";
    Operador[Operador["NOT"] = 20] = "NOT";
    Operador[Operador["CONCAT_AND"] = 21] = "CONCAT_AND";
    Operador[Operador["CONCAT_POW"] = 22] = "CONCAT_POW";
    Operador[Operador["TERNARIO"] = 23] = "TERNARIO";
    Operador[Operador["UNKNOWN"] = 24] = "UNKNOWN";
})(Operador = exports.Operador || (exports.Operador = {}));
class Operacion {
    constructor(op_izquierda, op_derecha, operador, linea, columna) {
        this.op_izquierda = op_izquierda;
        this.op_derecha = op_derecha;
        this.operador = operador;
        this.linea = linea;
        this.columna = columna;
    }
    //Ejecutar
    getTipo(simbolos, arbol) {
        throw new Error("Method not implemented.");
    }
    getValorImplicito(simbolos, arbol) {
        throw new Error("Method not implemented.");
    }
    //Traducir
    traducir(simbolos, arbol) {
        throw new Error("Method not implemented.");
    }
}
exports.Operacion = Operacion;
