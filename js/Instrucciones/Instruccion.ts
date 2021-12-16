import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { AST } from "../Utilidades/AST";
import { Advertencia } from "../Utilidades/Advertencia";


//Interfaz que demuestra la base de todas las instrucciones
export interface Instruccion {

    contexto:Instruccion;
    nombre:string;

    //Nos permite ejecutar la respectiva instruccion
    ejecutarAnalisisSemantico(tabla:TablaSimbolos, listadoErrores:Array<Advertencia>): any;

    ejecutarFuncionalidad():any;

    //Nos permite traducir la respectiva instruccion
    traducir(tabla:TablaSimbolos, ast:AST): any;

}
