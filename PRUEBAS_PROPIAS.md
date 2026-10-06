# Dos pruebas propias justificadas

Los resultados esperados se calcularon manualmente antes de ejecutar el programa. Los archivos `.in` contienen las entradas y los `.out` contienen los resultados esperados. Las salidas obtenidas se guardan en `resultados/`.

## Prueba propia 01: límites, rachas separadas y empate de columnas

Entrada, guardada en `pruebas/propia_01.in`:

```text
1 9 10 20
0 20 10 20 9 19 0 0 25
```

Salida esperada, guardada en `pruebas/propia_01.out`:

```text
FILA 1 EVENTOS 2 IMPACTO 45 RACHA 1 INICIO 2
COLUMNAS 0 1 0 0 0 0 0 0 1
PRIORIDAD 1
COLUMNA 2
```

Justificación: prueba que la primera columna no produce evento; `x == U` sí se acepta; `p == L` se rechaza; `x == U - 1` se rechaza. Incluye dos eventos separados, uno en la última columna. Permite verificar que se conserva el primer inicio de una racha máxima y que el empate entre las columnas 2 y 9 se resuelve a favor de la 2.

## Prueba propia 02: desempates de la fila prioritaria

Entrada, guardada en `pruebas/propia_02.in`:

```text
5 5 10 20
0 20 10 10 10
0 40 10 10 10
0 20 0 20 10
0 20 0 20 10
10 0 30 10 10
```

Salida esperada, guardada en `pruebas/propia_02.out`:

```text
FILA 1 EVENTOS 1 IMPACTO 20 RACHA 1 INICIO 2
FILA 2 EVENTOS 1 IMPACTO 40 RACHA 1 INICIO 2
FILA 3 EVENTOS 2 IMPACTO 40 RACHA 1 INICIO 2
FILA 4 EVENTOS 2 IMPACTO 40 RACHA 1 INICIO 2
FILA 5 EVENTOS 1 IMPACTO 30 RACHA 1 INICIO 3
COLUMNAS 0 4 1 2 0
PRIORIDAD 3
COLUMNA 2
```

Justificación: todas las rachas tienen longitud 1. La fila 2 supera a la 1 por impacto. La fila 3 iguala el impacto de la 2, pero tiene más eventos. La fila 4 empata con la 3 en todos los criterios, por lo que gana la fila 3. La fila 5 tiene menor impacto y no sustituye a la prioritaria. También verifica que un evento pertenece a la columna del valor actual, no a la columna del valor anterior.

No se inventa una prueba con dos eventos consecutivos: esa situación es imposible con la condición particular y `L <= U`. Los casos oficiales cubren además matrices mínimas y máximas, ausencia de eventos y datos inválidos.
