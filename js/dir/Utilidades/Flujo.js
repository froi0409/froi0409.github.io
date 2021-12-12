"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Flujo = void 0;
const Advertencia_1 = require("./Advertencia");
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
    constructor(listaFunciones, tablaDeSimbolos, errores) {
        this.structs = [];
        this.listaFunciones = listaFunciones;
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.errores = errores;
    }
    /**
     * Verifica si existe la funcion Main
     * @returns true si existe el metodo main, false si no existe el metodo main
     */
    existsMain() {
        let comprobante = false;
        this.funciones.forEach(function (value) {
            if (value.getNombre() == "main") {
                comprobante = true;
            }
        });
        if (!comprobante) {
            let descripcion = 'No existe un metodo main';
            this.errores.push(new Advertencia_1.Advertencia(0, 0, 'Semantico', descripcion));
        }
        return comprobante;
    }
}
exports.Flujo = Flujo;
