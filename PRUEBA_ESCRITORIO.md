# Prueba de escritorio

Se utiliza la primera prueba propia porque incluye varios eventos, límites exactos, una posición final con evento y empates.

## Entrada

```text
1 9 10 20
0 20 10 20 9 19 0 0 25
```

Aquí `L = 10`, `U = 20`. Cada evento debe cumplir `p < 10` y `x >= 20`. La columna 1 no se compara porque no tiene valor anterior.

## Recorrido de la fila

Los índices de columna de la tabla comienzan en 1. La racha actual se registra después de procesar esa posición; el impacto acumulado suma únicamente los impactos de los eventos.

| Columna | p | x | Evento | Impacto de posición | Eventos acumulados | Impacto acumulado | Racha actual | Mayor racha | Inicio guardado |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | — | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 2 | 0 | 20 | 1 | 20 | 1 | 20 | 1 | 1 | 2 |
| 3 | 20 | 10 | 0 | 0 | 1 | 20 | 0 | 1 | 2 |
| 4 | 10 | 20 | 0 | 0 | 1 | 20 | 0 | 1 | 2 |
| 5 | 20 | 9 | 0 | 0 | 1 | 20 | 0 | 1 | 2 |
| 6 | 9 | 19 | 0 | 0 | 1 | 20 | 0 | 1 | 2 |
| 7 | 19 | 0 | 0 | 0 | 1 | 20 | 0 | 1 | 2 |
| 8 | 0 | 0 | 0 | 0 | 1 | 20 | 0 | 1 | 2 |
| 9 | 0 | 25 | 1 | 25 | 2 | 45 | 1 | 1 | 2 |

En la columna 2, el valor actual es exactamente `U` y sí genera evento. En la columna 4, el valor anterior es exactamente `L`, por lo que no genera evento. En la columna 6, el anterior es suficientemente bajo pero el actual no alcanza `U`.

La columna 9 produce otro evento. Su racha tiene la misma longitud que la primera; se conserva el inicio 2. La actualización durante el recorrido también detecta correctamente un evento al final de la fila.

## Consolidación

- Eventos de la fila: 2.
- Impacto total: `(20 - 0) + (25 - 0) = 45`.
- Mayor racha: 1; inicio más temprano: columna 2.
- Vector de columnas: `0 1 0 0 0 0 0 0 1`.
- Fila prioritaria: 1, porque es la única fila y tiene eventos.
- Columna destacada: 2. Las columnas 2 y 9 tienen un evento; gana la menor.

## Salida esperada

```text
FILA 1 EVENTOS 2 IMPACTO 45 RACHA 1 INICIO 2
COLUMNAS 0 1 0 0 0 0 0 0 1
PRIORIDAD 1
COLUMNA 2
```

## Verificación manual de los desempates de la segunda prueba

Todas las filas de la prueba propia 02 tienen racha máxima 1.

| Fila que se revisa | Eventos | Impacto | Decisión al recorrer en orden | Prioridad tras revisarla |
| --- | --- | --- | --- | --- |
| 1 | 1 | 20 | Es la primera fila con eventos | 1 |
| 2 | 1 | 40 | Supera a la fila 1 por impacto | 2 |
| 3 | 2 | 40 | Iguala racha e impacto; supera por cantidad de eventos | 3 |
| 4 | 2 | 40 | Empate completo; se conserva la fila de menor número | 3 |
| 5 | 1 | 30 | Tiene menor impacto que la fila 3 | 3 |

El vector de columnas es `0 4 1 2 0`; la columna destacada es la 2.
