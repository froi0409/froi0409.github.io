import { Instruccion } from "../Instrucciones/Instruccion";

//Clase que nos sirve para controlar el AST
export class AST {

    //Atributos del AST
    /*
    instrucciones es un ArrayList que contiene las instrucciones que se van a ejecutar
    structs es un ArrayList que contiene las diversas estructuras
    funciones es un ArrayList que contiene los subprocesos que se van a ejecutar    
    */

    public instrucciones: Array<Instruccion>
    public structs: Array<any>
    public funciones: Array<any>

    constructor(instrucciones:Array<Instruccion>) {
        this.instrucciones = instrucciones;
        this.structs = [];
        this.funciones = [];
    }

    //Permite definir el conjunto de estructuras
    setStructs(structs:Array<any>) {
        this.structs = structs;
    }


    //Permite definir el conjunto de las funciones
    setFunciones(funciones:Array<any>) {
        this.funciones = funciones;
    }

}
