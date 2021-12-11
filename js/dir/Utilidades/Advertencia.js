"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Advertencia = void 0;
//Clase que nos permite manejar el error
class Advertencia {
    constructor(linea, columna, tipo, descripcion) {
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
exports.Advertencia = Advertencia;
