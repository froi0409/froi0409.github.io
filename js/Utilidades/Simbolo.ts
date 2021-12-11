//Clase que nos permite manejar un simbolo
export class Simbolo {

    //Atributos del simbolo
    identificador:string;
    valor:any;
    tipo:string;
    contexto:string = 'ninguno';
    linea:number;
    columna:number;

    //Inicializa los valores fundamentales de un simbolo
    constructor(identificador:string, tipo:string, valor:any, linea:number, columna:number) {
        this.identificador = identificador;
        this.tipo = tipo;
        this.valor = valor;
        this.linea = linea;
        this.columna = columna;
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