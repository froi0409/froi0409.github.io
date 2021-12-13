"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Flujo = void 0;
/**
 * Clase que sirve para manejar el flujo principal del programa
 * También controla algunos errores semánticos relacionados a aspectos básicos de las function y los struct
 */
class Flujo {
    /**
     * Inicializa los valores principales
     * @param funciones Arreglo de las funciones que tendrá el programa
     * @param tablaDeSimbolos Tabla de simbolos que se manejaran en el programa
     */
    constructor(structs, listaFunciones, tablaDeSimbolos, errores) {
        this.structs = structs;
        this.listaFunciones = listaFunciones;
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.errores = errores;
    }
}
exports.Flujo = Flujo;
