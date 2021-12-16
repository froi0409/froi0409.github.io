import { Instruccion } from "../Instrucciones/Instruccion";
import { Advertencia } from "./Advertencia";
import { AST } from "./AST";
import { TablaSimbolos } from "./TablaDeSimbolos";

/**
 * Clase que da la base de una funcion
 */
export class Funcion implements Instruccion {

    tipo:string;
    nombre:string;
    contexto:Instruccion;
    instrucciones:Array<Instruccion>;
    linea:number;
    columna:number;

    constructor(tipo:string, nombre:string, instrucciones:Array<Instruccion>, contexto:Instruccion, linea:number, columna:number) {
        this.tipo = tipo;
        this.nombre = nombre;
        this.contexto = contexto;
        this.instrucciones = instrucciones;
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

    /**
     * Permite agregar una instruccion a la lista de instrucciones
     * @param instruccion Instruccion que se desea agregar
     */
    agregarInstruccion(instruccion:Instruccion) {
        this.instrucciones.push(instruccion);
    }

    //setters y getters
    getTipo() {
        return this.tipo;
    }
    getNombre() {
        return this.nombre;
    }
    getLinea() {
        return this.linea;
    }
    getColumna() {
        return this.columna;
    }

}