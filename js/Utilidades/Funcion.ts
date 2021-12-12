import { Instruccion } from "../Instrucciones/Instruccion";

/**
 * Clase que da la base de una funcion
 */
export class Funcion {

    private tipo:string;
    private nombre:string;
    private instrucciones:Array<Instruccion>;
    private tipoRetorno:string;
    private valorRetorno:string;

    private linea:number;
    private columna:number;

    constructor(tipo:string, nombre:string, instrucciones:Array<Instruccion>, linea:number, columna:number) {
        this.tipo = tipo;
        this.nombre = nombre;
        this.instrucciones = instrucciones;
        this.tipoRetorno = '';
        this.valorRetorno = '';
        this.linea = linea;
        this.columna = columna;
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
    getTipoRetorno() {
        return this.tipoRetorno;
    }
    getValorRetorno() {
        return this.valorRetorno;
    }
    getLinea() {
        return this.linea;
    }
    getColumna() {
        return this.columna;
    }

}