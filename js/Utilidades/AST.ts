import { Instruccion } from "../Instrucciones/Instruccion";

export class AST {

    public instrucciones: Array<Instruccion>
    public structs: Array<any>
    public funciones: Array<any>

    constructor(instrucciones:Array<Instruccion>) {
        this.instrucciones = instrucciones;
        this.structs = [];
        this.funciones = [];
    }

    setStructs(structs:Array<any>) {
        this.structs = structs;
    }

    setFunciones(funciones:Array<any>) {
        this.funciones = funciones;
    }

}
