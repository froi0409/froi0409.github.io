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
    constructor(structs, listaFunciones, tablaDeSimbolos, listadoInstruccionesGlobales, errores) {
        this.structs = structs;
        this.listaFunciones = listaFunciones;
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.listadoInstruccionesGlobales = listadoInstruccionesGlobales;
        this.listadoErrores = errores;
    }
    ejecutarAnalisis() {
        //Analizamos los struct
        for (let i = 0; i < this.structs.structs.length; i++) {
            this.structs.structs[i].ejecutarAnalisis(this.tablaDeSimbolos, this.listadoErrores);
        }
        //Analizamos las instrucciones globales
        for (let i = 0; i < this.listadoInstruccionesGlobales.length; i++) {
            this.listadoInstruccionesGlobales[i].ejecutarAnalisisSemantico(this.tablaDeSimbolos, this.listadoErrores);
        }
        //Analizar las funciones
        for (let i = 0; i < this.listaFunciones.funciones.length; i++) {
            this.listaFunciones.funciones[i].ejecutarAnalisisSemantico(this.tablaDeSimbolos, this.listadoErrores);
        }
    }
    ejecucionInterpretacion() {
        if (this.listaFunciones.existsMain()) {
            let main;
            for (let i = 0; i < this.listaFunciones.funciones.length; i++) {
                if (this.listaFunciones.funciones[i].nombre == 'main') {
                    main = this.listaFunciones.funciones[i];
                    //Se ejecuta la funcionalidad del programa
                    main.ejecutarFuncionalidad();
                    break;
                }
            }
        }
    }
}
exports.Flujo = Flujo;
