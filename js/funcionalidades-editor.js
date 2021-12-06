var entrada = "";
var entInput = document.getElementById('entrada');

//Funcion que permite definir la posicion del cursor
function actualizarPosicion() {
    var txtEntrada = document.getElementById('entrada');
    var textLines = txtEntrada.value.substr(0, txtEntrada.selectionStart).split("\n");
    var currentLine = textLines.length;
    var currentColumn = textLines[textLines.length-1].length + 1;
    var texto = 'Linea: ' + currentLine + " - Columna: " + currentColumn;
    document.getElementById('label-posicion').innerHTML = texto;
}

entInput.addEventListener('change', function() {
    var fr;
    fr = null;
    fr  = new FileReader();
    
    fr.readAsText(this.files[0], 'ISO-8859-1');  
    this.files = null;
    
    fr.onload = function(){
        //document.getElementById('texto')
         //       .textContent = fr.result;
        
        entrada = fr.result;
        //alert(entrada);        
        checkNum(entrada);
        
        entInput.innerHTML = entrada.normalize('NFD').replace(/[\u0300-\u036f]/g, "");
    }
    
})
  
  
function checkNum(text) {
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
    document.getElementById("entrada-lineas").innerHTML = newLineCount;
}
