import { Advertencia } from "./Advertencia";
import { Struct } from "./Struct";

/**
 * Clase que nos permite manejar los Structs de manera personalizada
 */
export class ListaStructs {
    structs:Array<Struct>;
    errores:Array<Advertencia>
    size:number;

    constructor(structs:Array<Struct>, errores:Array<Advertencia>) {
        this.structs = structs;
        this.errores = errores;
        this.size = 0;
    }

    /**
     * Permite insertar un struct a la lista
     * @param structA Struct que se va a ingresar
     */
    insertStruct(structA:Struct) {
        let repetido:boolean = false;
        this.structs.forEach(function(value) {
            if(value.getNombre() == structA.getNombre()) { //Comprueba si el struct se encuentra ya en el listado de structs
                repetido = true;
            }
        });
        if(repetido) { //Si el struct está repetido, se agrega el error a la lista de errores
            let descripcionError:string = 'El struct ' + structA.getNombre() + ' ya se encuentra definido';
            let linea:number = structA.getLinea();
            let columna:number = structA.getColumna();
            this.errores.push(new Advertencia(linea, columna, 'Semantico', descripcionError));
        } else { //Si el struct no está repetido, se agrega a la lista de structs
            this.structs.push(structA);
        }
    }

}