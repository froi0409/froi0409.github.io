import { Advertencia } from "../Utilidades/Advertencia";
import { AST } from "../Utilidades/AST";
import { TablaSimbolos } from "../Utilidades/TablaDeSimbolos";
import { Instruccion } from "./Instruccion";

//Clase que nos permite manejar la instruccion Print
export class Print implements Instruccion {
    
    contexto: Instruccion;
    nombre: string;

    //Atributos de la instruccion Print
    impresion:string; //Texto que se va a imprimir en la consola
    endl:boolean; //Si tiene valor true si se usa println, de lo contrario debe tener false
    
    constructor(impresion:string, contexto:Instruccion, endl:boolean) {
        this.impresion = impresion;
        this.endl = endl;
        this.nombre = '';
        this.contexto = contexto;
        console.log('Valor a Imprimir: ' + this.impresion);
    }
    
    ejecutarAnalisisSemantico(tabla: TablaSimbolos, listadoErrores: Advertencia[]) {
        throw new Error("Method not implemented.");
    }
    ejecutarFuncionalidad() {
        throw new Error("Method not implemented.");
    }
    
    //Ejecuta la instrucción de impresión
    ejecutar(tabla: TablaSimbolos, listadoErrores: Advertencia[], ast: AST) {
        const consola = document.getElementById('consola') as HTMLTextAreaElement; //Obtenemos el textarea que se está usando como salida
        
        consola.value += this.impresion; //Agregamos a la salida el texto que se desea imprimir
        if(this.endl) { //Si se usó println, imprime un salto de linea
            consola.value += '\n';
        }
    
    }

    //Traduce a código 3D
    traducir(tabla: TablaSimbolos, ast: AST) {
        throw new Error("Method not implemented.");
    }

}
