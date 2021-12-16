"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AST = void 0;
class AST {
    constructor(instrucciones) {
        this.instrucciones = instrucciones;
        this.structs = [];
        this.funciones = [];
    }
    setStructs(structs) {
        this.structs = structs;
    }
    setFunciones(funciones) {
        this.funciones = funciones;
    }
}
exports.AST = AST;
