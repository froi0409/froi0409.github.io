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
    private structs:ListaStructs;
    private listaFunciones:ListaFunciones;
    private tablaDeSimbolos: TablaSimbolos;
    private errores: Array<Advertencia>;


    /**
     * Inicializa los valores principales
     * @param funciones Arreglo de las funciones que tendrá el programa
     * @param tablaDeSimbolos Tabla de simbolos que se manejaran en el programa
     */
    constructor(structs:ListaStructs, listaFunciones:ListaFunciones, tablaDeSimbolos:TablaSimbolos, errores:Array<Advertencia>) {
        this.structs = structs;
        this.listaFunciones = listaFunciones;
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.errores = errores;
    }


}