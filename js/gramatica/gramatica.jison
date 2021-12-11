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
    //exports.listaErroresParser = getErrorList();
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
        return linea;
    }
    function columna(column){
        return column;
    }
%}    
    %left 'ELSE'
    %left 'ELSE_IF'
    %left 'SIGNO_INTERROGACION_CIERRE' 'DOS_PUNTOS'
    %left 'OR'
    %left 'AND'    
    %left 'NOT'
    %left 'MAYOR_IGUAL' 'MENOR_IGUAL' 'DIFERENTE_IGUAL' 'IGUAL_IGUAL' 'MAYOR' 'MENOR' 'IGUAL'
//    %left 'NOT'
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
    | instrucciones_funciones_declaracion //normales y main
    | declarar_struct PUNTO_COMA
    ;

//#DECLARAR FUNCIONES
instrucciones_funciones_declaracion : 
        instrucciones_funciones_declaracion_tipo_funciones   //Tipo funcion   --> void
        instrucciones_funciones_declaracion_nombre_funciones //Nombre funcion --> suma
        instrucciones_funciones_declaracion_parametros       //Parametros     --> (int num1, int num2)
        instrucciones_block                                  //Codigo         --> { codigo.......... }
    ;
    //Nombres de funciones
instrucciones_funciones_declaracion_nombre_funciones :
        nombres_variables_unidad //nombres cualquiera de funciones
    |   MAIN                     //Main, reservada para la funcion main
    ;
    //Contiene todos los parametros entre (), pueden tener o no parametros
instrucciones_funciones_declaracion_parametros :
        PAREN_INICIO instrucciones_funciones_declaracion_parametros_bloque PAREN_FIN
    |   PAREN_INICIO /*estas funciones no contienen parametros*/           PAREN_FIN
    ;
    //Contiene un bloque de tipo Nombre, tipo2 Nombre2, tipo3 Nombre3, ......., tipoN NombreN
instrucciones_funciones_declaracion_parametros_bloque : 
        instrucciones_funciones_declaracion_parametros_bloque   //Tipos y nonbres
        COMA                                                    //,
        instrucciones_funciones_declaracion_parametros_unidad          //Agregamos un ultimo dato
    |   instrucciones_funciones_declaracion_parametros_unidad  //Dato solitaria
    ;
    //unidad de tipoDato nombreVariable
instrucciones_funciones_declaracion_parametros_unidad :
        tipo_datos_generales  //los parametros, osea variables son de tipo ordinario o array
        IDENTIFICADOR         //Cada parametro/variable debe de tener un nombre identificador    
    ;
    //tipos de funciones, usan void de extra
instrucciones_funciones_declaracion_tipo_funciones :
      VOID                  //No retorna ningun tipo
    | tipo_datos_generales  //Puede retornar tipos de datos ordinarios y de tipo Array
    ;

//#STRUCT
declarar_struct : 
    STRUCT IDENTIFICADOR            //struct nombreStruct
    LLAVE_INICIO                    //{
        declarar_struct_variables   // int a;
    LLAVE_FIN                       //}
    ;

//Los struct solo pueden tener declaracion de variables
declarar_struct_variables : 
        instrucciones_funciones_declaracion_parametros_bloque COMA declarar_struct_variables //int a;
    |   instrucciones_funciones_declaracion_parametros_bloque    
    |   //epsilon
    /*
        instrucciones_variables_declaracion COMA declarar_struct_variables //int a;
    |   instrucciones_variables_declaracion    
    */
    //| //epsilon
    ;

//Conjunto de instrucciones generales, es decir instrucciones ejecutables dentro de las funciones, loops, etc
//El conjunto de instrucciones se empaqueta entre llaves
    //Conjunto de intrucciones para ifs, switch y funciones
instrucciones_block : 
      LLAVE_INICIO instrucciones_unidad_varios LLAVE_FIN //si vienen varios se agregan entre llaves {}
    | LLAVE_INICIO                             LLAVE_FIN //si no vienen instrucciones, se tienen que usar llaves
    | instrucciones_unidad //si viene una sola, entonces no se necesitan llaves
    ;
