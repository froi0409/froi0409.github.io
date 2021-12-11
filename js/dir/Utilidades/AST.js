"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AST = void 0;
//Clase que nos sirve para controlar el AST
class AST {
    constructor(instrucciones) {
        this.instrucciones = instrucciones;
        this.structs = [];
        this.funciones = [];
    }
    //Permite definir el conjunto de estructuras
    setStructs(structs) {
        this.structs = structs;
    }
    //Permite definir el conjunto de las funciones
    setFunciones(funciones) {
        this.funciones = funciones;
    }
}
exports.AST = AST;
