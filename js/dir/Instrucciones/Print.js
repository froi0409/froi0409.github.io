"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Print = void 0;
//Clase que nos permite manejar la instruccion Print
class Print {
    constructor(impresion, contexto, endl) {
        this.impresion = impresion;
        this.endl = endl;
        this.nombre = '';
        this.contexto = contexto;
        console.log('Valor a Imprimir: ' + this.impresion);
    }
    ejecutarAnalisisSemantico(tabla, listadoErrores) {
        throw new Error("Method not implemented.");
    }
    ejecutarFuncionalidad() {
        throw new Error("Method not implemented.");
    }
    //Ejecuta la instrucción de impresión
    ejecutar(tabla, listadoErrores, ast) {
        const consola = document.getElementById('consola'); //Obtenemos el textarea que se está usando como salida
        consola.value += this.impresion; //Agregamos a la salida el texto que se desea imprimir
        if (this.endl) { //Si se usó println, imprime un salto de linea
            consola.value += '\n';
        }
    }
    //Traduce a código 3D
    traducir(tabla, ast) {
        throw new Error("Method not implemented.");
    }
}
exports.Print = Print;
