import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Tipo } from "./Tipo";

export interface Expresion {
    linea:number;
    columna:number;

    getTipo(simbolos:TablaSimbolos, arbol:AST):Tipo;
    getValorImplicito(simbolos:TablaSimbolos, arbol:AST):any;
    traducir(simbolos:TablaSimbolos, arbol:AST):any;
}