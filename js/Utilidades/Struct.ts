export class Struct {
    private nombre:string;
    //Variables pertenecientes al struct
    
    private linea:number; //Número de linea del struct
    private columna:number; //Número de columna del struct

    constructor(nombre:string, linea:number, columna:number) {
        this.nombre = nombre;
        this.linea = linea;
        this.columna = columna;
    }

    //getters y setters
    getNombre():string {
        return this.nombre;
    }
    getLinea():number {
        return this.linea;
    }
    getColumna():number {
        return this.columna;
    }
}
