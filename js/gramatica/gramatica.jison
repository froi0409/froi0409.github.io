/*Parser*/
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

    %nonassoc 'ELSE'
    %nonassoc 'ELSE_IF'
    //%left 'IGUAL'
    %right 'SIGNO_INTERROGACION_CIERRE' 'DOS_PUNTOS'
    %left 'OR'
    %left 'AND'  
    %left 'DIFERENTE_IGUAL' 'IGUAL_IGUAL'
    %left 'MAYOR_IGUAL' 'MENOR_IGUAL'  'MAYOR' 'MENOR'    
    %left 'SIGNO_MAS' 'SIGNO_MIN'
    %left 'SIGNO_POR' 'SIGNO_DIV' 'MOD'    
    //%left 'POW' 'SQRT' 'SIN' 'COS' 'TAN' 'LOG10'
    %left 'CONCAT_POW' 'CONCAT_AND'
    %right 'UMINUS' 'NOT'
    //%left 'INCREMENTO' 'DECREMENTO'//incrementos 
    %left 'PAREN_INICIO' 'PAREN_FIN' 'CORCH_INICIO' 'CORCH_FIN' //[] . 

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
      instrucciones_variables_declaracion PUNTO_COMA //declaraciones
    | instrucciones_variables_asignacion PUNTO_COMA //asignaciones
    | instrucciones_funciones_declaracion //normales y main
    | declarar_struct PUNTO_COMA //estructuras declaraciones
    ;

//#DECLARAR FUNCIONES
instrucciones_funciones_declaracion : 
        //FUNCION VOID
        VOID                                                 //Tipo funcion   --> void
        instrucciones_funciones_declaracion_nombre_funciones //Nombre funcion --> suma
        instrucciones_funciones_declaracion_parametros       //Parametros     --> (int num1, int num2)
        instrucciones_block_funcion                                  //Codigo         --> { codigo.......... }
        { console.log('Funcion tipo: ' + $1 + ' nombre: ' + $2); }
        //FUNCION DE OTRO TIPO (ARRAYS INCLUIDOS)
      | tipo_datos_generales                                 //Tipo funcion   --> datos generales (incluye arrays)
        instrucciones_funciones_declaracion_nombre_funciones //Nombre funcion --> suma
        instrucciones_funciones_declaracion_parametros       //Parametros     --> (int num1, int num2)
        instrucciones_block_funcion                                  //Codigo         --> { codigo.......... }
        { console.log('Funcion tipo: ' + $1 + ' nombre: ' + $2); }
    ;
    //Nombres de funciones
instrucciones_funciones_declaracion_nombre_funciones :
        nombres_variables_unidad //nombres cualquiera de funciones
       { $$ = $1; }
    |   MAIN                     //Main, reservada para la funcion main
        { $$ = $1; }
    ;
    //Contiene todos los parametros entre (), pueden tener o no parametros
instrucciones_funciones_declaracion_parametros :
        PAREN_INICIO instrucciones_funciones_declaracion_parametros_bloque PAREN_FIN
        { console.log('Funcion con parametros'); }
    |   PAREN_INICIO /*estas funciones no contienen parametros*/           PAREN_FIN
        { console.log('Funcion sin parametros'); }
    ;
    //Contiene un bloque de tipo Nombre, tipo2 Nombre2, tipo3 Nombre3, ......., tipoN NombreN
instrucciones_funciones_declaracion_parametros_bloque : 
        instrucciones_funciones_declaracion_parametros_bloque   //Tipos y nonbres
        COMA                                                    //,
        instrucciones_funciones_declaracion_parametros_unidad   //Agregamos un ultimo dato
        { console.log(', Dato: ' + $3); }
    |   instrucciones_funciones_declaracion_parametros_unidad  //Dato solitaria
        { console.log('Dato: ' + $1); }
    ;
    //unidad de tipoDato nombreVariable