//conjunto de instrucciones unitarias
instrucciones_unidad_varios : instrucciones_unidad_varios instrucciones_unidad 
    | instrucciones_unidad
    //| //epsilon
    ;
//instruccion general unitaria
instrucciones_unidad : 
      instrucciones_funciones_llamada PUNTO_COMA        //Comienza con nombreFuncion (es un IDENTIFICADOR) (conjunto de parametros)
    | instrucciones_sentencia_control_ifs               //Comienza con if
    | instrucciones_sentencia_control_switch            //Comienza con switch
    | instrucciones_loops_while                         //Comienza con while
    | instrucciones_loops_do_while                      //Comienza con do
    | instrucciones_loops_for                           //Comienza con for
    | instrucciones_variables_declaracion PUNTO_COMA    //Comienza con tipoDato
    | instrucciones_variables_asignacion PUNTO_COMA     //Comienza con nombreVariable (es un IDENTIFICADOR) = valor
    | instrucciones_print PUNTO_COMA                    //Comienza con print
    | instrucciones_arreglos_push_pop PUNTO_COMA        //Comienza con nombreVariable (es un IDENTIFICADOR) . pop ó .push
    | instrucciones_return PUNTO_COMA                   //Comienza con return    
    ;
    //Conjunto de intrucciones para FOR, WHILE y DO WHILE
instrucciones_block_loops : 
      LLAVE_INICIO instrucciones_unidad_varios_loops LLAVE_FIN //si vienen varios se agregan entre llaves {}
    | LLAVE_INICIO                                   LLAVE_FIN //si no vienen instrucciones, se tienen que usar llaves
    | instrucciones_unidad_loops //si viene una sola, entonces no se necesitan llaves
    ;
//conjunto de instrucciones unitarias, contienen 2 instrucciones extra
instrucciones_unidad_varios_loops : 
      instrucciones_unidad_varios_loops instrucciones_unidad_loops 
    | instrucciones_unidad_loops
    //| //epsilon
    ;
//instruccion general unitaria para loops, contiene 2 extras
instrucciones_unidad_loops : 
      instrucciones_funidad //tambien usan las instrucciones normales
    | BREAK    PUNTO_COMA //Break termina el ciclo
    | CONTINUE PUNTO_COMA //Continue termina la iteracion actual
    ;

//#LLAMADA FUNCIONES
instrucciones_funciones_llamada : //Estas funciones pueden ser de cualquier tipo, y se pueden ejecutar como instrucciones por si solas
        IDENTIFICADOR PAREN_INICIO instrucciones_print_valores PAREN_FIN // nombreFuncion (almenos1Valor) --> si son varios vienen nombreFuncion(a, sdsdwe, sewewe, 123, "2323")
    |   IDENTIFICADOR PAREN_INICIO /*no contienen parametros*/ PAREN_FIN // nombreFuncion() --> no tienen parametros
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
        WHILE condicion           //while (condicion)
        instrucciones_block_loops //{ instrucciones varias }
    ;

//#DO WHILE
//LOOP DO WHILE
instrucciones_loops_do_while :
        DO                          //do
        instrucciones_block_loops   //{ instrucciones varias }
        WHILE condicion PUNTO_COMA  //while ;
    ;

//#FOR
//LOOP FOR
instrucciones_loops_for :
        FOR PAREN_INICIO 
                instrucciones_variables_declaracion PUNTO_COMA //inicio: Declaracion o asignacion valor variable             $ for (int i = 0; i < 10; i++)
                operacion_general PUNTO_COMA                  //fin:    condicion --> debe de retornar un valor boolean     $ { 
                instrucciones_for                             //instrucciones permitas a los for                            $    instrucciones varias 
            PAREN_FIN                                         //                                                            $ }
        instrucciones_block_loops
    |   instrucciones_loops_for_each //puede venir un for each
    ;
    //los for tienen pocas acciones permitidas dentro de la ultima fase de la declaracion
instrucciones_for :
        instrucciones_variables_asignacion //asignar un nuevo valor a alguna variable
    |   instrucciones_print                //print
        /////////////INCREMENTO Y DECREMENTO
    | valores_datos INCREMENTO
    | valores_datos DECREMENTO
    ;

