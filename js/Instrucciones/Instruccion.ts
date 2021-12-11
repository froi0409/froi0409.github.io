import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { AST } from "../Utilidades/AST";

//Interfaz que demuestra la base de todas las instrucciones
export interface Instruccion {

    //Nos permite ejecutar la respectiva instruccion
    ejecutar(tabla:TablaSimbolos, ast:AST): any;
    //Nos permite traducir la respectiva instruccion
    traducir(tabla:TablaSimbolos, ast:AST): any;

}