instrucciones_funciones_declaracion_parametros_unidad :
        tipo_datos_generales  //los parametros, osea variables son de tipo ordinario o array
        IDENTIFICADOR         //Cada parametro/variable debe de tener un nombre identificador 
        { $$ = ' ' + $2 + ' : ' + $1 ; }   
    ;
    //tipos de funciones, usan void de extra
    /*
instrucciones_funciones_declaracion_tipo_funciones :
      VOID                  //No retorna ningun tipo
      { $$ = $1; }
    | tipo_datos_generales  //Puede retornar tipos de datos ordinarios y de tipo Array
      { $$ = $1; }
    ;*/

//#STRUCT
declarar_struct : 
    STRUCT IDENTIFICADOR            //struct nombreStruct
    LLAVE_INICIO                    //{
        declarar_struct_variables   // int a;
    LLAVE_FIN                       //}
    { console.log('Struct con nombre: ' + $2); }
    ;

//Los struct solo pueden tener declaracion de variables
declarar_struct_variables : 
        instrucciones_funciones_declaracion_parametros_bloque    
    |   //epsilon 
        { console.log('Sin datos'); }
    ;

//Conjunto de instrucciones generales, es decir instrucciones ejecutables dentro de las funciones, loops, etc
//El conjunto de instrucciones se empaqueta entre llaves
    //Conjunto de intrucciones para ifs, switch y funciones
instrucciones_block_funcion : 
      LLAVE_INICIO instrucciones_unidad_varios LLAVE_FIN //si vienen varios se agregan entre llaves {}
        { console.log('Bloque de instrucciones con muchos datos: '); }
    | LLAVE_INICIO                             LLAVE_FIN //si no vienen instrucciones, se tienen que usar llaves
        { console.log('Bloque de instrucciones sin datos: '); }
    ;
instrucciones_block : 
      LLAVE_INICIO instrucciones_unidad_varios LLAVE_FIN //si vienen varios se agregan entre llaves {}
        { console.log('Bloque de instrucciones con muchos datos: '); }
    | LLAVE_INICIO                             LLAVE_FIN //si no vienen instrucciones, se tienen que usar llaves
        { console.log('Bloque de instrucciones sin datos: '); }
    | instrucciones_unidad //si viene una sola, entonces no se necesitan llaves
        { console.log('Bloque de instrucciones con una sola instruccion: '); }
    ;
//conjunto de instrucciones unitarias
instrucciones_unidad_varios : instrucciones_unidad_varios instrucciones_unidad 
    | instrucciones_unidad
    //| //epsilon
    ;
//instruccion general unitaria
instrucciones_unidad : 
      instrucciones_funciones_llamada PUNTO_COMA        //Comienza con nombreFuncion (es un IDENTIFICADOR) (conjunto de parametros)
      { console.log('Se efectuo llamada de funcion: '); }
    | instrucciones_sentencia_control_ifs               //Comienza con if
      { console.log('Se efectuo llamada de IF: '); }
    | instrucciones_sentencia_control_switch            //Comienza con switch
      { console.log('Se efectuo llamada de SWITCH: '); }
    | instrucciones_loops_while                         //Comienza con while
      { console.log('Se efectuo llamada de WHILE: '); }
    | instrucciones_loops_do_while                      //Comienza con do
      { console.log('Se efectuo llamada de DO WHILE: '); }
    | instrucciones_loops_for                           //Comienza con for
      { console.log('Se efectuo llamada de FOR: '); }
    | instrucciones_variables_declaracion PUNTO_COMA    //Comienza con tipoDato
      { console.log('Se efectuo llamada de declaracion: '); }
    | instrucciones_variables_asignacion PUNTO_COMA     //Comienza con nombreVariable (es un IDENTIFICADOR) = valor
      { console.log('Se efectuo llamada de asignacion de valores: '); }
    | instrucciones_variables_asignacion_in_de_crement PUNTO_COMA //Se hace un incremento var++ o un decremento var--
      { console.log('Se efectuo llamada de asignacion de incremento/decremento: '); }
    | instrucciones_print PUNTO_COMA                    //Comienza con print
      { console.log('Se efectuo llamada de print: '); }
    | instrucciones_arreglos_push_pop PUNTO_COMA        //Comienza con nombreVariable (es un IDENTIFICADOR) . pop ó .push
      { console.log('Se efectuo llamada de pop o push: '); }
    | instrucciones_return PUNTO_COMA                   //Comienza con return  
      { console.log('Se einstrucciones_arreglos_push_popinstrucciones_arreglos_push_popinstrucciones_arreglos_push_popfectuo llamada de return: '); }  
    ;
    //Conjunto de intrucciones para FOR, WHILE y DO WHILE
