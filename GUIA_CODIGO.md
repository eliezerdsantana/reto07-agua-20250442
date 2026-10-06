# Guía para entender el programa desde cero

Estudiante: Eliezer Daniels Santana. Matrícula: 20250442. Sección: Miércoles.

Esta guía explica [20250442.c](20250442.c) en el orden en que trabaja. Utiliza la entrada oficial [caso_16.in](pruebas/caso_16.in) y su [salida esperada](pruebas/caso_16.out). Es material para preparar la explicación del algoritmo.

## 1. Qué problema resuelve

Imagina una tabla de cuaderno. Cada fila contiene los niveles de agua de un tanque. Cada columna corresponde a una hora.

El programa recibe esa tabla y busca recuperaciones: un nivel estaba por debajo de un límite bajo y, en la hora siguiente, llegó al límite alto o lo superó.

Para cada tanque informa:

- **EVENTOS:** cuántas recuperaciones encontró.
- **IMPACTO:** la suma de las subidas que corresponden a esas recuperaciones.
- **RACHA:** la mayor cantidad de eventos en posiciones consecutivas.
- **INICIO:** la columna donde comenzó la primera racha de esa longitud máxima.

Después informa cuántos eventos hay en cada columna, qué fila tiene prioridad y qué columna tiene más eventos.

El recorrido completo consiste en leer los datos, comprobarlos, buscar eventos, reunir sus resultados, escoger los ganadores y escribir el informe.

## 2. Un ejemplo que acompañará toda la explicación

El caso 16 contiene:

```text
3 5 13 15
28 39 23 17 44
31 25 19 40 3
45 1 45 30 28
```

La primera línea describe el problema:

| Dato | Valor | Significado |
| --- | --- | --- |
| N | 3 | Hay tres filas: tres tanques. |
| M | 5 | Hay cinco columnas: cinco horas por tanque. |
| L | 13 | Para comenzar un evento, el nivel anterior debe ser menor que 13. |
| U | 15 | Para completar el evento, el nivel actual debe ser 15 o más. |

Las otras tres líneas son la tabla de niveles:

| Tanque / fila | Hora 1 | Hora 2 | Hora 3 | Hora 4 | Hora 5 |
| --- | ---: | ---: | ---: | ---: | ---: |
| 1 | 28 | 39 | 23 | 17 | 44 |
| 2 | 31 | 25 | 19 | 40 | 3 |
| 3 | 45 | 1 | 45 | 30 | 28 |

Con estos límites, pasar de 1 a 45 es un evento: 1 es menor que 13 y 45 es al menos 15. Su impacto es 45 − 1 = 44.

## 3. Qué es el archivo de código

El archivo `20250442.c` contiene instrucciones escritas en C. El compilador traduce esas instrucciones a un programa que la computadora puede ejecutar. En Windows, el comando utilizado creó `reto.exe`.

```text
gcc -std=c11 -Wall -Wextra 20250442.c -o reto.exe
```

Aquí `gcc` es el compilador, `-std=c11` selecciona la versión C11 del lenguaje, `-Wall -Wextra` activan grupos de advertencias y `-o reto.exe` indica el nombre del ejecutable.

Al ejecutarse, el programa lee números de la entrada estándar. Esta entrada puede venir del teclado o de un archivo redirigido, como sucedió en las pruebas. `scanf` hace la lectura y `printf` escribe en la salida estándar, normalmente la terminal.

## 4. Los comentarios del comienzo

El encabezado que comienza con `/*` y termina con `*/` identifica al estudiante y la actividad. Un comentario es una nota para quien lee el archivo; no se ejecuta.

