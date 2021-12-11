import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Instruccion } from "./Instruccion";

export class DeclararVariable implements Instruccion {
    
    ejecutar(tabla: TablaSimbolos, ast: AST) {
        throw new Error("Method not implemented.");
    }

    traducir(tabla: TablaSimbolos, ast: AST) {
        throw new Error("Method not implemented.");
    }
    
}
