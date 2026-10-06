# Resultados de las pruebas

## Método

El programa se compiló con GCC en Linux, usando C11 y las opciones `-Wall -Wextra -Wpedantic -Werror`. La compilación terminó correctamente y sin advertencias.

Se ejecutó un caso por proceso. La salida se comparó byte por byte con el archivo esperado, incluyendo espacios y saltos de línea. Las salidas reales se conservan en `resultados/*.actual` y el registro de compilación y ejecuciones en `resultados/compilacion_y_ejecuciones.txt`.

También se compiló con `-fsanitize=undefined,bounds -fno-sanitize-recover=all` y se ejecutaron los mismos 19 casos. No se detectaron errores de comportamiento indefinido ni de límites de arreglos en esas ejecuciones.

La versión con encabezado obligatorio y comentarios ampliados se recompiló sin advertencias y volvió a pasar las 19 comparaciones exactas. La sección y el enlace de la actividad siguen pendientes de confirmación en el encabezado.

## Resultado

17 de 17 pruebas oficiales correctas. 2 de 2 pruebas propias correctas. Total: 19 de 19.

| Caso | Salida obtenida frente a la esperada | Comprobaciones de ejecución |
| --- | --- | --- |
| caso_01 | COINCIDE | SIN ERRORES |
| caso_02 | COINCIDE | SIN ERRORES |
| caso_03 | COINCIDE | SIN ERRORES |
| caso_04 | COINCIDE | SIN ERRORES |
| caso_05 | COINCIDE | SIN ERRORES |
| caso_06 | COINCIDE | SIN ERRORES |
| caso_07 | COINCIDE | SIN ERRORES |
| caso_08 | COINCIDE | SIN ERRORES |
| caso_09 | COINCIDE | SIN ERRORES |
| caso_10 | COINCIDE | SIN ERRORES |
| caso_11 | COINCIDE | SIN ERRORES |
| caso_12 | COINCIDE | SIN ERRORES |
| caso_13 | COINCIDE | SIN ERRORES |
| caso_14 | COINCIDE | SIN ERRORES |
| caso_15 | COINCIDE | SIN ERRORES |
| caso_16 | COINCIDE | SIN ERRORES |
| caso_17 | COINCIDE | SIN ERRORES |
| propia_01 | COINCIDE | SIN ERRORES |
| propia_02 | COINCIDE | SIN ERRORES |

## Alcance de los casos

- Caso 01: reproduce el ejemplo completo del enunciado.
- Caso 02: procesa la matriz mínima 1 x 1.
- Caso 03: el valor anterior igual a L no genera evento.
- Caso 04: procesa una fila con cambios y valores extremos.
- Caso 05: una sola columna no genera eventos en esta regla horizontal.
- Caso 06: L y U son cero; ningún nivel válido puede ser menor que L.
- Caso 07: verifica niveles cercanos a los límites.
- Caso 08: procesa la matriz máxima de 30 x 30.
- Casos 09 a 15: las dimensiones, los límites o los niveles inválidos producen únicamente ERROR.
- Caso 16: detecta el salto de 1 a 45 en la columna 3 de la fila 3; su impacto es 44.
- Caso 17: verifica ausencia total de eventos, con prioridad y columna iguales a cero.
- Prueba propia 01: límites estrictos, evento en la última columna, inicio más temprano y empate de columnas.
- Prueba propia 02: desempates de filas por impacto, cantidad de eventos y menor número de fila.

Las entradas y salidas esperadas de las dos pruebas propias, junto con sus justificaciones, se documentan en PRUEBAS_PROPIAS.md. La prueba de escritorio se documenta en PRUEBA_ESCRITORIO.md.

Estos resultados describen las ejecuciones realizadas con GCC en este entorno. La compilación en la computadora del estudiante y la publicación en GitHub quedan pendientes de realizar allí o en el repositorio seleccionado.
