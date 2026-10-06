# Resultados de las pruebas

## Método

El programa se compiló con GCC en Linux, usando C11 y las opciones `-Wall -Wextra -Wpedantic -Werror`. La compilación terminó correctamente y sin advertencias.

Se ejecutó un caso por proceso. La salida se comparó byte por byte con el archivo esperado, incluyendo espacios y saltos de línea. Las salidas reales se conservan en `resultados/*.actual` y el registro de compilación y ejecuciones en `resultados/compilacion_y_ejecuciones.txt`.

También se compiló con `-fsanitize=undefined,bounds -fno-sanitize-recover=all` y se ejecutaron los mismos 19 casos. No se detectaron errores de comportamiento indefinido ni de límites de arreglos en esas ejecuciones.

La versión con encabezado obligatorio y comentarios ampliados se recompiló sin advertencias y volvió a pasar las 19 comparaciones exactas. El encabezado se actualizó posteriormente con el enlace de la actividad y la sección `Miércoles`.

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

Los resultados de la tabla corresponden a las ejecuciones realizadas con GCC en Linux. El proyecto ya está publicado en GitHub.

## Primera comprobación en Windows — 06/10/2026

En la computadora del estudiante, Git fue reconocido por PowerShell y el programa se compiló con `gcc -std=c11 -Wall -Wextra 20250442.c -o reto.exe`, sin errores ni advertencias visibles. Se ejecutó el caso 16 y se revisó la salida de su captura línea por línea frente a `pruebas/caso_16.out`; el texto visible coincide.

La evidencia y la justificación están en [Primera comprobación local en Windows](evidencias/windows/PRIMERA_PRUEBA.md). El cotejo visual de esa captura no comprueba los bytes del archivo de salida.

## Comprobación completa en Windows — 06/10/2026

Se ejecutó `verificar_pruebas_windows.ps1` en la laptop del estudiante. La captura muestra los 17 casos oficiales y los dos propios con `COINCIDE CODIGO 0`, y el resumen final `Resultado: 19 de 19 casos coinciden.`.

La comparación del script normaliza únicamente CRLF a LF y conserva el resto del texto, incluido el salto final. Para registrar coincidencia exige además código de salida 0 y una salida de errores vacía. El resultado inicial de Windows se registró a partir de la captura del verificador; la revisión posterior de sus archivos se detalla al final. La comparación byte por byte descrita al inicio corresponde a las ejecuciones anteriores en Linux.

La [captura original y los detalles de la ejecución](evidencias/windows/PRUEBAS_COMPLETAS.md) están incorporados. Los archivos generados en la laptop se publicaron en [resultados de Windows](resultados/windows/ejecucion_20261006_103035_034) mediante el commit `00366ac`.

## Revisión de los archivos publicados — 06/10/2026

Se cotejaron directamente las 19 salidas `.actual` publicadas con sus correspondientes `pruebas/*.out`. Todas coinciden después de normalizar exclusivamente CRLF a LF. Se conservaron espacios, mayúsculas, orden de líneas y salto final.

Los 19 archivos `.stderr.txt` y [el registro de compilación](resultados/windows/ejecucion_20261006_103035_034/compilacion.txt) están vacíos. [El resumen](resultados/windows/ejecucion_20261006_103035_034/resumen.txt) registra código de salida 0 para la compilación y para cada caso, y su lista corresponde exactamente a las 17 pruebas oficiales y las dos propias.

[El entorno](resultados/windows/ejecucion_20261006_103035_034/entorno.txt) registra la ejecución del 06/10/2026 a las 10:30:35, con zona UTC−04:00, GCC 16.1.0 de MSYS2, Git 2.56.0.windows.2 y PowerShell 5.1.26100.9444. La versión del repositorio probada fue `5d5f836`.

La huella SHA256 registrada del fuente, `2d72e6b691d09807e50d278a3a8c435b87c389657f07dc45ed3dd20edb97c877`, corresponde a `20250442.c` de la versión `5d5f836`, con los saltos de línea CRLF de su copia de Windows. La actualización posterior del encabezado incorpora el enlace de la actividad y el día de clase; las instrucciones del programa permanecen idénticas. Los archivos de esta ejecución conservan la identificación de la versión probada.

El commit de publicación incorpora 42 archivos: 19 salidas, 19 registros de errores, tres registros generales y una regla `.gitattributes` que conserva los saltos de línea de esta evidencia.

## Actualización posterior del encabezado — 06/10/2026

Se incorporaron el enlace de la actividad y el dato conocido del grupo, clase los miércoles. Se comprobó que todo el texto posterior al comentario inicial es idéntico a la versión anterior. La revisión de sintaxis con `gcc -std=c11 -Wall -Wextra -Wpedantic -Werror -fsyntax-only 20250442.c`, realizada en Linux, terminó con código 0 y sin diagnósticos. Esta comprobación verifica el ajuste del encabezado; no registra una nueva ejecución de los 19 casos.

El campo de sección se ajustó después a `Miércoles`, siguiendo el formato del ejemplo indicado por el estudiante. Se comprobó que el texto posterior al comentario inicial sigue idéntico; las pruebas documentadas conservan sus versiones y registros originales.

`BITACORA.md` vincula estos avances con su evidencia y sus pendientes.