instrucciones_block_loops : 
      LLAVE_INICIO instrucciones_unidad_varios_loops LLAVE_FIN //si vienen varios se agregan entre llaves {}
      { console.log('Se efectuo llamada de bloques para LOOPS: '); }
    | LLAVE_INICIO                                   LLAVE_FIN //si no vienen instrucciones, se tienen que usar llaves
      { console.log('Se efectuo llamada de bloques sin instrucciones para LOOPS: '); }
    | instrucciones_unidad_loops //si viene una sola, entonces no se necesitan llaves
      { console.log('Se efectuo llamada de bloques con una sola instruccion para LOOPS: '); }
    ;
//conjunto de instrucciones unitarias, contienen 2 instrucciones extra
instrucciones_unidad_varios_loops : 
      instrucciones_unidad_varios_loops instrucciones_unidad_loops 
    | instrucciones_unidad_loops
    //| //epsilon
    ;
//instruccion general unitaria para loops, contiene 2 extras
instrucciones_unidad_loops : 
      instrucciones_unidad //tambien usan las instrucciones normales
    | BREAK    PUNTO_COMA //Break termina el ciclo
      { console.log('Se efectuo llamada de BREAK LOOPS: '); }
    | CONTINUE PUNTO_COMA //Continue termina la iteracion actual
      { console.log('Se efectuo llamada de CONTINUE LOOPS: '); }
    ;

//#LLAMADA FUNCIONES
instrucciones_funciones_llamada : //Estas funciones pueden ser de cualquier tipo, y se pueden ejecutar como instrucciones por si solas
        IDENTIFICADOR PAREN_INICIO instrucciones_print_valores PAREN_FIN // nombreFuncion (almenos1Valor) --> si son varios vienen nombreFuncion(a, sdsdwe, sewewe, 123, "2323")
        { console.log('Se efectua llamada a la funcion con nombre: ' + $1 + ' y tiene los parametros ya mostrados'); }
    |   IDENTIFICADOR PAREN_INICIO /*no contienen parametros*/ PAREN_FIN // nombreFuncion() --> no tienen parametros
        { console.log('Se efectua llamada a la funcion con nombre: ' + $1 + ' y NO TIENE PARAMETROS'); }
    ;

//#IF
//instrucciones sentencia de control, IF
instrucciones_sentencia_control_ifs : //#Esto genera 3 errores de Shift/Reduce que se resuelven al ejecutar en analizador, agrega el else_if/else al if mas cercano
      /*  //IF solitario
        instrucciones_sentencia_control_ifs_if              //if      
        //IF con else's if  
      | instrucciones_sentencia_control_ifs_if              //if        
        instrucciones_sentencia_control_ifs_else_if_block   //else if
        //IF con else
      | instrucciones_sentencia_control_ifs_if              //if      
        instrucciones_sentencia_control_ifs_else           //else  
        //IF con else's if y else
      |*/ instrucciones_sentencia_control_ifs_if              //if        
          instrucciones_sentencia_control_ifs_else_if_block   //else if
          instrucciones_sentencia_control_ifs_else           //else
    ;
    //if
instrucciones_sentencia_control_ifs_if : 
        IF condicion // if (condicion)
        instrucciones_block                 //bloque de instrucciones
        { console.log('Se efectua IF'); }
    ;
instrucciones_sentencia_control_ifs_else_if_block:  
      instrucciones_sentencia_control_ifs_else_if_block 
      instrucciones_sentencia_control_ifs_else_if //por si vienen varios else if
    | instrucciones_sentencia_control_ifs_else_if //viene al menos un else if
    | //epsilon, por si no viene ninguno
    ;
    //else if
