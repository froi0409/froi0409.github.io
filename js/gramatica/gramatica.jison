/*Parser*/

%{
    var listaErroresParser = [];

    function addError(type, lexem, first_line, first_column) {
       var auxError = 'Error '+type+' Token: '+ lexem + ' Linea: '+first_line + ' Columna: ' +first_column +'\n';
       listaErroresParser.push(auxError); 
    }
    function addError(auxError) {
        listaErroresParser.push(auxError + '\n'); 
    }
    function getErrorList(){
        return listaErroresParser;
    }
    exports.listaErroresParser = getErrorList();
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

//estructuras
"struct" { return 'STRUCT'; }

/////EXPRESIONES
//incrementos
"++"    { return 'INCREMENTO';   }
"--"    { return 'DECREMENTO';   }
//aritmeticas
"+"     { return 'SIGNO_MAS';    }
"-"     { return 'SIGNO_MIN';    }
"*"     { return 'SIGNO_POR';    }
"/"     { return 'SIGNO_DIV';    }
"%"     { return 'MOD';          }
"pow"   { return 'POW';          }
"sqrt"  { return 'SQRT';         }
"log10" { return 'LOG10';        }
"sin"   { return 'SIN';          }
"cos"   { return 'COS';          }
"tan"   { return 'TAN';          }

//relacionales
"==" { return 'IGUAL_IGUAL';     }
"!=" { return 'DIFERENTE_IGUAL'; }
">=" { return 'MAYOR_IGUAL';     }
"<=" { return 'MENOR_IGUAL';     }
">"  { return 'MAYOR';           }
"<"  { return 'MENOR';           }

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

//Funciones
"return" { return 'RETURN'; }
"void"   { return 'VOID';  }
"main"   { return 'MAIN'; }

///////condiciones
//if
"if"   { return 'IF';    }
"else if" { return 'ELSE_IF'; }
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
\"[^\"]*\"  { 
                yytext = yytext.substr(1,yyleng-2); 
                return 'STRING_VALUE'; 
            }             
\'[^\']\'   { 
                yytext = yytext.substr(1,yyleng-2); 
                return 'CHAR_VALUE';
            }
[0-9]+("."[0-9]+)\b               { return 'DECIMAL_VALUE'; }
[0-9]+\b                          { return 'ENTERO_VALUE';  }
"true"|"false"                    { return 'BOOLEAN_VALUE'; }
[aA-zZ|"_"]([aA-zZ]|[0-9]|"_")*   { return 'IDENTIFICADOR'; }

<<EOF>> return 'EOF';
//.+   {  addError("Lexico", yytext, yylloc.first_line, yylloc.first_column + 1); }					
[^\s]*     addError("Lexico", yytext, yylloc.first_line, yylloc.first_column + 1)      


/lex
%{
    function linea(linea){
        return linea + lineNumber;
    }
    function columna(column){
        return column + columnNumber;
    }
%}    
    %left 'ELSE';
    %left 'ELSE_IF';
    %left 'OR'
    %left 'AND'    
    %left 'MAYOR_IGUAL' 'MENOR_IGUAL' 'DIFERENTE_IGUAL' 'IGUAL_IGUAL' 'MAYOR' 'MENOR' 'IGUAL'
    %left 'NOT'
    %left 'SIGNO_MAS' 'SIGNO_MIN'
    %left 'SIGNO_POR' 'SIGNO_DIV' 'MOD'
    %left 'POW' 'SIN' 'COS' 'TAN' 'LOG10'
    %left 'UMINUS'
    %left 'PAREN_INICIO' 'PAREN_FIN'        

%start init

%% 
/*Definicion de la gramatica*/

init
    : instrucciones_globales_block EOF {/*return reversaArreglo($1);*/}
    ;

instrucciones_globales_block : 
      instrucciones_globales_block instrucciones_globales_unit //bloque de instrucciones globales
    |  //epsilon
    ;

//De manera global solo se pueden declarar funciones, struct y variables
instrucciones_globales_unit :
      instrucciones_variables_declaracion PUNTO_COMA
    | declarar_funciones //normales y main
    | declarar_struct PUNTO_COMA
    ;

//struct
declarar_struct : 
    STRUCT IDENTIFICADOR            //struct nombreStruct
    LLAVE_INICIO                    //{
        declarar_struct_variables   // int a;
    LLAVE_FIN                       //}
    ;

//Los struct solo pueden tener declaracion de variables
declarar_struct_variables : 
        declarar_struct_variables 
        instrucciones_variables_declaracion PUNTO_COMA //int a;
    | //epsilon
    ;

