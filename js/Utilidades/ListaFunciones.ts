import { Advertencia } from "./Advertencia";
import { Funcion } from "./Funcion"
import { TablaSimbolos } from "./TablaDeSimbolos";

/**
 * Clase que n os permite manejar las funciones de manera personalizada
 */
export class ListaFunciones {
    funciones:Array<Funcion>; //Listado de Funciones que tendrá el programa
    tablaDeSimbolos:TablaSimbolos;
    errores:Array<Advertencia>; //Listado de errores del programa
    size:number; //Tamaño del listado

    constructor(tablaDeSimbolos:TablaSimbolos, errores:Array<Advertencia>) {
        this.funciones = [];
        this.tablaDeSimbolos = tablaDeSimbolos;
        this.errores = errores;
        this.size = 0;
    }

    /**
     * Verifica si existe la funcion Main
     * @returns true si existe el funcion main, false si no existe el funcion main
     */
     existsMain():boolean {
        let comprobante:boolean = false;
        this.funciones.forEach(function(value) {
            if(value.getNombre() == "main") {
                comprobante = true;
            }
        });
        if(!comprobante) {
            let descripcion:string = 'No existe un metodo main'
            this.errores.push(new Advertencia(0,0, 'Semantico', descripcion));
        }
        return comprobante;
    }   

    /**
     * Permite agregar una función y comprobar si ya existe una función con el nombre requerido
     */
    insertFunction(funcionA:Funcion) {
        let repetida:boolean = false;
        this.funciones.forEach(function(value) {
            if(value.getNombre() == funcionA.getNombre()) {//Si el nombre de la funcion ya existe, entonces se agrega el error a la tabla de simbolos
                repetida = true;
            }
        });

        if(repetida) { //Si la función está repetida, se agrega el error
            let descripcionError:string = 'La funcion ' + funcionA.getNombre() + ' ya se encuentra definida';
            let linea:number = funcionA.getLinea();
            let columna:number = funcionA.getColumna();
            this.errores.push(new Advertencia(linea, columna, 'Semantico', descripcionError));
        } else { //Si la función no está repetida, se agrega la función a la lista
            this.funciones.push(funcionA);
        }
    }

    /**
     * Para uso muy exclusivo de pruebas
     * @returns Array de Funciones puro con las funciones
     */
    getListadoPuro():Array<Funcion> {
        return this.funciones;
    }

}