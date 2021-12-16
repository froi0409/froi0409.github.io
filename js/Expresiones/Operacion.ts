import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Expresion } from "./Expresion";
import { Tipo } from "./Tipo";

export enum Operador {
    SUMA,
    RESTA,
    MULTIPLICACION,
    DIVISION,
    MODULO,
    POW,
    SQRT,
    LOG10,
    SIN,
    COS,
    TAN,
    MENOS_UNARIO,
    IGUAL_IGUAL,
    DIFERENTE_IGUAL,
    MAYOR_IGUAL,
    MENOR_IGUAL,
    MAYOR,
    MENOR,
    AND,
    OR,
    NOT,
    CONCAT_AND,
    CONCAT_POW,
    TERNARIO,
    UNKNOWN
}

export class Operacion implements Expresion {
    linea: number;
    columna: number;
    
    op_izquierda:Expresion;
    op_derecha:Expresion;
    operador:Operador;

    constructor(op_izquierda:Expresion, op_derecha:Expresion, operador:Operador, linea:number, columna:number) {
        this.op_izquierda = op_izquierda;
        this.op_derecha = op_derecha;
        this.operador = operador;
        this.linea = linea;
        this.columna = columna;
    }

    //Ejecutar
    getTipo(simbolos: TablaSimbolos, arbol: AST): Tipo {
        throw new Error("Method not implemented.");
    }
    getValorImplicito(simbolos: TablaSimbolos, arbol: AST) {
        throw new Error("Method not implemented.");
    }

    //Traducir
    traducir(simbolos: TablaSimbolos, arbol: AST) {
        throw new Error("Method not implemented.");
    }

}
