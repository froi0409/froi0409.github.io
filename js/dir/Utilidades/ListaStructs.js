"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ListaStructs = void 0;
const Advertencia_1 = require("./Advertencia");
/**
 * Clase que nos permite manejar los Structs de manera personalizada
 */
class ListaStructs {
    constructor(structs, errores) {
        this.structs = structs;
        this.errores = errores;
        this.size = 0;
    }
    /**
     * Permite insertar un struct a la lista
     * @param structA Struct que se va a ingresar
     */
    insertStruct(structA) {
        let repetido = false;
        this.structs.forEach(function (value) {
            if (value.getNombre() == structA.getNombre()) { //Comprueba si el struct se encuentra ya en el listado de structs
                repetido = true;
            }
        });
        if (repetido) { //Si el struct está repetido, se agrega el error a la lista de errores
            let descripcionError = 'El struct ' + structA.getNombre() + ' ya se encuentra definido';
            let linea = structA.getLinea();
            let columna = structA.getColumna();
            this.errores.push(new Advertencia_1.Advertencia(linea, columna, 'Semantico', descripcionError));
        }
        else { //Si el struct no está repetido, se agrega a la lista de structs
            this.structs.push(structA);
        }
    }
}
exports.ListaStructs = ListaStructs;