//Conjunto de instrucciones generales, es decir instrucciones ejecutables dentro de las funciones, loops, etc
//El conjunto de instrucciones se empaqueta entre llaves
instrucciones_block : LLAVE_INICIO instrucciones_unidad_varios LLAVE_FIN //si vienen varios se agregan entre llaves {}
    | instrucciones_unidad //si viene una sola, entonces no se necesitan llaves
    ;

//conjunto de instrucciones unitarias
instrucciones_unidad_varios : instrucciones_unidad_varios instrucciones_unidad 
    | //epsilon
    ;
//instruccion general unitaria
instrucciones_unidad : 
      instrucciones_sentencia_control_ifs
    | instrucciones_sentencia_control_switch
    | instrucciones_loops_while
    | instrucciones_loops_do_while
    | instrucciones_loops_for
    | instrucciones_variables_declaracion PUNTO_COMA
    | instrucciones_variables_asignacion PUNTO_COMA
    | instrucciones_print PUNTO_COMA
    ;
//#IF
//instrucciones sentencia de control, IF
instrucciones_sentencia_control_ifs : 
        instrucciones_sentencia_control_ifs_if              //if
        instrucciones_sentencia_control_ifs_else_if_block   //else if
        instrucciones_sentencia_control_ifs_else            //else
    ;
    //if
instrucciones_sentencia_control_ifs_if : 
        IF condicion // if (condicion)
        instrucciones_block                 //bloque de instrucciones
    ;
instrucciones_sentencia_control_ifs_else_if_block:  
      instrucciones_sentencia_control_ifs_else_if_block 
      instrucciones_sentencia_control_ifs_else_if //por si vienen varios else if
    | //epsilon, por si no viene ninguno
    ;
    //else if
instrucciones_sentencia_control_ifs_else_if: 
        ELSE_IF condicion // else if (condicion)
        instrucciones_block                      //bloque de instrucciones
    ;
    //else
instrucciones_sentencia_control_ifs_else: 
        ELSE                //else
        instrucciones_block //bloque de instrucciones
    | //epsilon, cuando no viene else
    ;

//#SWITCH
//Instrucciones sentencia SWITCH, el identificador es el nombre de alguna variable
instrucciones_sentencia_control_switch : 
        SWITCH PAREN_INICIO IDENTIFICADOR PAREN_FIN         // switch (variable)
            instrucciones_sentencia_control_switch_cuerpo   // {cuerpo}
    ;
    //se empaqueta el conjunto de case/switch entre llaves
instrucciones_sentencia_control_switch_cuerpo : 
        LLAVE_INICIO                                                     //{
            instrucciones_sentencia_control_switch_cuerpo_case_varios    // varios case.....
        LLAVE_FIN                                                        //}
    ;
    //conjunto de case
instrucciones_sentencia_control_switch_cuerpo_case_varios : 
        instrucciones_sentencia_control_switch_cuerpo_case_varios //bloque de cases
        instrucciones_sentencia_control_switch_cuerpo_case          //case....
    //| instrucciones_sentencia_control_switch_cuerpo_case //case unico
    | //ningun case
    ;
    //un case
instrucciones_sentencia_control_switch_cuerpo_case : 
        CASE valores_datos_primarios DOS_PUNTOS                       //case 2:        --> puede venir int, char, String, boolean, float, double
            instrucciones_unidad_varios                              //instrucciones
            instrucciones_sentencia_control_switch_cuerpo_case_break //break;         --> no es obligatorio
        PUNTO_COMA                                                   //;
    |   DEFAULT DOS_PUNTOS                                              //default :
            instrucciones_unidad_varios                                 //instrucciones
            instrucciones_sentencia_control_switch_cuerpo_case_break    //break;        --> no es obligatorio
        PUNTO_COMA                                                      //;
    ;
instrucciones_sentencia_control_switch_cuerpo_case_break : BREAK PUNTO_COMA //break ;
    | //epsilon
    ;

//#WHILE
//LOOP WHILE
instrucciones_loops_while : 
        WHILE condicion     //while (condicion)
        instrucciones_block //{ instrucciones varias }
    ;

//#DO WHILE
//LOOP DO WHILE
instrucciones_loops_do_while :
        DO                          //do
        instrucciones_block         //{ instrucciones varias }
        WHILE condicion PUNTO_COMA  //while ;
    ;

