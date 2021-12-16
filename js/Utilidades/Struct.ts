import { Instruccion } from "../Instrucciones/Instruccion";
import { Advertencia } from "./Advertencia";
import { AST } from "./AST";
import { TablaSimbolos } from "./TablaDeSimbolos";

export class Struct implements Instruccion{
    nombre:string;
    contexto:Instruccion;

    //Variables pertenecientes al struct
    linea:number; //Número de linea del struct
    columna:number; //Número de columna del struct


    constructor(nombre:string, linea:number, columna:number, contexto:Instruccion) {
        this.nombre = nombre;
        this.contexto = contexto;
        this.linea = linea;
        this.columna = columna;
    }
    
    ejecutarAnalisisSemantico(tabla: TablaSimbolos, listadoErrores: Advertencia[]) {
        throw new Error("Method not implemented.");
    }
    ejecutarFuncionalidad() {
        throw new Error("Method not implemented.");
    }
    traducir(tabla: TablaSimbolos, ast: AST) {
        throw new Error("Method not implemented.");
    }

    ejecutarAnalisis(tablaDeSimbolos:TablaSimbolos, listadoErrores:Array<Advertencia>) {
        //Agregar a tabla de simbolos los struct con sus parametros 
        //Comprobar errores
    }

    //getters y setters
    getNombre():string {
        return this.nombre;
    }
    getLinea():number {
        return this.linea;
    }
    getColumna():number {
        return this.columna;
    }
}
