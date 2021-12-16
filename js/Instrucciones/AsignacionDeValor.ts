import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Instruccion } from "./Instruccion";
import { Advertencia } from "../Utilidades/Advertencia";

export class AsignacionDeValor implements Instruccion {
    contexto: Instruccion;
    nombre: string;
    ejecutarAnalisisSemantico(tabla: TablaSimbolos, listadoErrores: Advertencia[]) {
        throw new Error("Method not implemented.");
    }
    ejecutarFuncionalidad() {
        throw new Error("Method not implemented.");
    }
    
    ejecutar(tabla: TablaSimbolos, listadoErrores:Array<Advertencia>, ast: AST) {
        throw new Error("Method not implemented.");
    }
    
    traducir(tabla: TablaSimbolos, ast: AST) {
        throw new Error("Method not implemented.");
    }

}
