# Reto 07: Agua, recuperación de reservas

Estudiante: Eliezer Daniels Santana. Matrícula: 20250442.

## Problema

Se recibe una matriz de niveles de agua. Cada fila es un tanque y cada columna es una hora, en el orden recibido. Se deben detectar saltos de recuperación y resumir sus efectos sin modificar los niveles originales.

Un evento ocurre desde la segunda columna cuando el nivel anterior de la misma fila es estrictamente menor que `L` y el nivel actual es mayor o igual que `U`:

```c
j >= 1 && matriz[i][j - 1] < L && matriz[i][j] >= U
```

El impacto de un evento es `matriz[i][j] - matriz[i][j - 1]`. En cualquier otra posición, su aporte es cero. La primera columna nunca genera un evento porque no tiene columna anterior.

## Entradas y restricciones

La primera línea contiene cuatro enteros: `N M L U`. Luego se leen `N * M` enteros.

| Dato | Significado | Restricción |
| --- | --- | --- |
| N | Cantidad de tanques, o filas | 1 a 30 |
| M | Cantidad de horas, o columnas | 1 a 30 |
| L | Límite inferior | 0 a U |
| U | Límite superior | L a 1000 |
| matriz[i][j] | Nivel de agua | 0 a 1000 |

Los separadores pueden ser espacios o saltos de línea. El enunciado garantiza una entrada numérica y completa cuando las dimensiones y los límites son válidos. No exige procesar texto, entradas truncadas ni tokens adicionales.

Las dimensiones y los límites se validan antes de leer la matriz. Todos los niveles se validan antes de imprimir el informe. Si algún dato incumple las restricciones, se imprime únicamente `ERROR` y se termina. Esto evita que un valor inválido en la última fila produzca un informe parcial.

## Salidas

Una línea por fila: `FILA i EVENTOS e IMPACTO s RACHA r INICIO b`.

Luego: `COLUMNAS c1 c2 ... cM`, `PRIORIDAD f` y `COLUMNA k`, cada una en su propia línea. Los índices impresos comienzan en 1. No se muestran preguntas ni mensajes adicionales.

Por fila se calcula cantidad de eventos, suma de impactos, mayor racha consecutiva e inicio más temprano de una racha de esa longitud. Una posición sin evento interrumpe la racha. Si una fila no tiene eventos, su racha e inicio son cero.

La fila prioritaria se selecciona en este orden:

1. Mayor racha.
2. Mayor impacto total.
3. Mayor cantidad de eventos.
4. Menor número de fila.

La columna destacada es la de mayor cantidad de eventos; en empate gana la de menor número. Si no existen eventos en toda la matriz, ambos índices son cero.

## Variables y arreglos

| Nombre | Tipo | Función |
| --- | --- | --- |
| N, M, L, U | int | Dimensiones y límites |
| matriz[30][30] | int | Conservar los niveles originales |
| eventos_fila[30] | int | Cantidad de eventos en cada fila |
| impacto_fila[30] | long | Suma de impactos en cada fila |
| racha_fila[30] | int | Mayor racha en cada fila |
| inicio_fila[30] | int | Inicio de la mayor racha, con índice desde 1 |
| eventos_columna[30] | int | Cantidad de eventos en cada columna |
| i, j | int | Índices desde 0 para recorrer los arreglos |
| racha_actual, inicio_actual | int | Seguimiento de la racha que se recorre |
| total_eventos | int | Identificar la ausencia total de eventos |
| prioridad, columna | int | Resultados desde 1; cero indica ausencia de eventos |
| mejor | int | Índice desde 0 de la fila prioritaria actual |
| es_mejor | int | Resultado de comparar dos filas |

`long` tiene capacidad de al menos 32 bits y se imprime con `%ld`. Los vectores de resúmenes se inicializan en cero. Solo se accede a las primeras `N` filas y `M` columnas.

## Pseudocódigo

```text
INICIO
    Leer N, M, L, U
    Si N o M no están entre 1 y 30, o no se cumple 0 <= L <= U <= 1000:
        Imprimir ERROR y terminar

    Para cada fila i de 0 a N - 1:
        Para cada columna j de 0 a M - 1:
            Leer matriz[i][j]
            Si su valor no está entre 0 y 1000:
                Imprimir ERROR y terminar

    Inicializar en cero todos los vectores de resúmenes
    total_eventos <- 0

    Para cada fila i de 0 a N - 1:
        racha_actual <- 0
        inicio_actual <- 0

        Para cada columna j de 0 a M - 1:
            Si j >= 1 Y matriz[i][j - 1] < L Y matriz[i][j] >= U:
                eventos_fila[i] <- eventos_fila[i] + 1
                impacto_fila[i] <- impacto_fila[i] + matriz[i][j] - matriz[i][j - 1]
                eventos_columna[j] <- eventos_columna[j] + 1
                total_eventos <- total_eventos + 1

                Si racha_actual = 0:
                    inicio_actual <- j + 1
                racha_actual <- racha_actual + 1

                Si racha_actual > racha_fila[i]:
                    racha_fila[i] <- racha_actual
                    inicio_fila[i] <- inicio_actual
            Si no:
                racha_actual <- 0

    prioridad <- 0
    columna <- 0

    Si total_eventos > 0:
        Para cada fila i, en orden creciente:
            Si eventos_fila[i] > 0:
                Si prioridad = 0:
                    prioridad <- i + 1
                Si no:
                    mejor <- prioridad - 1
                    es_mejor <- falso
                    Si racha_fila[i] > racha_fila[mejor]:
                        es_mejor <- verdadero
                    Si las rachas son iguales Y impacto_fila[i] > impacto_fila[mejor]:
                        es_mejor <- verdadero
                    Si rachas e impactos son iguales Y eventos_fila[i] > eventos_fila[mejor]:
                        es_mejor <- verdadero
                    Si es_mejor:
                        prioridad <- i + 1

        Para cada columna j, en orden creciente:
            Si eventos_columna[j] > 0:
                Si columna = 0:
                    columna <- j + 1
                Si no, si eventos_columna[j] > eventos_columna[columna - 1]:
                    columna <- j + 1

    Imprimir los resúmenes de todas las filas, en orden
    Imprimir COLUMNAS y el vector eventos_columna
    Imprimir PRIORIDAD y prioridad
    Imprimir COLUMNA y columna
FIN
```

El recorrido ascendente y la actualización únicamente ante una mejora conservan la fila o columna de menor número cuando hay empate completo. La racha se actualiza solo si es mayor que la guardada, conservando así su inicio más temprano.

## Particularidad de esta regla

Dos eventos no pueden ser consecutivos con `L <= U`. Después de un evento, el valor actual cumple `x >= U >= L`. Para que la posición siguiente fuera evento, ese mismo valor tendría que ser menor que `L`, lo que es imposible. Por tanto, las rachas válidas de este reto tienen longitud cero o uno. Aun así, se implementa el seguimiento de rachas requerido por la rúbrica.

El caso 01 no contiene eventos: un valor anterior igual a `L` no satisface `p < L`. Las descripciones genéricas de los casos de prueba no reemplazan la regla particular: este reto compara columnas adyacentes de la misma fila.

## Costo

La lectura y el análisis realizan recorridos de `N * M` posiciones. Los resúmenes requieren recorridos adicionales de `N` y `M`. El tiempo es `O(N * M)` y la memoria utilizada corresponde a una matriz fija de 30 x 30 y vectores de tamaño 30.