//#FOR EACH
instrucciones_loops_for_each :
        FOR nombres_variables_unidad IN valores_datos //for nombreAUsarEnForEach in variable --> la variable debe de ser un array o un string, a evaluar
        instrucciones_block_loops 
    ;

//#PRINT
//sentencias para declarar los print
instrucciones_print : //seguramente haya un cambio de operacion_general a operaciones que retornen String unicamente
        print PAREN_INICIO instrucciones_print_valores PAREN_FIN   //Print con valores
    |   print PAREN_INICIO                             PAREN_FIN   //Print vacio
    |   println PAREN_INICIO instrucciones_print_valores PAREN_FIN //Println con valores
    |   println PAREN_INICIO                             PAREN_FIN //Println sin valores
    ;
    //Conjunto de valores a imprimir por el print
instrucciones_print_valores :
        instrucciones_print_valores //Texto1
        COMA                        // ,
        operacion_general           //TEXTO2
    |   operacion_general   //TextoX
    //|   //epsilon
    ;

//#POP Y PUSH
instrucciones_arreglos_push_pop : //Acciones para los arreglos
        nombres_variables_unidad PUNTO POP  PAREN_INICIO arreglos_valores_posiciones PAREN_FIN //Accion pop, pop al ser remover posiciones, pueded aceptar BEGIN y END
    |   nombres_variables_unidad PUNTO PUSH PAREN_INICIO operacion_general           PAREN_FIN //Acion push
    ;

//#RETURN
instrucciones_return :
        RETURN operacion_general //retorna un valor
    |   RETURN                   //No retorna nada, usada para funciones de tipo void
    ;

//#CONDICION
//CONDICION Retorna true or false
condicion :
        PAREN_INICIO operacion_general PAREN_FIN
    ;

//#DECLARAR VARIABLES
//por definir
instrucciones_variables_declaracion :
        tipo_datos_generales                            //Tipo
        instrucciones_variables_declaracion_conjunto    //Conjunto de nombres de variables con o sin valores
    ;
    //Declarar variables con o sin valores
instrucciones_variables_declaracion_conjunto ://Puede venir: a, b
        instrucciones_variables_declaracion_conjunto    //a
        COMA                                            //,
        instrucciones_variables_declaracion_simple      //b
    |   instrucciones_variables_declaracion_simple      //a, que pasa arriba
    ;
instrucciones_variables_declaracion_simple :
        instrucciones_variables_asignacion //identificamos y asignamos valor        
        //Declaracion sin asignacion
    |   IDENTIFICADOR        //Nombre variable
    //|   //epsilon
    ;

//#ASIGNAR VALORES A VARIABLES    
    //asignacion sin declarar antes
instrucciones_variables_asignacion :
        IDENTIFICADOR        //Nombre variable
        IGUAL                // =
        operacion_general    //Valor
    ;

//#DATA TYPE
//son los tipos de las variables primitivos junto a tipos mas complejos
tipo_datos_generales : 
        tipo_datos_arreglo
    |   tipo_datos_primarios
    ;
    //TipoDatos[] para arreglos
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

//#VALUE DATA TYPES
    //se seoari dek valores_datos porque GATO variable no puede efectuar un incremento
valores_datos_arreglos :
        GATO nombres_variables_unidad // #nombreVariable  --> se usa para copiar los valores de un arreglo
    |   nombres_variables_unidad GATO // nombreVariable#  --> se usa para efectuar operaciones sobre todos los valores del arreglo
    ;
    //valores de variables incluidos
