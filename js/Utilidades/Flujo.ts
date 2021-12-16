import { Instruccion } from "../Instrucciones/Instruccion";
import { Advertencia } from "./Advertencia";
import { Funcion } from "./Funcion";
import { ListaFunciones } from "./ListaFunciones";
import { ListaStructs } from "./ListaStructs";
import { Struct } from "./Struct";
import { TablaSimbolos } from "./TablaDeSimbolos";

/**
 * Clase que sirve para manejar el flujo principal del programa
 * También controla algunos errores semánticos relacionados a aspectos básicos de las function y los struct
 */
export class Flujo {
    structs:ListaStructs;
    listaFunciones:ListaFunciones;
    tablaDeSimbolos: TablaSimbolos;
    listadoInstruccionesGlobales:Array<Instruccion>;
    listadoErrores: Array<Advertencia>;


    /**
     * Inicializa los valores principales
     * @param funciones Arreglo de las funciones que tendrá el programa
     * @param tablaDeSimbolos Tabla de simbolos que se manejaran en el programa
     */
    constructor(structs:ListaStructs, listaFunciones:ListaFunciones, tablaDeSimbolos:TablaSimbolos, listadoInstruccionesGlobales:Array<Instruccion>, errores:Array<Advertencia>) {
        this.structs = structs;
        this.listaFunciones = listaFunciones;
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.listadoInstruccionesGlobales = listadoInstruccionesGlobales;
        this.listadoErrores = errores;
    }

    ejecutarAnalisis() {
        //Analizamos los struct
        for(let i = 0; i < this.structs.structs.length; i++) {
            this.structs.structs[i].ejecutarAnalisis(this.tablaDeSimbolos, this.listadoErrores);
        }
        
        //Analizamos las instrucciones globales
        for(let i = 0; i < this.listadoInstruccionesGlobales.length; i++) {
            this.listadoInstruccionesGlobales[i].ejecutarAnalisisSemantico(this.tablaDeSimbolos, this.listadoErrores);
        }

        //Analizar las funciones
        for(let i = 0; i < this.listaFunciones.funciones.length; i++) {
            this.listaFunciones.funciones[i].ejecutarAnalisisSemantico(this.tablaDeSimbolos, this.listadoErrores);
        }

    }

    ejecucionInterpretacion() {
        if(this.listaFunciones.existsMain()) {
            let main:Funcion;
            for(let i = 0; i < this.listaFunciones.funciones.length; i++) {
                if(this.listaFunciones.funciones[i].nombre == 'main') {
                    main = this.listaFunciones.funciones[i];
                    //Se ejecuta la funcionalidad del programa
                    main.ejecutarFuncionalidad();
                    break;
                }
            }
        }
    }

}