instrucciones_sentencia_control_ifs_else_if: 
        ELSE_IF condicion // else if (condicion)
        instrucciones_block                      //bloque de instrucciones
        { console.log('Se efectua else if'); }
    ;
    //else
instrucciones_sentencia_control_ifs_else: 
        ELSE                //else
        instrucciones_block //bloque de instrucciones
        { console.log('Se efectua else'); }
    | //epsilon, cuando no viene else
    ;

//#SWITCH
//Instrucciones sentencia SWITCH, el identificador es el nombre de alguna variable
instrucciones_sentencia_control_switch : 
        SWITCH PAREN_INICIO IDENTIFICADOR PAREN_FIN         // switch (variable)
            instrucciones_sentencia_control_switch_cuerpo   // {cuerpo}
            { console.log('Switch para: ' + $3); }
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
        CASE valores_datos_primarios DOS_PUNTOS                               //case 2:        --> puede venir int, char, String, boolean, float, double
            instrucciones_sentencia_control_switch_cuerpo_case_instrucciones  //instrucciones
            instrucciones_sentencia_control_switch_cuerpo_case_break          //break;         --> no es obligatorio
        { console.log('Se efectua CASE'); }
    |   DEFAULT DOS_PUNTOS                                                    //default :
            instrucciones_sentencia_control_switch_cuerpo_case_instrucciones  //instrucciones
            instrucciones_sentencia_control_switch_cuerpo_case_break          //break;        --> no es obligatorio
        { console.log('Se efectua DEFAULT'); }
    ;
instrucciones_sentencia_control_switch_cuerpo_case_break : BREAK PUNTO_COMA //break ;
       { console.log('Se efectua BREAK SWITCH'); }
    | //epsilon
       { console.log('Se efectua SIN BREAK'); }
    ;
instrucciones_sentencia_control_switch_cuerpo_case_instrucciones:
      instrucciones_unidad_varios //con instrucciones
    | //epsilon                   //sin instrucciones
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
    |   instrucciones_variables_asignacion_in_de_crement    
    ;

//#FOR EACH
instrucciones_loops_for_each :
        FOR nombres_variables_unidad IN valores_datos //for nombreAUsarEnForEach in variable --> la variable debe de ser un array o un string, a evaluar
        instrucciones_block_loops 
        { console.log('Se ejecuta for Each'); }
    ;

//#PRINT
//sentencias para declarar los print
instrucciones_print : //seguramente haya un cambio de operacion_general a operaciones que retornen String unicamente
        PRINT PAREN_INICIO instrucciones_print_valores PAREN_FIN   //Print con valores
        { console.log('Print con valores'); }
    |   PRINT PAREN_INICIO                             PAREN_FIN   //Print vacio
        { console.log('Print vacio'); }
    |   PRINTLN PAREN_INICIO instrucciones_print_valores PAREN_FIN //Println con valores
        { console.log('Println con valores'); }
    |   PRINTLN PAREN_INICIO                             PAREN_FIN //Println sin valores
        { console.log('Print vacio'); }
    ;
    //Conjunto de valores a imprimir por el print
instrucciones_print_valores :
        instrucciones_print_valores //Texto1
        COMA                        // ,
        operacion_general           //TEXTO2
        { console.log(', ValorOpG'); }
    |   operacion_general   //TextoX
        { console.log('ValorOpG'); }
    //|   //epsilon
    ;

//#POP Y PUSH
instrucciones_arreglos_push_pop : //Acciones para los arreglos
        nombres_variables_unidad PUNTO POP  PAREN_INICIO arreglos_valores_posiciones PAREN_FIN //Accion pop, pop al ser remover posiciones, pueded aceptar BEGIN y END
        { console.log('Se ejecuta un pop'); }
    |   nombres_variables_unidad PUNTO PUSH PAREN_INICIO operacion_general           PAREN_FIN //Acion push
        { console.log('Se ejecuta un push'); }
    ;