valores_datos :
        nombres_variables_unidad      // nombreVariable
    //|   valores_datos_primarios       // Valores primitivos
    //ARREGLOS
    | nombres_variables_unidad CORCH_INI arreglos_valores_posiciones CORCH_FIN //Para arrays en la posicion [a] donde a es una operacion aritmetica con resultado entero
    | nombres_variables_unidad CORCH_INI arreglos_valores_posiciones DOS_PUNTOS arreglos_valores_posiciones CORCH_FIN //Para arrays en la posicion array[begin:end]
    | CORCH_INI instrucciones_print_valores CORCH_FIN
    //FUNCIONES PARA VARIABLES DE TIPO STRING
    | nombres_variables_unidad PUNTO funciones_con_valor_string // nombreVariable.funcionEspecialStrings
    | STRING_VALUE             PUNTO funciones_con_valor_string //  "StringValue".funcionEspecialStrings
    //FUNCIONES NATIVAS PARA PARSEAR
    | funciones_con_valor_parsing
    //FUNCIONES CREADAS POR EL USUARIO
    | instrucciones_funciones_llamada
    ;
    /*Hace lo mismo que el no terminal instrucciones_print_valores
    //No terminal que sirve para tener valores del tipo 2, 34, [2, 4]
bloque_valores_operacion_general :
        bloque_valores_operacion_general    //ValoresGuardados
        COMA                                //sparacion coma
        operacion_general                   //valor
    |   operacion_general
    ;*/
    //valores ordinarios
valores_datos_primarios : 
      ENTERO_VALUE
	| DECIMAL_VALUE
	| BOOLEAN_VALUE
	| CHAR_VALUE
    | STRING_VALUE
	//| parametro_valor_name 
	//| nombres_variables_unidad	
	;
    //Los arreglos pueden tener de posicion numeros, begin o end
arreglos_valores_posiciones : //Datos que usan las posiciones de los arreglos
        operacion_general
    |   BEGIN
    |   END
    ;
nombres_variables_unidad : IDENTIFICADOR //nombreVariable
    //| GATO IDENTIFICADOR                 //#nombreVariable, para arreglos copiados por valores
    ;
//#FUNCIONES ESPECIALES PARA STRING
funciones_con_valor_string : 
        CARACTEROFPOSITION PAREN_INICIO operacion_general PAREN_FIN //caracterOfPosition (2) --> devuelve char
    |   subString   PAREN_INICIO //subString (2, 4)  -->    devuelve un substring
                        operacion_general 
                            COMA
                        operacion_general
                    PAREN_FIN
    |   LENGTH      PAREN_INICIO PAREN_FIN //string.length, tambien funciona con los array
    |   TOUPPERCASE PAREN_INICIO PAREN_FIN //string.toUpperCase    
    |   TOLOWERCASE PAREN_INICIO PAREN_FIN //string.toLowerCase
    ;
//#FUNCIONES PARSEO DE DATOS
    //Estas funciones son aquellas que se van a utilizar para el parseo de datos
funciones_con_valor_parsing :
        funciones_con_valor_parsing_tipo_datos PUNTO PARSE PAREN_INICIO operacion_general PAREN_FIN //--> funciones del tipo tipo.parse(string) solo debe aceptar string
    |   funciones_con_valor_parsing_tipo_parseo PAREN_INICIO operacion_general PAREN_FIN //
    ;
    //contiene los tipos de datos que soportan el "parse"
funciones_con_valor_parsing_tipo_datos:
      INT
    | DOUBLE
    | BOOLEAN
    ;
    //tipos de parseos en funciones nativas
funciones_con_valor_parsing_tipo_parseo :
        TOINT
    |   TODOUBLE
    |   STRING_PARSE
    |   TYPEOF
    ;

//#OPERACIONES ARITMETICAS
//#OPERACIONES LOGICAS
//#OPERACIONES RELACIONALES
//#Operaciones
operacion_general :
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
    /////////////CONCATENACIONES
    | operacion_general CONCAT_AND operacion_general
    | operacion_general CONCAT_POW operacion_general
    /////////////OPERADOR TERNARIO
    | operacion_general SIGNO_INTERROGACION_CIERRE operacion_general DOS_PUNTOS operacion_general // ValorComparacionOLogica ? ValorSiEsVerdadero : ValorSiEsFalso
    /////////////VALORES
    | valores_datos //variables y valores primitivos
    | valores_datos_primarios //valores primitivos
    | valores_datos_arreglos //Aca se debe de realizar una comparacion posterior, ya que solo sirve para asignacion de valor a otro array
	| SIGNO_MIN operacion_general %prec UMINUS
	| PAREN_INICIO operacion_general PAREN_FIN 
    ;
