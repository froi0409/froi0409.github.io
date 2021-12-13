/**
 * Clase que nos permite manejar la tabla de simbolos
 */
export class Simbolo {

    //Atributos del simbolo
    identificador:string; //Identificador del simbolo, puede ser el nombre de la variable, funcion, array, etc
    tipo:string; //Tipo de dato del simbolo: int, char, etc
    esArreglo:boolean; //Permite identificar si el simbolo es un arreglo o no
    longitud:number; //Permite identificar la longitud del arreglo (en el caso de ser necesario)
    contexto:Object; //Permite identificar el contexto en el que se encuentra el simbolo
    tipoSimbolo:string; //permite saber si el simbolo es una variable, funcion, etc
    posMemoria:number; //posicion en memoria del simbolo
    valor:Object; //Valor del simbolo

    linea:number; //Linea en la que se encuentra el simbolo
    columna:number; //Columna en la que se encuentra el simbolo

    contextoPadre:Object; //Contexto padre del objeto

    //Inicializa los valores fundamentales de un simbolo
    constructor(identificador:string, tipo:string, esArreglo:boolean, longitud:number, contexto:Object, tipoSimbolo:string, posMemoria:number, valor:Object, linea:number, columna:number) {
        this.identificador = identificador;
        this.tipo = tipo;
        this.esArreglo = esArreglo;
        this.longitud = longitud;
        this.contexto = contexto;
        this.tipoSimbolo = tipoSimbolo;
        this.posMemoria = posMemoria;
        this.valor = valor;
        this.linea = linea;
        this.columna = columna;
        this.contextoPadre = '-'; //Deberia iniciar siendo nulo
    }

    //Funcion que permite establecer un contexto para el simbolo. No está definido en el 
    //constructor para permitir variables sin contexto
    setContexto(contexto:string) {
        this.contexto = contexto;
    }

    //Obtenemos el tipo de simbolo
    getTipo() {
        return this.tipo;
    }

}