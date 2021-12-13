/*Parser*/

%{
    var listaErroresParser = [];

    function addError(type, lexem, first_line, first_column) {
       var auxError = 'Error '+type+' Token: '+ lexem + ' Linea: '+first_line + ' Columna: ' +first_column +'\n';
       console.log(auxError);
       listaErroresParser.push(auxError); 
    }
    function addError(auxError) {
        listaErroresParser.push(auxError + '\n'); 
    }
    function getErrorList(){
        return listaErroresParser;
    }
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
"(" { console.log('PAREN_INICIO');              }
")" { console.log('PAREN_FIN');                }
"{" { console.log('LLAVE_INICIO');             }
"}" { console.log('LLAVE_FIN');                }
"[" { console.log('CORCH_INICIO');             }
"]" { console.log('CORCH_FIN');                }
";" { console.log('PUNTO_COMA');               }
":" { console.log('DOS_PUNTOS');               }
"," { console.log('COMA');                     }
"." { console.log('PUNTO');                    }
"?" { console.log('SIGNO_INTERROGACION_CIERRE'); }
//"$" { console.log('DOLLAR');                   }
"#" { console.log('GATO');                     }

//tipos
"null"    { console.log('NULL');   }
"int"     { console.log('INT');    }
"double"  { console.log('DOUBLE'); }
"float"   { console.log('FLOAT');  }
"boolean" { console.log('BOOLEAN');}
"char"    { console.log('CHAR');   }
"String"  { console.log('STRING'); }

//estructuras
"struct" { console.log('STRUCT');}

/////EXPRESIONES
//incrementos
"++"    { console.log('INCREMENTO');     }
"--"    { console.log('DECREMENTO');     }
//aritmeticas
"+"     { console.log('SUMA');           }
"-"     { console.log('RESTA');          }
"*"     { console.log('MULTIPLICACION'); }
"/"     { console.log('DIV');            }
"%"     { console.log('MOD');            }
"pow"   { console.log('POW');            }
"sqrt"  { console.log('SQRT');           }
"log10" { console.log('LOG10');          }
"sin"   { console.log('SIN');            }
"cos"   { console.log('COS');            }
"tan"   { console.log('TAN');            }

//relacionales
"==" { console.log('IGUAL_IGUAL');    }
"!=" { console.log('DIFERENTE_IGUAL');}
">=" { console.log('MAYOR_IGUAL');    }
"<=" { console.log('MENOR_IGUAL');    }
">"  { console.log('MAYOR');          }
"<"  { console.log('MENOR');          }

//logicas
"&&" { console.log('AND');       }
"||" { console.log('OR');        }
"!"  { console.log('NOT');       }

///////cadenas
//concatenaciones
"&"	 { console.log('CONCAT_AND');}
"^"  { console.log('CONCAT_POW');}

//accesos
"caracterOfPosition" { console.log('CARACTEROFPOSITION');}
"subString"          { console.log('SUBSTRING');         }
"length"             { console.log('LENGTH');            }
"toUppercase"        { console.log('TOUPPERCASE');       }
"toLowercase"        { console.log('TOLOWERCASE');       }

//impresion
"print"   { console.log('PRINT');   }
"println" { console.log('PRINTLN'); }

//Declaraciones y asignaciones
"="  { console.log('IGUAL');   }

//////Funciones nativas
"parse"    { console.log('PARSE');       }
"toInt"    { console.log('TOINT');       }
"toDouble" { console.log('TODOUBLE');    }
"string"   { console.log('STRING_PARSE');}
"typeof"   { console.log('TYPEOF');      }

/**
"+=" { console.log('O_MAS');  }
"-=" { console.log('O_MENOS');}
"/=" { console.log('O_DIV');  }
"*=" { console.log('O_POR');  }
"%=" { console.log('O_MOD');  }
"^=" { console.log('O_POW');  }
*/

//Funciones
"return" { console.log('RETURN');}
"void"   { console.log('VOID'); }
"main"   { console.log('MAIN');}

///////condiciones
//if
"if"   { console.log('IF');   }
"else if" { console.log('ELSE_IF'); }
"else" { console.log('ELSE'); }
//switch
"switch"  { console.log('SWITCH');  }
"case"    { console.log('CASE');    }
"break"   { console.log('BREAK');   }
"default" { console.log('DEFAULT'); }

//loops
"while" { console.log('WHILE'); }
"do"    { console.log('DO');    }
"for"   { console.log('FOR');   }
//"it"    { console.log('IT');    }
"in"    { console.log('IN');    }

//Declaraciones de ciclos
//"break"  { console.log('BREAK');    }
"continue" { console.log('CONTINUE'); }

//Arreglos
"begin" { console.log('BEGIN');}
"end"   { console.log('END');  }

//funciones nativas de arreglos
"push" { console.log('PUSH');}
"pop"  { console.log('POP'); }

//valores
\"[^\"]*\"  {  
                yytext = yytext.substr(1,yyleng-2); 
                console.log('STRING_VALUE');
            }             
\'[^\']\'   { 
                yytext = yytext.substr(1,yyleng-2); 
                console.log('CHAR_VALUE');
            }
[0-9]+("."[0-9]+)\b               { console.log('DECIMAL_VALUE');           }
[0-9]+\b                          { console.log('ENTERO_VALUE');            }
"true"|"false"                    { console.log('BOOLEAN_VALUE'), yytext;   }
[aA-zZ|"_"]([aA-zZ]|[0-9]|"_")*   { console.log('IDENTIFICADOR'); }


<<EOF>> return 'EOF';
//.+   {  addError("Lexico", yytext, yylloc.first_line, yylloc.first_column + 1); }					
//[^\s]*     addError("Lexico", yytext, yylloc.first_line, yylloc.first_column + 1)  
[^\s]*     console.log("Lexico", yytext, yylloc.first_line, yylloc.first_column + 1)  

/lex
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
    : EOF {/*return reversaArreglo($1);*/}
    ;
