import { Advertencia } from "../Utilidades/Advertencia";
import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Instruccion } from "./Instruccion";

export class DeclararVariable implements Instruccion {
    
    ejecutar(tabla: TablaSimbolos, listadoErrores:Array<Advertencia>, ast: AST) {
        throw new Error("Method not implemented.");
    }

    traducir(tabla: TablaSimbolos, ast: AST) {
        throw new Error("Method not implemented.");
    }
    
}
