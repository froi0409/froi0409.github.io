"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ListaFunciones = void 0;
const Advertencia_1 = require("./Advertencia");
/**
 * Clase que n os permite manejar las funciones de manera personalizada
 */
class ListaFunciones {
    constructor(tablaDeSimbolos, errores) {
        this.funciones = [];
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.errores = errores;
        this.size = 0;
    }
    /**
     * Verifica si existe la funcion Main
     * @returns true si existe el funcion main, false si no existe el funcion main
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
    /**
     * Permite agregar una función y comprobar si ya existe una función con el nombre requerido
     */
    insertFunction(funcionA) {
        let repetida = false;
        this.funciones.forEach(function (value) {
            if (value.getNombre() == funcionA.getNombre()) { //Si el nombre de la funcion ya existe, entonces se agrega el error a la tabla de simbolos
                repetida = true;
            }
        });
        if (repetida) { //Si la función está repetida, se agrega el error
            let descripcionError = 'La funcion ' + funcionA.getNombre() + ' ya se encuentra definida';
            let linea = funcionA.getLinea();
            let columna = funcionA.getColumna();
            this.errores.push(new Advertencia_1.Advertencia(linea, columna, 'Semantico', descripcionError));
        }
        else { //Si la función no está repetida, se agrega la función a la lista
            this.funciones.push(funcionA);
        }
    }
    /**
     * Para uso muy exclusivo de pruebas
     * @returns Array de Funciones puro con las funciones
     */
    getListadoPuro() {
        return this.funciones;
    }
}
exports.ListaFunciones = ListaFunciones;
