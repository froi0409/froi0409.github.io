/*Parser*/

%{
    /*
    //import
    var ErrorLexico = require('../../../error/LexicalError.js');
    var ErrorSintactico = require('../../../error/SyntaxError.js');
    //Errores
    var erroresLexicos = [];
    var erroresSintacticos = [];
    //Lineas extras
    var lineNumber = 0;
    var columnNumber=0;
    module.exports.setLineNumber = function(line){
        lineNumber = line;
    }
    module.exports.setColumnNumber = function(column){
        columnNumber=column;
    }
    module.exports.setErroresLexicos = function(errors){
        erroresLexicos = errors;
    }
    module.exports.setErroresSintacticos = function(errors){
        erroresSintacticos = errors;
    }
    function getLexicalErrors(){
        return lexicalErrorsArray;
    }
    function addLexicalError(lexema, linea, column){   
        try{
            var errorLexico = new ErrorLexico(lexema, linea, column);
            erroresLexicos.push(errorLexico);
        }catch(ex){
            console.log(ex);
        }                  
    }
    function addSyntaxError(descripcion, token, line, column){
		try{
			var errorSintactico = new ErrorSintactico(descripcion, token, line, column);
			erroresSintacticos.push(errorSintactico);
		}catch(ex){
			console.log(ex);
		}
	}*/
%}

%lex

commentary "//".*
block_commentary [/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]	
%%

//comentarios
\s+                                 /*ignore*/;
{commentary}          /*ignore*/;
{block_commentary} /*ignore*/;

//simbolos
"(" { return 'PAREN_INICIO';              }
")" { return 'PAREN_FIN';                 }
"{" { return 'LLAVE_INICIO';              }
"}" { return 'LLAVE_FIN';                 }
"[" { return 'CORCH_INICIO';              }
"]" { return 'CORCH_FIN';                 }
";" { return 'PUNTO_COMA';                }
":" { return 'DOS_PUNTOS';                }
"," { return 'COMA';                      }
"." { return 'PUNTO';                     }
"?" { return 'SIGNO_INTERROGACION_CIERRE' }
//"$" { return 'DOLLAR';                    }
"#" { return 'GATO';                      }

//tipos
"null"    { return 'NULL';    }
"int"     { return 'INT';     }
"double"  { return 'DOUBLE';  }
"float"   { return 'FLOAT';   }
"boolean" { return 'BOOLEAN'; }
"char"    { return 'CHAR';    }
"String"  { return 'STRING';  }
"true"    { return 'TRUE';    }
"false"   { return 'FALSE';   }

//estructuras
"struct" { return 'STRUCT'; }

/////EXPRESIONES
//aritmeticas
"+"     { return 'SUMA';            }
"-"     { return 'RESTA';           }
"*"     { return 'MULTIPLICACION';  }
"/"     { return 'DIV';             }
"%"     { return 'MOD';             }
"pow"   { return 'POW';             }
"sqrt"  { return 'SQRT';            }
"log10" { return 'LOG10';           }
"sin"   { return 'SIN';             }
"cos"   { return 'COS';             }
"tan"   { return 'TAN';             }
//incrementos
"++"    { return 'INCREMENTO';      }
"--"    { return 'DECREMENTO';      }

//relacionales
"==" { return 'IGUAL_IGUAL';     }
"!=" { return 'DIFERENTE_IGUAL'; }
">"  { return 'MAYOR';           }
"<"  { return 'MENOR';           }
">=" { return 'MAYOR_IGUAL';     }
"<=" { return 'MENOR_IGUAL';     }

//logicas
"&&" { return 'AND';        }
"||" { return 'OR';         }
"!"  { return 'NOT';        }

///////cadenas
//concatenaciones
"&"	 { return 'CONCAT_AND'; }
"^"  { return 'CONCAT_POW'; }

//accesos
"caracterOfPosition" { return 'CARACTEROFPOSITION'; }
"subString"          { return 'SUBSTRING';          }
"length"             { return 'LENGTH';             }
"toUppercase"        { return 'TOUPPERCASE';        }
"toLowercase"        { return 'TOLOWERCASE';        }

//impresion
"print"   { return 'PRINT';    }
"println" { return 'PRINTLN';  }

//Declaraciones y asignaciones
"="  { return 'IGUAL';    }

//////Funciones nativas
"parse"    { return 'PARSE';        }
"toInt"    { return 'TOINT';        }
"toDouble" { return 'TODOUBLE';     }
"string"   { return 'STRING_PARSE'; }
"typeof"   { return 'TYPEOF';       }

/**
"+=" { return 'O_MAS';   }
"-=" { return 'O_MENOS'; }
"/=" { return 'O_DIV';   }
"*=" { return 'O_POR';   }
"%=" { return 'O_MOD';   }
"^=" { return 'O_POW';   }
*/

//Funciones
"return" { return 'RETURN'; }
"void"   { return 'VOID';  }

///////condiciones
//if
"if"   { return 'IF';    }
"else" { return 'ELSE';  }
//switch
"switch"  { return 'SWITCH';   }
"case"    { return 'CASE';     }
"break"   { return 'BREAK';    }
"default" { return 'DEFAULT';  }

//loops
"while" { return 'WHILE';  }
"do"    { return 'DO';     }
"for"   { return 'FOR';    }
//"it"    { return 'IT';     }
"in"    { return 'IN';     }

//Declaraciones de ciclos
//"break"  { return 'BREAK';     }
"continue" { return 'CONTINUE';  }

//Arreglos
"begin" { return 'BEGIN'; }
"end"   { return 'END';   }

//funciones nativas de arreglos
"push" { return 'PUSH'; }
"pop"  { return 'POP';  }

//valores
\"[^\"]*\"  { yytext = yytext.substr(1,yyleng-2); 
                return 'STRING_VALUE'; 
            }             
\'[^\']\'   { yytext = yytext.substr(1,yyleng-2); 
                return 'CHAR_VALUE';
            }
[0-9]+("."[0-9]+)\b 
            { 
                return 'DECIMAL_VALUE';  
            }
[0-9]+\b 
            { 
                return 'ENTERO_VALUE';  
            }
[aA-zZ|"_"]([aA-zZ]|[0-9]|"_")* 
            { 
                return 'IDENTIFICADOR';  
            }

<<EOF>> return 'EOF';
.+   { addLexicalError(yytext, linea(yylloc.first_line), columna(yylloc.first_column));}					


/lex
%{
    function linea(linea){
        return linea + lineNumber;
    }
    function columna(column){
        return column + columnNumber;
    }
%}    
    %left 'OR'
    %left 'AND'    
    %left 'MAYOR_IGUAL' 'MENOR_IGUAL' 'DIFERENTE_IGUAL' 'IGUAL_IGUAL' 'MAYOR' 'MENOR' 'IGUAL'
    %left 'NOT'
    %left 'SUMA' 'RESTA'
    %left 'MULTIPLICACION' 'DIV' 'MOD'
    %left 'POW' 'SIN' 'COS' 'TAN' 'LOG10'
    %left 'UMINUS'
    %left 'PAREN_INICIO' 'PAREN_FIN'        

%start init

%% 
/*Definicion de la gramatica*/

init
    : ini EOF {/*return reversaArreglo($1);*/}
    ;