//#RETURN
instrucciones_return :
        RETURN operacion_general //retorna un valor
        { console.log('Se ejecuta un RETURN con valor'); }
    |   RETURN                   //No retorna nada, usada para funciones de tipo void
        { console.log('Se ejecuta un RETURN '); }
    ;

//#CONDICION
//CONDICION Retorna true or false
condicion :
        PAREN_INICIO operacion_general PAREN_FIN
        { console.log('Se efectua una condicion'); }
    ;

//#DECLARAR VARIABLES
//por definir
instrucciones_variables_declaracion :
        tipo_datos_generales                            //Tipo        
        instrucciones_variables_declaracion_conjunto    //Conjunto de nombres de variables con o sin valores
        { console.log('Se declaran variables del tipo: ' + $1 + ' , var de arriba'); }
    ;
    //Declarar variables con o sin valores
instrucciones_variables_declaracion_conjunto ://Puede venir: a, b
        instrucciones_variables_declaracion_conjunto    //a
        COMA                                            //,
        instrucciones_variables_declaracion_simple      //b
    |   instrucciones_variables_declaracion_simple      //a, que pasa arriba
    ;
instrucciones_variables_declaracion_simple :     
    //Declaracion con o sin asignacion
      IDENTIFICADOR instrucciones_variables_declaracion_simple_asignacion_opcional     //Nombre variable
      { console.log('NombreVar: ' + $1); }
    //|   //epsilon
    ;
instrucciones_variables_declaracion_simple_asignacion_opcional ://una declaracion puede o no tener un valor
      IGUAL                // =
      operacion_general    //Valor
      { console.log('NombreVar: ' + $1 + '=Valor'); }
    | //epsilon
    ;  
//#ASIGNAR VALORES A VARIABLES    
    //asignacion sin declarar antes
instrucciones_variables_asignacion :
        IDENTIFICADOR        //Nombre variable
        IGUAL                // =
        operacion_general    //Valor
        { console.log('NombreVar: ' + $1 + '=Valor'); }
    ;

//#INCREMENTO
//#DECREMENTO
instrucciones_variables_asignacion_in_de_crement :
      valores_datos INCREMENTO
      { console.log('accion de INCREMENTO'); }
    | valores_datos DECREMENTO
      { console.log('accion de DECREMENTO'); }
  ;

//#DATA TYPE
//son los tipos de las variables primitivos junto a tipos mas complejos
tipo_datos_generales : 
        tipo_datos_arreglo
        { $$ = $1; }
    |   tipo_datos_primarios
        { $$ = $1; }
    ;
    //TipoDatos[] para arreglos
tipo_datos_arreglo : tipo_datos_primarios CORCH_INICIO CORCH_FIN //int[]
      { $$ = $1 + '[]'; }
    ;
    //son los tipos de las variables primitivos, int, char, String, boolean, float, double
tipo_datos_primarios :
      INT
      { $$ = $1; }
    | DOUBLE
      { $$ = $1; }
    | BOOLEAN
      { $$ = $1; }
    | CHAR
      { $$ = $1; }
    | STRING
      { $$ = $1; }
    | FLOAT
      { $$ = $1; }
    ;

//#VALUE DATA TYPES
    //se seoari dek valores_datos porque GATO variable no puede efectuar un incremento
valores_datos_arreglos :
        GATO nombres_variables_unidad // #nombreVariable  --> se usa para copiar los valores de un arreglo
        { console.log('CopiarArreglos con #' + $2); }
    |   nombres_variables_unidad GATO // nombreVariable#  --> se usa para efectuar operaciones sobre todos los valores del arreglo
        { console.log('Efectuar acciones con' + $1 + '#'); }
    ;
    //valores de variables incluidos
