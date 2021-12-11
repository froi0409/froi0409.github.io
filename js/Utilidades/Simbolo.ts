//Clase que nos permite manejar un simbolo
export class Simbolo {

    //Atributos del simbolo
    identificador:string;
    valor:any;
    tipo:string;
    contexto:string = 'ninguno';
    
    //Atributos del contexto del simbolo
    /*
    tipoContexto: G-Global, M-Main, F-Funcion, S-Sentencia, C-Ciclo
    nombreContexto: nombre de la funcion contexto
    idContexto: G-1, M-2, S-[3, infinito), C-[3, infinito)
    */
    tipoContexto:string;
    nombreContexto:string;
    idContexto:string;

    linea:number;
    columna:number;

    //Inicializa los valores fundamentales de un simbolo
    constructor(identificador:string, tipo:string, valor:any, linea:number, columna:number) {
        this.identificador = identificador;
        this.tipo = tipo;
        this.valor = valor;
        
        this.tipoContexto = '';
        this.nombreContexto = '';
        this.idContexto = '';

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

    //Setters y Getters de Contexto
    setTipoContexto(tipoContexto:string) {
        this.tipoContexto = tipoContexto;
    }
    getTipoContexto() {
        return this.tipoContexto;
    }

    setNombreContexto(nombreContexto:string) {
        this.nombreContexto = nombreContexto;
    }
    getNombreContexto() {
        this.nombreContexto;
    }

    setIdContexto(idContexto:string) {
        this.idContexto = idContexto;
    }
    getIdContexto() {
        return this.idContexto;
    }

}