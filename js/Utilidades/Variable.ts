
/**
 * Clase que nos permite manejar una variable como un objeto
 */
export class Variable {
    tipo:string;
    nombre:string;
    valor:Object;

    constructor(tipo:string, nombre:string, valor:Object) {
        this.tipo = tipo;
        this.nombre = nombre;
        this.valor = valor;
    }

}