valores_datos : //Hay un conflicto para nombreVariable seguido de PUNTO o CORCH_INICIO, funciona
        nombres_variables_unidad      // nombreVariable
        { console.log('Datos, nombre de variable simple: ' + $1); }
    //|   valores_datos_primarios       // Valores primitivos
    //ARREGLOS
    | nombres_variables_unidad CORCH_INICIO arreglos_valores_posiciones CORCH_FIN //Para arrays en la posicion [a] donde a es una operacion aritmetica con resultado entero      
      { console.log('Datos ArrayEnLaPos, var[' + $3 + '] '); }
    | nombres_variables_unidad CORCH_INICIO arreglos_valores_posiciones DOS_PUNTOS arreglos_valores_posiciones CORCH_FIN //Para arrays en la posicion array[begin:end]
      { console.log('Datos ArrayEnRango, var[' + $3 + ':' + $5 + '] '); }
    | CORCH_INICIO instrucciones_print_valores CORCH_FIN
      { console.log('Datos Array de datos de los mencionados, var[' + '....., los que aparecen arriba] '); }
    //FUNCIONES PARA VARIABLES DE TIPO STRING
    | nombres_variables_unidad PUNTO funciones_con_valor_string // nombreVariable.funcionEspecialStrings
      { console.log('Datos variablesString.' + $3); }
    | STRING_VALUE             PUNTO funciones_con_valor_string //  "StringValue".funcionEspecialStrings
      { console.log('Datos String.' + $3); }
    //FUNCIONES NATIVAS PARA PARSEAR
    | funciones_con_valor_parsing
      { console.log('Datos funcion parsing : ' + $1); }
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
  | NULL
	//| parametro_valor_name 
	//| nombres_variables_unidad	
	;
    //Los arreglos pueden tener de posicion numeros, begin o end
arreglos_valores_posiciones : //Datos que usan las posiciones de los arreglos
        operacion_general
        { $$ = 'OperacionGeneral'; }
    |   BEGIN
        { $$ = $1; }
    |   END
        { $$ = $1; }
    ;
nombres_variables_unidad : IDENTIFICADOR //nombreVariable
        { $$ = $1; }
    //| GATO IDENTIFICADOR                 //#nombreVariable, para arreglos copiados por valores
    ;
//#FUNCIONES ESPECIALES PARA STRING
funciones_con_valor_string : 
        CARACTEROFPOSITION PAREN_INICIO operacion_general PAREN_FIN //caracterOfPosition (2) --> devuelve char
        { $$ = $1+ '(valor)'; }
    |   SUBSTRING   PAREN_INICIO //subString (2, 4)  -->    devuelve un substring
                        operacion_general 
                            COMA
                        operacion_general
                    PAREN_FIN
        { $$ = $1 + '(valor, valor2)'; }
    |   LENGTH      PAREN_INICIO PAREN_FIN //string.length, tambien funciona con los array
        { $$ = $1 + '()'; }
    |   TOUPPERCASE PAREN_INICIO PAREN_FIN //string.toUpperCase    
        { $$ = $1 + '()'; }
    |   TOLOWERCASE PAREN_INICIO PAREN_FIN //string.toLowerCase
        { $$ = $1 + '()'; }
    ;
//#FUNCIONES PARSEO DE DATOS
    //Estas funciones son aquellas que se van a utilizar para el parseo de datos
funciones_con_valor_parsing :
        //funciones_con_valor_parsing_tipo_datos PUNTO PARSE PAREN_INICIO operacion_general PAREN_FIN //--> funciones del tipo tipo.parse(string) solo debe aceptar string
        tipo_datos_primarios PUNTO PARSE PAREN_INICIO operacion_general PAREN_FIN //--> funciones del tipo tipo.parse(string) solo debe aceptar string, donde tipo INT DOUBLE BOOLEAN
        { $$ = $1 + '.parse(valor)'; }
    |   funciones_con_valor_parsing_tipo_parseo PAREN_INICIO operacion_general PAREN_FIN //
        { $$ = $1 + '(valor)'; }
    ;
    //contiene los tipos de datos que soportan el "parse"
funciones_con_valor_parsing_tipo_datos:
      INT
      { $$ = $1; }
    | DOUBLE
      { $$ = $1; }
    | BOOLEAN
      { $$ = $1; }
    ;
    //tipos de parseos en funciones nativas
