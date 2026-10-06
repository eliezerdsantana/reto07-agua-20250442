# Cómo entender y explicar el programa

## Encabezado y documentación obligatorios

El profesor exige el encabezado de identificación: sin él, indica que la nota es cero. El archivo incluye nombre, matrícula, sección, práctica, fecha y enlace de la actividad. El enlace de la actividad ya está incorporado con la dirección proporcionada por el estudiante. La sección está registrada como `Miércoles`, conforme al formato del ejemplo indicado por el estudiante.

El comentario situado encima de `main` describe lo que hace, sus entradas por consola y su retorno. La función se declara `main(void)`, de modo que no recibe parámetros. Los números de la matriz se leen con `scanf` desde la entrada estándar. La versión actual retorna cero al terminar; si encuentra datos inválidos, comunica esa situación mediante el texto `ERROR`.

La explicación del alumno representa el 50 % de los criterios generales compartidos. Para prepararla, hay que comprender la relación entre cada parte del código y sus resultados. La siguiente explicación está organizada en el mismo orden que el programa.

## 1. La matriz

`matriz[i][j]` significa el nivel del tanque `i` en la hora `j`. En C, los índices comienzan en cero: `matriz[0][0]` representa la primera fila y la primera columna. Por eso, al imprimir una fila se usa `i + 1`.

El arreglo tiene espacio fijo para 30 filas y 30 columnas. `N` y `M` indican qué parte se utiliza. Los ciclos externos recorren filas y los internos recorren columnas.

## 2. Leer y validar

`scanf("%d %d %d %d", &N, &M, &L, &U)` guarda los cuatro primeros enteros. `&` proporciona a `scanf` la dirección de la variable donde debe escribir.

`||` significa “o”: basta con que falle una restricción para imprimir `ERROR`. `return 0` termina el programa. Se valida toda la matriz antes de mostrar el informe, para que una entrada inválida nunca produzca líneas de resultados anteriores a `ERROR`.

Los controles del valor devuelto por `scanf` permiten terminar también si una lectura falla; el enunciado no evalúa esos casos.

## 3. Detectar un evento

```c
if (j >= 1 && matriz[i][j - 1] < L && matriz[i][j] >= U)
```

`&&` significa “y”: deben cumplirse las tres condiciones. En C se evalúan de izquierda a derecha y se detiene la evaluación cuando una es falsa. Si `j` vale cero, no se intenta acceder a la columna `j - 1`.

Ejemplo con `L = 10` y `U = 20`: pasar de 9 a 20 genera evento, pero pasar de 10 a 20 no lo genera. El impacto del primer salto es `20 - 9 = 11`.

## 4. Acumular resultados

`eventos_fila[i]++` suma uno a la cantidad de eventos de esa fila. `eventos_columna[j]++` hace lo mismo para la columna actual. `impacto_fila[i] += salto` añade el salto al impacto total.

Los vectores se inicializan con `{0}` para que sus posiciones empiecen en cero. La matriz original nunca cambia durante el análisis.

## 5. Guardar la mayor racha

`racha_actual` cuenta los eventos seguidos que se están recorriendo. Cuando comienza una racha, se guarda su posición en `inicio_actual`. Una posición sin evento restablece `racha_actual` a cero.

Se reemplaza la mejor racha únicamente cuando la actual es más larga. Si dos tienen igual longitud, queda guardada la primera. Con la regla de este reto no pueden existir eventos consecutivos, pero el seguimiento de rachas sigue el procedimiento que pide la rúbrica.

## 6. Escoger la prioridad

Se comparan racha, impacto y cantidad de eventos, en ese orden. El recorrido de filas es ascendente. Si la nueva fila no mejora los resultados, se conserva la anterior, lo que resuelve el empate a favor del menor número.

`prioridad` utiliza índices desde 1 y reserva cero para la ausencia de eventos. Para consultar sus datos en los arreglos, se convierte a índice de C mediante `prioridad - 1`.

La selección de columna utiliza la misma idea: actualizar solo cuando su cantidad de eventos es estrictamente mayor.

## 7. Imprimir

`%d` imprime un `int`; `%ld` imprime un `long`. `\n` produce un salto de línea. Los textos y espacios deben coincidir con los archivos esperados, porque no se permiten menús ni explicaciones en la salida del programa.

## Comprobaciones para estudiar

1. Con `L = 10`, `U = 20`, ¿el salto de 10 a 25 cuenta como evento? No: el valor anterior debe ser estrictamente menor que 10.
2. ¿El salto de 0 a 20 cuenta? Sí; su impacto es 20.
3. ¿Qué ocurre cuando solo hay una columna? No hay eventos, porque ninguna posición tiene una columna anterior.
4. ¿Por qué no se imprime una fila apenas se termina de leerla? Porque otra fila podría contener un dato inválido y entonces la única salida permitida es `ERROR`.
5. Si dos filas igualan racha e impacto, ¿qué se compara? Cantidad de eventos; si también empatan, gana la fila de menor número.
6. ¿Por qué se usa `>` y no `>=` al reemplazar una racha? Para conservar el inicio más temprano en un empate.
