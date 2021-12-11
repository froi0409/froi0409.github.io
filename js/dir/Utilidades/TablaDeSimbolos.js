"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TablaSimbolos = void 0;
//Clase que nos servira para gestionar la tabla de simbolos
class TablaSimbolos {
    constructor() {
        //Atributos de la Tabla de Simbolos
        /*
        tabla: Es la tabla de simbolos como tal
        size: Es el tamaño de la tabla de simbolos
        */
        this.tabla = [];
        this.size = 0;
    }
    //Nos permite insertar un simbolo nuevo a la tabla    
    insertSymbol(simbolo) {
        this.tabla[this.size] = simbolo;
        this.size++;
    }
    getTabla() {
        return this.tabla;
    }
}
exports.TablaSimbolos = TablaSimbolos;
