
//Funcion que permite definir la posicion del cursor
function actualizarPosicion() {
    var txtEntrada = document.getElementById('entrada');
    var textLines = txtEntrada.value.substr(0, txtEntrada.selectionStart).split("\n");
    var currentLine = textLines.length;
    var currentColumn = textLines[textLines.length-1].length + 1;
    var texto = 'Linea: ' + currentLine + " - Columna: " + currentColumn;
    document.getElementById('label-posicion').innerHTML = texto;
}