El código incluye nombre, matrícula, `Sección: Miércoles`, práctica, fecha y el [enlace proporcionado de la actividad](https://aulavirtual.itla.edu.do/mod/assign/view.php?id=253496).

El comentario situado encima de `main` describe la función. `@brief` señala su descripción breve y `@return` explica qué devuelve. Dentro del comentario siguen siendo documentación, sin efecto sobre el cálculo.

Según los criterios generales compartidos, el encabezado es obligatorio y la explicación del alumno representa el 50 %. Estos criterios generales acompañan la preparación; no sustituyen la rúbrica particular del PDF del reto.

## 5. Las dos líneas que preparan el programa

```c
#include <stdio.h>
#define MAXIMO 30
```

`#include <stdio.h>` incorpora las declaraciones necesarias para utilizar funciones de entrada y salida, entre ellas `scanf` y `printf`.

`#define MAXIMO 30` establece un nombre para la capacidad máxima. En las expresiones del programa, `MAXIMO` se sustituye por 30 antes de compilar. Así, la capacidad se escribe en un solo lugar.

Las líneas que comienzan con `#` son instrucciones de preparación del código y no llevan el punto y coma de las declaraciones comunes.

## 6. Dónde empieza la ejecución

```c
int main(void) {
    /* Instrucciones del programa. */
    return 0;
}
```

Una **función** es un bloque de instrucciones con un nombre. `main` es la función por la que empieza este programa.

- `int` indica que devuelve un número entero al entorno que lo ejecuta.
- `void` indica que esta declaración de `main` no tiene parámetros.
- `{` abre el bloque y `}` lo cierra.
- `return 0;` termina la función y devuelve cero. No imprime un cero en pantalla.

Aunque `main(void)` no recibe parámetros, puede leer datos de consola mediante `scanf`. Los parámetros de una función y los números de la entrada estándar son dos formas diferentes de recibir información.

En este código, los caminos de datos inválidos también hacen `return 0;`. El mensaje `ERROR` es lo que comunica el problema; el código de salida sigue siendo cero.

## 7. Las variables: cajitas con nombre

Una **variable** es un lugar donde guardar un dato. Se puede imaginar como una cajita etiquetada.

```c
int N, M, L, U;
```

`int` sirve para números enteros, como 3, 13 o 45. La línea declara cuatro variables. Sus valores se leerán después. El punto y coma `;` termina la declaración.

```c
int matriz[MAXIMO][MAXIMO];
```

Un **arreglo** agrupa posiciones donde guardar datos del mismo tipo. Esta matriz es un arreglo de dos dimensiones: filas y columnas.

Tiene espacio para 30 × 30 = 900 niveles. Con N = 3 y M = 5 solo se utiliza un rectángulo de 15 posiciones. Reservar una capacidad máxima no obliga a usarla toda.

La matriz todavía no tiene niveles definidos al declararse. El programa los lee y valida antes de analizarlos.

### Las listas que guardan los resúmenes

```c
int eventos_fila[MAXIMO] = {0};
long impacto_fila[MAXIMO] = {0};
int racha_fila[MAXIMO] = {0};
int inicio_fila[MAXIMO] = {0};
int eventos_columna[MAXIMO] = {0};
```

Un **vector** es un arreglo de una dimensión, parecido a una lista. Cada posición de los primeros cuatro vectores corresponde a una fila. Cada posición del último corresponde a una columna.

| Vector | Qué guarda en cada posición |
| --- | --- |
| eventos_fila | Cantidad de eventos de una fila. |
| impacto_fila | Suma de los impactos de una fila. |
| racha_fila | Mayor racha de una fila. |
| inicio_fila | Columna inicial de la primera racha máxima de una fila. |
| eventos_columna | Cantidad de eventos que terminaron en una columna, sumando todas las filas. |

`= {0}` hace que **todas las posiciones** del vector empiecen en cero. Es necesario porque todavía no se ha encontrado ningún evento.

`long` también es un tipo entero y cumple el requisito de capacidad de al menos 32 bits para el impacto. No siempre ocupa más espacio que `int`: en Windows pueden tener el mismo tamaño.

### Las otras variables

```c
int total_eventos = 0;
int prioridad = 0;
int columna = 0;
int i, j;
```

`total_eventos` cuenta los eventos de toda la tabla. `prioridad` guarda el número de la fila elegida. `columna` guarda el número de la columna elegida.

Para esos dos resultados, cero significa “ninguna”. Las filas y columnas del informe se numeran desde 1.

`i` y `j` serán los contadores de los recorridos: `i` señala la fila y `j` la columna. Los ciclos les asignan su valor inicial.

## 8. La computadora cuenta las posiciones desde cero

Un **índice** es el número utilizado para localizar una posición del arreglo.

| Posición para una persona | Expresión en C |
| --- | --- |
| Fila 1, columna 1 | matriz[0][0] |
| Fila 3, columna 2 | matriz[2][1] |
| Fila 3, columna 3 | matriz[2][2] |

Por eso:

- `matriz[i][j]` es el nivel actual.
- `matriz[i][j - 1]` es el nivel inmediatamente anterior en la misma fila.
- `i + 1` convierte el índice de fila de C al número usado en el informe.
- `j + 1` hace lo mismo con la columna.

En el ejemplo, `matriz[2][1]` vale 1 y `matriz[2][2]` vale 45.

## 9. Leer los cuatro números iniciales

```c
if (scanf("%d %d %d %d", &N, &M, &L, &U) != 4) {
    printf("ERROR\n");
    return 0;
}
```

`scanf` intenta leer cuatro enteros. Cada `%d` corresponde a uno. Se guardan, en orden, en N, M, L y U.

`&N` proporciona la dirección de la cajita N: indica dónde debe escribir `scanf`. Los otros `&` hacen lo mismo.

`scanf` devuelve cuántos datos logró leer y asignar. Si los cuatro se leyeron correctamente, devuelve 4.

`if` significa “si se cumple esta condición, ejecuta lo que está entre las llaves”. `!=` significa “es distinto de”. Si la cantidad leída es distinta de 4, se imprime `ERROR` y se termina.

`\n` es un salto de línea: coloca lo que se escriba después en la siguiente línea.

Hay tres símbolos distintos que conviene reconocer:

- `=`: guardar un valor, como `prioridad = 0;`.
- `==`: preguntar si dos valores son iguales.
- `!=`: preguntar si son diferentes.

## 10. Comprobar los límites

```c
if (N < 1 || N > MAXIMO || M < 1 || M > MAXIMO ||
    L < 0 || L > U || U > 1000) {
    printf("ERROR\n");
    return 0;
}
```

`||` significa “o”. Basta con que **una** de esas situaciones sea verdadera para entrar al bloque de error.

La tabla debe tener entre 1 y 30 filas y entre 1 y 30 columnas. Los límites deben cumplir:

```text
0 <= L <= U <= 1000
```

Por ejemplo, N = 31 intenta usar más filas de las disponibles. L = 20 y U = 10 ponen los límites en un orden inválido. En ambos casos corresponde `ERROR`.

Se comprueban N y M antes de escribir niveles en la matriz, para que los recorridos usen posiciones dentro de la capacidad reservada.

## 11. Leer toda la tabla con ciclos

Un **ciclo** repite instrucciones. Este programa usa `for`.

```c
for (i = 0; i < N; i++) {
    for (j = 0; j < M; j++) {
        if (scanf("%d", &matriz[i][j]) != 1 ||
            matriz[i][j] < 0 || matriz[i][j] > 1000) {
            printf("ERROR\n");
            return 0;
        }
    }
}
```

Un `for` tiene tres partes:

| Parte de for (i = 0; i < N; i++) | Qué hace |
| --- | --- |
| i = 0 | Empieza por la primera fila de C. |
| i < N | Continúa mientras queden filas. |
| i++ | Suma uno a i al terminar cada vuelta. |

Con N = 3, i toma los valores 0, 1 y 2. Nunca utiliza i = 3 dentro del ciclo, porque 3 < 3 es falso.

El ciclo exterior elige una fila. El interior lee todas sus columnas. Con M = 5, j toma los valores 0, 1, 2, 3 y 4. Al pasar a la siguiente fila, el ciclo interior vuelve a comenzar en j = 0.

`scanf("%d", &matriz[i][j])` lee un nivel y lo guarda en esa posición. Se comprueba que se haya leído un dato y que esté entre 0 y 1000.

**Se valida toda la tabla antes de imprimir resultados.** Si el último nivel fuera inválido, la salida debe contener únicamente `ERROR`. Imprimir las filas durante la lectura dejaría un informe incompleto antes de ese mensaje.

## 12. Recorrer de nuevo para buscar eventos

La lectura ya dejó una tabla válida. Ahora comienza otro recorrido:

```c
for (i = 0; i < N; i++) {
    int racha_actual = 0;
    int inicio_actual = 0;

    for (j = 0; j < M; j++) {
        /* Buscar eventos en esta fila. */
    }
}
```

Esta vez no se guardan niveles nuevos. Se revisan los que ya existen.

`racha_actual` cuenta los eventos consecutivos que se están recorriendo y `inicio_actual` guarda dónde comenzó esa racha. Empiezan en cero en **cada fila**, para no mezclar tanques.

Los niveles de la matriz se conservan. Los resúmenes se guardan en los vectores.

## 13. La condición central: cuándo hay un evento

```c
if (j >= 1 && matriz[i][j - 1] < L && matriz[i][j] >= U)
```

`&&` significa “y”. Las tres condiciones deben cumplirse:

1. `j >= 1`: estamos desde la segunda columna y existe un nivel anterior.
2. `matriz[i][j - 1] < L`: ese nivel anterior es menor que el límite bajo.
3. `matriz[i][j] >= U`: el nivel actual llegó al límite alto o lo superó.

En C, `&&` evalúa de izquierda a derecha y deja de evaluar si encuentra una condición falsa. Cuando j = 0, la primera condición es falsa y no se intenta leer la posición j − 1 = −1.

El nivel anterior debe ser **estrictamente menor** que L. El actual puede ser **igual** a U.

Con L = 13 y U = 15:

| Cambio | ¿Es evento? | Motivo |
| --- | --- | --- |
| 1 → 45 | Sí | 1 < 13 y 45 >= 15. |
| 13 → 45 | No | 13 no es menor que 13. |
| 1 → 14 | No | 14 no alcanza 15. |
| 1 → 15 | Sí | Se permite que el actual sea igual a U. |

### Recorrido de la fila 3 del ejemplo

| Columna actual | Anterior | Actual | Resultado |
| --- | ---: | ---: | --- |
| 1 | No existe | 45 | No hay comparación posible. |
| 2 | 45 | 1 | Sin evento: 45 no es menor que 13. |
| 3 | 1 | 45 | Evento: cumple las dos condiciones de nivel. |
| 4 | 45 | 30 | Sin evento: 45 no es menor que 13. |
| 5 | 30 | 28 | Sin evento: 30 no es menor que 13. |

La fila 1 no tiene niveles anteriores menores que 13. La fila 2 termina con 3, pero después de ese 3 no queda otra hora que pueda completar un evento.

Cada fila se analiza por separado. El 3 del final de la fila 2 no se compara con el 45 inicial de la fila 3, porque representan tanques diferentes.

## 14. Qué se suma al encontrar un evento

```c
eventos_fila[i]++;
impacto_fila[i] += (long)matriz[i][j] - matriz[i][j - 1];
eventos_columna[j]++;
total_eventos++;
```

`++` suma uno. En una instrucción como `total_eventos++;`, produce el mismo aumento que `total_eventos = total_eventos + 1;`.

`+=` significa “suma esto al valor que ya guardabas”. Si el impacto acumulado fuera 20 y llega otro impacto de 15, el nuevo total sería 35.

`(long)` convierte el nivel actual al tipo `long` antes de restarlo al anterior. El salto se calcula como actual menos anterior y se suma solo cuando hay un evento.

Para el cambio 1 → 45 de la fila 3, columna 3, i = 2 y j = 2:

| Dato actualizado | Antes | Después |
| --- | ---: | ---: |
| eventos_fila[2] | 0 | 1 |
| impacto_fila[2] | 0 | 44 |
| eventos_columna[2] | 0 | 1 |
| total_eventos | 0 | 1 |

El evento pertenece a la columna del valor **actual**, donde se completa la recuperación.

## 15. Cómo se guarda la racha y su inicio

```c
if (racha_actual == 0) {
    inicio_actual = j + 1;
}
racha_actual++;

if (racha_actual > racha_fila[i]) {
    racha_fila[i] = racha_actual;
    inicio_fila[i] = inicio_actual;
}
```

Si la racha actual estaba en cero, acaba de empezar. Se guarda su columna en `inicio_actual`, sumando uno a j para usar la numeración del informe.

Luego se suma un evento a la racha actual. Si esa racha supera la mayor guardada, se actualizan la longitud máxima y su inicio.

`>` significa “mayor que”. Al usar `>` en lugar de `>=`, una racha que empata no reemplaza a la primera. Así se conserva el inicio más temprano.

Si la posición no tiene un evento, se ejecuta:

```c
else {
    racha_actual = 0;
}
```

`else` significa “en caso contrario”. Reinicia la racha que se estaba recorriendo, pero conserva la mayor racha encontrada anteriormente.

En el caso 16, el evento de la columna 3 establece racha máxima 1 e inicio 3. La columna 4 reinicia la racha actual. El resumen sigue guardando 1 y 3.

### Por qué aquí una racha no puede llegar a dos

Al terminar un evento, el nivel actual es al menos U. Como U es al menos L, ese nivel tampoco es menor que L.

Para que hubiera otro evento justo en la columna siguiente, ese mismo nivel tendría que servir como anterior y ser menor que L. Las dos condiciones son incompatibles.

Por tanto, con los límites válidos de este reto, la racha máxima solo puede ser 0 o 1. El código conserva el seguimiento de rachas solicitado.

Ejemplo adicional: con L = 10 y U = 20, la fila `0 20 0 20` tiene dos eventos, en las columnas 2 y 4. Están separados por una posición sin evento: EVENTOS = 2, RACHA = 1 e INICIO = 2.

## 16. Cómo se escoge la fila prioritaria

```c
if (total_eventos > 0)
```

Si hay eventos, se buscan los ganadores. Si no hay ninguno, `prioridad` y `columna` conservan cero.

La búsqueda recorre las filas de menor a mayor. Solo considera las que tienen eventos:

```c
if (eventos_fila[i] > 0) {
    if (prioridad == 0) {
        prioridad = i + 1;
    }
    /* Después se comparan las demás candidatas. */
}
```

La primera candidata se guarda como ganadora provisional. Una ganadora provisional es la mejor encontrada hasta ese momento; puede cambiar al revisar otra fila.

Para comparar una nueva candidata con la ganadora:

```c
int mejor = prioridad - 1;
int es_mejor = 0;
```

`prioridad` guarda un número desde 1. `mejor` le resta uno para consultar esa fila en los vectores de C.

`es_mejor` es una señal: 0 significa “no reemplazar”; 1 significa “sí reemplazar”.

El orden de comparación es:

1. Gana la mayor racha.
2. Si las rachas empatan, gana el mayor impacto total.
3. Si también empatan los impactos, gana la mayor cantidad de eventos.
4. Si empatan en todo, se conserva la fila de menor número.

El código de esas comparaciones es:

```c
if (racha_fila[i] > racha_fila[mejor]) {
    es_mejor = 1;
} else if (racha_fila[i] == racha_fila[mejor]) {
    if (impacto_fila[i] > impacto_fila[mejor]) {
        es_mejor = 1;
    } else if (impacto_fila[i] == impacto_fila[mejor] &&
               eventos_fila[i] > eventos_fila[mejor]) {
        es_mejor = 1;
    }
}

if (es_mejor) {
    prioridad = i + 1;
}
```

`else if` añade una condición para revisar cuando la anterior no se cumplió. `if (es_mejor)` entra cuando la señal tiene un valor distinto de cero.

No se suman racha, impacto y eventos para escoger. Se comparan en el orden establecido. El recorrido ascendente y las mejoras estrictas hacen que un empate completo conserve la fila anterior, que tiene menor número.

### Un ejemplo real de los desempates

La [prueba propia 02](PRUEBAS_PROPIAS.md) produce:

| Fila | Racha | Impacto | Eventos |
| --- | ---: | ---: | ---: |
| 1 | 1 | 20 | 1 |
| 2 | 1 | 40 | 1 |
| 3 | 1 | 40 | 2 |
| 4 | 1 | 40 | 2 |
| 5 | 1 | 30 | 1 |

La fila 1 es la primera candidata. La 2 la supera por impacto. La 3 supera a la 2 por cantidad de eventos, después de empatar en racha e impacto. La 4 empata completamente con la 3 y no la reemplaza. La 5 tiene menos impacto. La prioridad final es 3.

En el caso 16 solo la fila 3 tiene eventos: PRIORIDAD = 3.

## 17. Cómo se escoge la columna destacada

```c
for (j = 0; j < M; j++) {
    if (eventos_columna[j] > 0) {
        if (columna == 0) {
            columna = j + 1;
        } else if (eventos_columna[j] >
                   eventos_columna[columna - 1]) {
            columna = j + 1;
        }
    }
}
```

Se recorren las columnas y se consideran las que tienen eventos. La primera queda elegida provisionalmente. Otra la reemplaza solo si tiene **más** eventos.

`columna - 1` convierte el número guardado al índice del vector. `j + 1` convierte la nueva posición al número del informe.

Si dos columnas empatan, queda la menor porque se recorrieron en orden y el empate no reemplaza a la anterior.

En el ejemplo, los conteos son `0 0 1 0 0`. Solo la columna 3 tiene un evento, por eso COLUMNA = 3.

## 18. Escribir los resultados con printf

```c
printf("FILA %d EVENTOS %d IMPACTO %ld RACHA %d INICIO %d\n",
       i + 1, eventos_fila[i], impacto_fila[i],
       racha_fila[i], inicio_fila[i]);
```

`printf` escribe texto y valores. La parte entre comillas es el formato. Los valores que siguen se colocan, en orden, en sus marcas:

| Marca | Valor que se coloca |
| --- | --- |
| Primer %d | Número de fila: i + 1. |
| Segundo %d | Cantidad de eventos de esa fila. |
| %ld | Impacto de esa fila, de tipo long. |
| Tercer %d | Mayor racha de esa fila. |
| Cuarto %d | Inicio de esa racha. |

`%d` corresponde a un `int` y `%ld` a un `long`. `\n` termina la línea.

En esta llamada no se usa `&` delante de las variables: `printf` recibe sus valores para mostrarlos. En las lecturas, `scanf` necesita sus direcciones para guardarlos.

El ciclo exterior de impresión escribe una línea por fila.

### La línea de columnas y las dos líneas finales

```c
printf("COLUMNAS");
for (j = 0; j < M; j++) {
    printf(" %d", eventos_columna[j]);
}
printf("\nPRIORIDAD %d\nCOLUMNA %d\n", prioridad, columna);
```

Primero se escribe `COLUMNAS` sin salto de línea. Después, cada vuelta añade un espacio y el conteo de una columna a esa misma línea.

El primer `\n` de la última llamada termina la línea de columnas. Los siguientes separan PRIORIDAD y COLUMNA, y cierran la última línea.

Las etiquetas, el orden, los espacios y los saltos deben respetar el formato esperado. El programa imprime el informe sin preguntas ni menús.

## 19. Resultado completo del ejemplo

Los resúmenes finales son:

| Fila | Eventos | Impacto | Racha | Inicio |
| --- | ---: | ---: | ---: | ---: |
| 1 | 0 | 0 | 0 | 0 |
| 2 | 0 | 0 | 0 | 0 |
| 3 | 1 | 44 | 1 | 3 |

La salida exacta es:

```text
FILA 1 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 2 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 3 EVENTOS 1 IMPACTO 44 RACHA 1 INICIO 3
COLUMNAS 0 0 1 0 0
PRIORIDAD 3
COLUMNA 3
```

Los ceros de las filas 1 y 2 indican que no se encontró un evento y, por tanto, tampoco un impacto, una racha o un inicio.

## 20. Los símbolos reunidos en un lugar

| Símbolo o palabra | Lectura sencilla en este programa |
| --- | --- |
| ; | Termina una declaración o instrucción. |
| { } | Delimitan un bloque; en {0}, delimitan el inicializador del arreglo. |
| ( ) | Contienen argumentos de funciones, condiciones de if o partes de for. |
| [ ] | Señalan el tamaño de un arreglo o una posición dentro de él. |
| = | Guarda un valor. |
| == | Comprueba si dos valores son iguales. |
| != | Comprueba si son distintos. |
| < | Menor que. |
| > | Mayor que. |
| >= | Mayor o igual que. |
| && | Deben cumplirse ambas condiciones. |
| \|\| | Basta con que se cumpla una de las condiciones. |
| &variable | Dirección donde scanf debe guardar un dato. |
| ++ | Suma uno. |
| += | Suma una cantidad al valor que ya había. |
| if | Ejecuta un bloque si una condición es verdadera. |
| else | Ejecuta el caso contrario. |
| for | Repite un bloque. |
| return | Termina la función y devuelve un valor. |
| %d / %ld | Marcas del formato para int / long. |
| \n | Salto de línea en una cadena de texto de C. |

## 21. Situaciones especiales y decisiones que se deben poder justificar

- **Una sola columna:** no hay eventos porque ninguna posición tiene una columna anterior.
- **Ningún evento:** los resúmenes quedan en cero y los dos ganadores también.
- **L = 0:** ningún nivel válido es menor que cero; no puede haber eventos.
- **L = U:** sigue siendo necesaria una subida desde un anterior estrictamente menor que ese límite hasta un actual igual o mayor.
- **Dato inválido al final:** el programa imprime solo ERROR, porque la validación completa se hizo antes del informe.
- **Empates:** las mejoras estrictas conservan la primera posición que ya había alcanzado el resultado máximo.
- **Matriz fija:** usa la capacidad máxima permitida y recorre solo N filas y M columnas.
- **Vectores inicializados:** permiten contar y acumular desde cero.
- **Matriz original conservada:** cada comparación utiliza los niveles recibidos.
- **Índices seguros:** j >= 1 impide consultar una columna anterior a la primera.
- **Numeración:** los arreglos usan índices desde cero; el informe usa números desde uno.
- **Impacto long y formato %ld:** el tipo satisface el requisito y su impresión utiliza la marca correspondiente.

## 22. Un modelo de explicación oral para practicar

“Mi programa recibe la cantidad de tanques, la cantidad de horas, los límites L y U y una tabla de niveles. Primero comprueba las dimensiones, los límites y todos los niveles. Si encuentra datos inválidos, imprime ERROR y termina.

Después recorre cada tanque por separado. A partir de la segunda columna compara el nivel anterior con el actual. Hay una recuperación cuando el anterior es menor que L y el actual es mayor o igual que U. Cuenta ese evento en su fila y en la columna actual, y suma la diferencia de niveles al impacto de la fila.

También registra la mayor racha y su primer inicio. Para la prioridad compara racha, impacto y cantidad de eventos, en ese orden; en un empate completo conserva la fila de menor número. Escoge la columna con más eventos y conserva la menor si empatan. Si no hay eventos, ambos resultados son cero. Al final imprime las etiquetas y valores en el formato solicitado.”

Este texto es una referencia para estudiar. Poder decirlo con palabras propias requiere repasar el recorrido y comprender sus condiciones. La preparación de la guía no constituye una evaluación de comprensión ni una defensa oral realizada.
