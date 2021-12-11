//Clase que nos permite manejar el error
export class Advertencia {

    //Atributos de los errores
    linea:number; //Linea donde se encontró el error
    columna:number; //Columna donde se encontró el error
    tipo:string; //Tipo de Error: lexico, sintactico o semantico
    descripcion:string; //Descripcion del error

    constructor(linea:number, columna:number, tipo:string, descripcion:string) {
        this.linea = linea;
        this.columna = columna;
        this.tipo = tipo;
        this.descripcion = descripcion;
    }

    //Devuelve un string que contiene la descripción del error completo
    //(Recomendado para usar en consola)
    getAdvertenciaCompleta() {
        let advert = 'Error (' + this.linea + ',' + this.columna + ') -' + this.tipo + '-: ' + this.descripcion;
        return advert;
    }


}