//#FOR
//LOOP FOR
instrucciones_loops_for :
        FOR PAREN_INICIO 
                instrucciones_variables_asignacion PUNTO_COMA //inicio: Declaracion o asignacion valor variable             $ for (int i = 0; i < 10; i++)
                operacion_general PUNTO_COMA                  //fin:    condicion --> debe de retornar un valor boolean     $ { 
                instrucciones_for                             //instrucciones permitas a los for                            $    instrucciones varias 
            PAREN_FIN                                         //                                                            $ }
        instrucciones_block
    ;
    //los for tienen pocas acciones permitidas dentro de la ultima fase de la declaracion
instrucciones_for :
        instrucciones_variables_asignacion //asignar un nuevo valor a alguna variable
    |   instrucciones_print                //print
        /////////////INCREMENTO Y DECREMENTO
    | valores_datos INCREMENTO
    | valores_datos DECREMENTO
    ;

//son los tipos de las variables primitivos junto a tipos mas complejos
tipo_datos_arreglo : tipo_datos_primarios CORCH_INICIO CORCH_FIN //int[]
    ;
    //son los tipos de las variables primitivos, int, char, String, boolean, float, double
tipo_datos_primarios :
      INT
    | DOUBLE
    | BOOLEAN
    | CHAR
    | STRING
    ;

//#Print
instrucciones_print : //seguramente haya un cambio de operacion_general a operaciones que retornen String unicamente
        print PAREN_INICIO instrucciones_print_valores PAREN_FIN
    |   println PAREN_INICIO instrucciones_print_valores PAREN_FIN
    ;
    //Conjunto de valores a imprimir por el print
instrucciones_print_valores :
        instrucciones_print_valores //Texto1
        COMA                        // ,
        operacion_general           //TEXTO2
    |   operacion_general   //TextoX
    //|   //epsilon
    ;

//valores
    //se seoari dek valores_datos porque GATO variable no puede efectuar un incremento
valores_datos_arreglos :
        GATO nombres_variables_unidad // #nombreVariable  --> se usa para copiar los valores de un arreglo
    ;
    //valores de variables incluidos
valores_datos :
        nombres_variables_unidad      // nombreVariable
    |   nombres_variables_unidad GATO // nombreVariable#  --> se usa para efectuar operaciones sobre todos los valores del arreglo
    //|   valores_datos_primarios       // Valores primitivos
    //| nombres_variables_unidad PAREN_INICIO operacion_general PAREN_FIN //Para arrays en la posicion [a] donde a es una operacion aritmetica con resultado entero
    //| CORCH_INI bloque_valores_operacion_general CORCH_FIN
    ;
    //valores ordinarios
valores_datos_primarios : 
      ENTERO_VALUE
	| DECIMAL_VALUE
	| BOOLEAN_VALUE
	| CHAR_VALUE
	//| parametro_valor_name 
	//| nombres_variables_unidad
	//| funciones_con_valor
	;
nombres_variables_unidad : IDENTIFICADOR //nombreVariable
    //| GATO IDENTIFICADOR                 //#nombreVariable, para arreglos copiados por valores
    ;

//CONDICION Retorna true or false
condicion :
        PAREN_INICIO operacion_general PAREN_FIN
    ;

operacion_general ::= 
	/////////////OPERACIONES LOGICAS
	  operacion_general AND  operacion_general 
    | operacion_general OR   operacion_general 
    | NOT operacion_general 
    /////////////OPERACIONES RELACIONALES
    | operacion_general MAYOR           operacion_general 
    | operacion_general MENOR           operacion_general
    | operacion_general MAYOR_IGUAL     operacion_general 
    | operacion_general MENOR_IGUAL     operacion_general 
    | operacion_general DIFERENTE_IGUAL operacion_general 
    | operacion_general IGUAL_IGUAL     operacion_general 
	/////////////OPERACIONES ARITMETICAS
	| operacion_general SIGNO_MAS operacion_general
    | operacion_general SIGNO_MIN operacion_general
    | operacion_general SIGNO_POR operacion_general
    | operacion_general SIGNO_DIV operacion_general
    /////////////OPERACIONES NATIVAS
    | operacion_general MOD   operacion_general
    | operacion_general POW   operacion_general
    | operacion_general SQRT  operacion_general
    | operacion_general LOG10 operacion_general
    | operacion_general SIN   operacion_general
    | operacion_general COS   operacion_general
    | operacion_general TAN   operacion_general
    /////////////VALORES
    | valores_datos //variables y valores primitivos
    | valores_datos_primarios //valores primitivos
    | valores_datos_arreglos //Aca se debe de realizar una comparacion posterior, ya que solo sirve para asignacion de valor a otro array
	| SIGNO_MIN operacion_general %prec UMINUS
	| PAREN_INICIO operacion_general PAREN_FIN 
    ;

//por definir
//instrucciones_variables_declaracion
//instrucciones_variables_asignacion




