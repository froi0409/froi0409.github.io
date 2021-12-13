import {Simbolo} from './Simbolo';

//Clase que nos servira para gestionar la tabla de simbolos
export class TablaSimbolos {

    //Atributos de la Tabla de Simbolos
    /*
    tabla: Es la tabla de simbolos como tal
    size: Es el tamaño de la tabla de simbolos
    */ 
    private tabla:Simbolo[] = [];
    private size:number = 0;

    constructor() {

    }

    //Nos permite insertar un simbolo nuevo a la tabla    
    insertSymbol(simbolo:Simbolo) {
        this.tabla[this.size] = simbolo;
        this.size++;
    }

    getTabla():Simbolo[] {
        return this.tabla;
    }

    getSize():number {
        return this.size;
    }

}