import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Expresion } from "./Expresion";
import { Tipo } from "./Tipo";

export class Primitivo implements Expresion {
    linea: number;
    columna: number;
    valor:any;

    constructor(valor:any, linea:number, columna:number) {
        this.linea = linea;
        this.columna = columna;
        this.valor = valor;
    }

    getTipo(simbolos: TablaSimbolos, arbol: AST): Tipo {
        throw new Error("Method not implemented.");
    }
    getValorImplicito(simbolos: TablaSimbolos, arbol: AST) {
        throw new Error("Method not implemented.");
    }
    traducir(simbolos: TablaSimbolos, arbol: AST) {
        throw new Error("Method not implemented.");
    }

}