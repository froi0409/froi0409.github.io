import { Instruccion } from "../Instrucciones/Instruccion";
import { Advertencia } from "./Advertencia";
import { Funcion } from "./Funcion";
import { ListaFunciones } from "./ListaFunciones";
import { Struct } from "./Struct";
import { TablaSimbolos } from "./TablaDeSimbolos";

/**
 * Clase que sirve para manejar el flujo principal del programa
 * También controla algunos errores semánticos relacionados a aspectos básicos de las function y los struct
 */
export class Flujo {
    private structs: Array<Struct>
    private listaFunciones: Array<ListaFunciones>
    private tablaDeSimbolos: TablaSimbolos;
    private errores: Array<Advertencia>;


    /**
     * Inicializa los valores principales
     * @param funciones Arreglo de las funciones que tendrá el programa
     * @param tablaDeSimbolos Tabla de simbolos que se manejaran en el programa
     */
    constructor(listaFunciones:Array<ListaFunciones>, tablaDeSimbolos:TablaSimbolos, errores:Array<Advertencia>) {
        this.structs = [];
        this.listaFunciones = listaFunciones;
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.errores = errores;
    }

    /**
     * Verifica si existe la funcion Main
     * @returns true si existe el metodo main, false si no existe el metodo main
     */
    existsMain():boolean {
        let comprobante:boolean = false;
        this.funciones.forEach(function(value) {
            if(value.getNombre() == "main") {
                comprobante = true;
            }
        });
        if(!comprobante) {
            let descripcion:string = 'No existe un metodo main'
            this.errores.push(new Advertencia(0,0, 'Semantico', descripcion));
        }
        return comprobante;
    }   

}