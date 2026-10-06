# Reto 07: Agua: recuperación de reservas

**Estudiante:** Eliezer Daniels Santana
**Matrícula:** 20250442
**Correo:** 20250442@itla.edu.do
**Valor:** 25 puntos

## Situación

Matriz de tanques por horas; valores: nivel de agua en unidades enteras. Un solo programa integrado en C.

## Regla

Desde la segunda columna, detecta un salto desde un valor estrictamente menor que L hasta otro mayor o igual que U.

Condición: `j >= 1 && p < L && x >= U`

Impacto si cumple: `x-p`. La magnitud del salto de recuperación.

x = valor actual; p = valor anterior de la misma fila; q = siguiente; z = valor de dos columnas atrás; f = primer valor de la fila; v = valor de la fila anterior en la misma columna; d = valor absoluto de x-p; SF = suma de la fila; SC = suma de la columna; MX/MN = máximo/mínimo de la fila; AC = suma de la fila hasta la columna actual, incluida. N y M son las dimensiones. En las fórmulas C, i y j empiezan en 0.

1. Un evento es una posición que cumple la regla particular. Su impacto se calcula solo si cumple; cualquier otra posición aporta 0. No alteres los datos originales.

2. Para cada fila, calcula cantidad de eventos, suma de impactos, longitud de la mayor racha de eventos consecutivos e inicio de esa racha. Una posición sin evento interrumpe la racha. Si hay varias rachas máximas, elige la que empieza antes. Si no hay eventos, longitud e inicio son 0.

3. Construye un vector con la cantidad de eventos de cada columna, considerando todas las filas. Las rachas siempre se recorren horizontalmente, incluso cuando la regla compara filas.

4. La fila prioritaria se elige por: mayor racha; luego mayor impacto total; luego mayor cantidad de eventos; finalmente menor número de fila. La columna destacada tiene más eventos; en empate, menor número de columna. Si no hay eventos en toda la matriz, ambos resultados son 0.

## Entrada, salida y alcance

Consulta el PDF de esta carpeta para el contrato completo de validación, formato, restricciones y entregables.

## Ejemplo

Entrada:
```text
3 5 5 15
5 15 30 10 25
25 10 5 20 30
10 20 15 5 35
```
Salida:
```text
FILA 1 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 2 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 3 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
COLUMNAS 0 0 0 0 0
PRIORIDAD 0
COLUMNA 0
```

## Rúbrica

- **Análisis y diseño: 4 puntos.** 1 p: entradas, salidas y restricciones; 1 p: variables y arreglos; 1 p: pseudocódigo de eventos e impacto; 1 p: pseudocódigo de rachas, resúmenes y desempates.
- **Lectura y validación: 3 puntos.** 1 p: lectura completa sin mensajes extra; 1 p: dimensiones y límites; 1 p: valores de la matriz. Ante datos inválidos, solo ERROR.
- **Regla particular e impacto: 6 puntos.** 2 p: condición exacta; 1 p: tratamiento de bordes; 1 p: impacto por evento; 2 p: acumulación por fila, sin sumar los no eventos.
- **Rachas y consolidación: 5 puntos.** 2 p: longitud máxima por fila; 1 p: inicio más temprano y caso sin racha; 1 p: conteos por fila; 1 p: vector de conteos por columna.
- **Prioridad y salida: 4 puntos.** 2 p: selección de fila con todos los desempates y ausencia de eventos; 1 p: columna destacada; 1 p: etiquetas, orden y valores de salida.
- **Pruebas y calidad del código: 3 puntos.** 1 p: fuente C compilable y legible, con comentarios útiles; 1 p: matriz y vectores bien dimensionados, sin accesos fuera de rango; 1 p: prueba de escritorio y dos pruebas propias justificadas.