funciones_con_valor_parsing_tipo_parseo :
        TOINT
        { $$ = $1; }
    |   TODOUBLE
        { $$ = $1; }
    |   STRING_PARSE
        { $$ = $1; }
    |   TYPEOF
        { $$ = $1; }
    ;

//#OPERACIONES ARITMETICAS
//#OPERACIONES LOGICAS
//#OPERACIONES RELACIONALES
//#Operaciones
operacion_general :
	/////////////OPERACIONES LOGICAS
	  operacion_general AND  operacion_general 
      { console.log('Se efectua AND'); }
    | operacion_general OR   operacion_general
      { console.log('Se efectua OR'); } 
    | NOT operacion_general 
      { console.log('Se efectua NOT'); }
    /////////////OPERACIONES RELACIONALES
    | operacion_general MAYOR           operacion_general 
      { console.log('Se efectua MAYOR'); }
    | operacion_general MENOR           operacion_general
      { console.log('Se efectua MENOR'); }
    | operacion_general MAYOR_IGUAL     operacion_general 
      { console.log('Se efectua MAYOR_IGUAL'); }
    | operacion_general MENOR_IGUAL     operacion_general 
      { console.log('Se efectua MENOR_IGUAL'); }
    | operacion_general DIFERENTE_IGUAL operacion_general 
      { console.log('Se efectua DIFERENTE_IGUAL'); }
    | operacion_general IGUAL_IGUAL     operacion_general 
      { console.log('Se efectua IGUAL_IGUAL'); }
	/////////////OPERACIONES ARITMETICAS
	| operacion_general SIGNO_MAS operacion_general
      { console.log('Se efectua SIGNO_MAS'); }
    | operacion_general SIGNO_MIN operacion_general
      { console.log('Se efectua SIGNO_MIN'); }
    | operacion_general SIGNO_POR operacion_general
      { console.log('Se efectua SIGNO_POR'); }
    | operacion_general SIGNO_DIV operacion_general
      { console.log('Se efectua SIGNO_DIV'); }
    /////////////OPERACIONES NATIVAS
    | operacion_general MOD   operacion_general
      { console.log('Se efectua MOD'); }
    | POW PAREN_INICIO operacion_general PAREN_FIN
      { console.log('Se efectua POW'); }
    | SQRT PAREN_INICIO operacion_general PAREN_FIN
      { console.log('Se efectua SQRT'); }
    | LOG10 PAREN_INICIO operacion_general PAREN_FIN
      { console.log('Se efectua LOG10'); }
    | SIN PAREN_INICIO operacion_general PAREN_FIN
      { console.log('Se efectua SIN'); }
    | COS PAREN_INICIO operacion_general PAREN_FIN
      { console.log('Se efectua COS'); }
    | TAN PAREN_INICIO operacion_general PAREN_FIN
      { console.log('Se efectua TAN'); }
    /////////////CONCATENACIONES
    | operacion_general CONCAT_AND operacion_general
      { console.log('Se efectua CONCAT_AND'); }
    | operacion_general CONCAT_POW operacion_general
      { console.log('Se efectua CONCAT_POW'); }
    /////////////OPERADOR TERNARIO
    | operacion_general SIGNO_INTERROGACION_CIERRE operacion_general DOS_PUNTOS operacion_general // ValorComparacionOLogica ? ValorSiEsVerdadero : ValorSiEsFalso
      { console.log('Se efectua OPERACION TERNARIO'); }
    /////////////VALORES
    | valores_datos //variables y valores primitivos
      { console.log('Se efectua valores_datos'); }
    | valores_datos_primarios //valores primitivos
      { console.log('Se efectua valores_primarios'); }
    | valores_datos_arreglos //Aca se debe de realizar una comparacion posterior, ya que solo sirve para asignacion de valor a otro array
      { console.log('Se efectua valores_datos_arreglos'); }
	| SIGNO_MIN operacion_general %prec UMINUS
      { console.log('Se efectua SIGNO_MENOS UMINUS'); }
	| PAREN_INICIO operacion_general PAREN_FIN 
      { console.log('Se efectua AGRUPACION POR ()'); }
    ;
