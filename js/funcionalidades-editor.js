var entrada = "";
var entradaText = document.getElementById('entrada');
var salidaText = document.getElementById('salida');

function checkNumEntrada(){
    checkNum(entradaText.value, 'entrada');
}

function checkNumSalida(){
    checkNum(salidaText.value, 'salida');
}

function checkNum(text, bloque) {
    //Now check
    text = text  + '';
    var lines = text.split(/\r|\r\n|\n/);
    var count = lines.length;
    //console.log("linea: "+count);
    
    
    var newLineCount = "";
    
    for(var i = 1; i <= count; i++){
        newLineCount += i;
        if(i != count){
            //salto de linea si no es el ultimo
            newLineCount += '\n';
        }
        
    }
    
    newLineCount.trim();
    //alert(newLineCount);
    
    //cambiamos el contador
    document.getElementById(bloque+'-lineas').innerHTML = newLineCount;
}
