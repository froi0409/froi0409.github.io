import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Instruccion } from "./Instruccion";
import { Advertencia } from "../Utilidades/Advertencia";

export class AsignacionDeValor implements Instruccion {
    
    ejecutar(tabla: TablaSimbolos, listadoErrores:Array<Advertencia>, ast: AST) {
        throw new Error("Method not implemented.");
    }
    
    traducir(tabla: TablaSimbolos, ast: AST) {
        throw new Error("Method not implemented.");
    }

}
