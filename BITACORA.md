# Bitácora del proceso — Reto 07

Estudiante: Eliezer Daniels Santana. Matrícula: 20250442.

Este registro documenta las revisiones y los avances a partir de la versión importada en el commit `61856f9`. Esa versión ya contiene el programa completo, el análisis y las pruebas. Las entradas siguientes describen el trabajo realizado en sus fechas; no reconstruyen etapas anteriores de programación.

## 06/10/2026 — Revisión del estado actual

### Trabajo realizado

Se contrastaron `20250442.c`, el análisis, la prueba de escritorio y las pruebas propias con `material_original/Enunciado_y_rubrica.pdf`. También se revisaron las instrucciones del README y el registro de resultados.

La copia de GitHub Desktop mostrada en esta fecha reconoce la rama `main` y el commit de importación `61856f9`, atribuido a `eliezerdsantana`. La clonación quedó completada.

### Revisión y justificación del algoritmo

| Parte | Resultado de la revisión | Justificación |
| --- | --- | --- |
| Lectura y validación | Se comprueban las dimensiones antes de acceder a la matriz y se validan los niveles antes del informe. | Una entrada inválida debe producir únicamente `ERROR`, incluso si el dato incorrecto está al final. |
| Eventos | La condición es `j >= 1 && matriz[i][j - 1] < L && matriz[i][j] >= U`. | El valor anterior debe ser estrictamente menor que L; el actual puede ser igual a U. La primera columna no tiene anterior. |
| Impacto y conteos | Se acumula actual menos anterior únicamente dentro de la condición de evento. El evento se cuenta en la columna actual. | Las posiciones sin evento aportan cero. Los niveles originales se conservan. |
| Rachas | Se reinicia la racha actual ante una posición sin evento y se guarda el inicio solo al encontrar una racha mayor. | La actualización con `>` conserva el inicio más temprano cuando hay empate. |
| Prioridad | Se comparan racha, impacto y cantidad de eventos, en ese orden. | Al recorrer las filas de menor a mayor y conservar la anterior en empate completo, gana la fila de menor número. |
| Columna destacada | Se actualiza solo cuando una columna tiene más eventos. | El recorrido ascendente conserva la columna de menor número en empate. |
| Ausencia de eventos | Prioridad y columna permanecen en cero. | Es el resultado exigido cuando ninguna posición cumple la regla. |
| Formato | Se imprimen las etiquetas del PDF, con índices desde 1 y sin preguntas ni menús. | La comparación con los archivos esperados exige respetar espacios, orden y saltos de línea. |

No se identificó un error de lógica frente al contrato del PDF durante esta revisión. Por ello, no se modificó el algoritmo.

Los vectores de resúmenes comienzan en cero mediante `{0}`. La matriz tiene capacidad fija de 30 por 30 y solo se utiliza la parte indicada por N y M. El acumulador de impacto es `long` y su formato de impresión es `%ld`, conforme al requisito de capacidad de al menos 32 bits.

Una particularidad que debe poder explicarse: dos eventos consecutivos son imposibles en este reto. Tras un evento, el valor actual satisface `x >= U >= L`; para producir otro evento inmediatamente después, ese mismo valor tendría que ser menor que L. Aunque la mayor racha solo puede ser cero o uno, se conserva el seguimiento que exige la rúbrica.

### Evidencia revisada y alcance

`RESULTADOS_PRUEBAS.md` y `resultados/` contienen el registro previo de 17 pruebas oficiales y dos propias ejecutadas con GCC en Linux, con salidas coincidentes. Esta entrada documenta la revisión de esa evidencia; no registra una nueva ejecución de esos casos ni atribuye esas ejecuciones a la computadora del estudiante.

La prueba de escritorio y las dos pruebas propias incluyen entrada, salida esperada y justificación. El PDF garantiza entradas numéricas completas para dimensiones y límites válidos; no evalúa texto, entradas truncadas ni tokens adicionales.

### Cambios de documentación de esta revisión

- Se creó esta bitácora para vincular cada avance con su motivo y su evidencia.
- Se añadió su referencia al README y se ajustó la descripción de la guía de GitHub.
- Se corrigió el estado de publicación en el documento de resultados: el repositorio ya está publicado; la verificación en la computadora del estudiante sigue pendiente.

### Próximos avances

| Avance pendiente | Motivo | Evidencia que debe registrarse al completarlo |
| --- | --- | --- |
| Confirmar sección y enlace real de la actividad, y completar el encabezado. | Ambos campos siguen marcados PENDIENTE en el fuente. | Diferencia del encabezado y commit que describa los datos completados. |
| Compilar en la computadora del estudiante. | Comprobar que el compilador local funciona con la versión actual. | Versión de GCC, comando utilizado y resultado real de compilación. |
| Ejecutar las 17 pruebas oficiales y las dos propias en esa computadora. | Verificar la instalación y conservar evidencia local de las salidas. | Salidas obtenidas, comparación con las esperadas y capturas si se solicitan. |
| Explicar y revisar el algoritmo por bloques. | Justificar la validación, la regla, las rachas y los desempates. | Notas de comprensión y recorrido manual de una entrada. |
| Confirmar acceso del profesor y requisitos de entrega. | El repositorio es privado y la actividad indica 10 puntos, mientras que el PDF presenta 25. | Acceso confirmado y requisitos aclarados antes de entregar. |

## 06/10/2026 — Preparación de Windows, compilación y caso 16

### Trabajo realizado y motivo

La terminal PowerShell no reconocía Git. Se instaló Git para Windows y se eligió su uso desde la línea de comandos y aplicaciones externas. Tras cerrar y abrir Visual Studio Code, `git --version` mostró `git version 2.56.0.windows.2`.

Se compiló el programa desde la carpeta del repositorio con `gcc -std=c11 -Wall -Wextra 20250442.c -o reto.exe`. La compilación regresó al indicador de la terminal sin errores ni advertencias visibles y creó el ejecutable.

Se ejecutó `cmd /c "reto.exe < pruebas\caso_16.in"`. La revisión de la salida visible frente a `pruebas/caso_16.out` mostró coincidencia en las seis líneas del informe. El único evento está en la fila 3, columna 3: 1 < 13 y 45 >= 15, con impacto 44.

### Evidencia y alcance

La captura y los detalles están en [Primera comprobación local en Windows](evidencias/windows/PRIMERA_PRUEBA.md). Es una ejecución real en la computadora del estudiante; el cotejo realizado a partir de esa captura es visual.

Se añadió `verificar_pruebas_windows.ps1` para facilitar la comprobación completa: compila, ejecuta los 19 casos y guarda los resultados en una carpeta nueva por ejecución. Su ejecución en Windows sigue pendiente. La comparación normaliza únicamente CRLF a LF y conserva el resto del formato.

### Cambios y pendientes

Se incorporaron la captura original, el registro de esta prueba y el script de comprobación. Se actualizaron el README y el documento de resultados para reflejar la compilación local y el caso 16 comprobados. El algoritmo y los datos de prueba permanecen sin cambios.

La compilación local ya está completada. La ejecución y comparación de los 19 casos en Windows, los dos campos del encabezado, la preparación de la explicación del algoritmo y la confirmación del acceso del profesor siguen pendientes.

## 06/10/2026 — Comprobación de los 19 casos en Windows

### Trabajo realizado y motivo

Se ejecutó `verificar_pruebas_windows.ps1` en la laptop del estudiante, desde PowerShell dentro de la carpeta del repositorio. El script recompiló el programa, ejecutó las 17 pruebas oficiales y las dos propias, y comparó sus salidas con los archivos esperados.

La captura muestra `COINCIDE CODIGO 0` para cada caso y el resumen `Resultado: 19 de 19 casos coinciden.`. Esta comprobación completa la ejecución local que estaba pendiente en las entradas anteriores.

### Evidencia y alcance

La [captura original y su registro](evidencias/windows/PRUEBAS_COMPLETAS.md) documentan el resultado del verificador. La comparación del script es sensible a mayúsculas y conserva espacios, orden de líneas y salto final; normaliza únicamente CRLF a LF. Para marcar un caso como coincidente también exige código de salida 0 y ausencia de texto en la salida de errores.

La carpeta indicada por la ejecución es `resultados/windows/ejecucion_20261006_103035_034`. Contiene las nuevas salidas y registros generados en la laptop; su incorporación a GitHub y la revisión de esos archivos siguen pendientes. La captura y el resumen visible ya se revisaron.

### Cambios y pendientes

Se guardó la captura original y se actualizaron el README, el registro de resultados y esta bitácora. El registro de la primera prueba enlaza ahora la comprobación posterior. No se modificaron el fuente, el script ni los datos de prueba.

Los 19 casos están comprobados en Windows. Sigue pendiente subir los archivos reales de esa ejecución, completar sección y enlace de la actividad en el encabezado, preparar la explicación del algoritmo y confirmar el acceso del profesor y los requisitos de entrega.

## 06/10/2026 — Publicación y revisión de las evidencias de Windows

### Trabajo realizado y motivo

En la laptop se creó el commit `00366ac`, con el mensaje «Guardar resultados de 19 pruebas ejecutadas en Windows», y se subió a GitHub. Autor y committer figuran como `eliezerdsantana`. Su padre es `3cd8574`, por lo que el avance continúa el historial existente.

El commit incorpora 42 archivos de `resultados/windows/ejecucion_20261006_103035_034`: 19 salidas obtenidas, 19 archivos de errores, registros de entorno, compilación y resumen, y una regla `.gitattributes` con `* -text`. Esta regla permite conservar los saltos de línea originales de los archivos de evidencia al registrarlos en Git.

### Comprobaciones sobre los archivos publicados

| Comprobación | Resultado |
| --- | --- |
| Salidas obtenidas frente a las esperadas | 17 oficiales y dos propias coinciden al normalizar únicamente CRLF a LF. |
| Formato | Se conservan espacios, mayúsculas, orden de líneas y salto final. |
| Salida de errores | Los 19 archivos están vacíos. |
| Diagnósticos de compilación | El registro está vacío; el resumen registra código 0. |
| Resumen | Contiene los 19 casos previstos, todos con código 0 y coincidencia. |
| Fuente de la ejecución | Su SHA256 corresponde al programa publicado con los saltos CRLF de la copia local. |
| Alcance del commit | Solo se incorporan los 42 archivos de evidencia; el fuente, el script y las pruebas esperadas conservan su contenido. |

El registro de entorno sitúa la ejecución el 06/10/2026 a las 10:30:35 (UTC−04:00), con GCC 16.1.0 de MSYS2 y la versión `5d5f836` del repositorio. Los cambios posteriores previos a la publicación de resultados afectan a la documentación y conservan el mismo programa.

Los archivos reales están en [resultados de Windows](resultados/windows/ejecucion_20261006_103035_034); la captura y el detalle están en [Comprobación completa en Windows](evidencias/windows/PRUEBAS_COMPLETAS.md). Esta revisión coteja los archivos de la ejecución ya realizada; no registra una ejecución nueva de los casos.

### Cambios de documentación y pendientes

Se actualizaron el README, el registro de resultados, el detalle de la comprobación completa y esta bitácora para reflejar que las evidencias ya están publicadas y revisadas.

La compilación, los 19 casos y su publicación están completados. Siguen pendientes la sección y el enlace real de la actividad en el encabezado, la preparación de la explicación del algoritmo y la confirmación del acceso del profesor y los requisitos de entrega.

## 06/10/2026 — Incorporación del enlace de la actividad y el día de clase

### Datos recibidos y cambio realizado

El estudiante proporcionó el enlace [Code Challenge en el Aula Virtual](https://aulavirtual.itla.edu.do/mod/assign/view.php?id=253496) e indicó que su clase es los miércoles. No conoce todavía el número oficial de sección.

Se sustituyó el enlace pendiente del encabezado por esa dirección. La sección conserva `PENDIENTE DE CONFIRMAR` y añade `clase de los miércoles`, que es el dato disponible. El día de clase no permite deducir el número de sección.

### Justificación y comprobación

El enlace identifica la actividad del curso y permite completar ese campo con el dato proporcionado. La sección se mantiene pendiente para distinguir el día conocido del identificador aún no confirmado.

Se comprobó que todo el texto posterior al comentario inicial de `20250442.c` es idéntico al de la versión anterior. La revisión de sintaxis se realizó en Linux con:

```text
gcc -std=c11 -Wall -Wextra -Wpedantic -Werror -fsyntax-only 20250442.c
```

El comando terminó con código 0 y sin diagnósticos. Esta revisión corresponde a la modificación del encabezado; no es una nueva ejecución de las 19 pruebas.

Se actualizaron el README y las guías para reflejar el enlace incorporado y la sección aún pendiente. Los documentos de resultados precisan que las evidencias de Windows corresponden a la versión `5d5f836`, con el encabezado anterior. Sus instrucciones de C son las mismas y los registros conservan la fecha, la versión y la huella originales.

### Pendientes

Confirmar el número oficial de sección, preparar la explicación del algoritmo y confirmar el acceso del profesor y los requisitos de entrega. El enlace de la actividad ya está incorporado.

## 06/10/2026 — Ajuste de la sección al formato del ejemplo

### Cambio y justificación

El estudiante indicó que el ejemplo identifica la sección con el día de clase y solicitó usar únicamente `Miércoles`. Se sustituyó la línea anterior del encabezado por `Sección: Miércoles`.

La sección queda completada con ese formato. Las entradas anteriores conservan el estado de la revisión en sus momentos; a partir de este avance, la búsqueda de un número de sección deja de figurar como pendiente.

### Comprobación y documentación

Se comparó el texto posterior al comentario inicial de `20250442.c` con la versión anterior: es idéntico. El cambio en el fuente afecta únicamente a la línea de sección del encabezado. Los registros de las pruebas conservan la fecha, la versión y la huella del programa que se ejecutó.

Se actualizaron el README, las guías y los documentos de resultados para reflejar `Miércoles` y retirar el número de sección de los pendientes actuales.

### Pendientes

Preparar la explicación del algoritmo y confirmar el acceso del profesor y los requisitos de entrega. El encabezado incluye los datos de identificación y el enlace de la actividad.

## 06/10/2026 — Ampliación de la guía para estudiar el programa desde cero

### Trabajo realizado y motivo

Se amplió [GUIA_CODIGO.md](GUIA_CODIGO.md) para explicar el programa completo con lenguaje sencillo. El estudiante solicitó una explicación desde el principio, incluyendo los símbolos y conceptos que utiliza el código.

La guía utiliza el caso oficial 16 como ejemplo continuo. Explica la tabla de niveles, variables y arreglos, índices desde cero, lectura y validación, ciclos, condición de recuperación, contadores, impacto, rachas, desempates y formato de salida. Incluye el ejemplo de desempates de la prueba propia 02 y un modelo de explicación oral para practicar.

### Comprobación y alcance

Se cotejaron la entrada y la salida presentadas para el caso 16 con sus archivos oficiales. El recorrido identifica el evento de la fila 3, columna 3 y el impacto 44. Se revisaron las explicaciones contra el fuente actual, incluyendo el uso de long, la evaluación de && y la imposibilidad de eventos consecutivos con L <= U.

Este avance modifica únicamente la guía y esta bitácora. El código fuente, los datos de prueba, el verificador y las evidencias de Windows se conservan. No se registra una nueva ejecución de las pruebas.

### Pendientes

Repasar la guía y preparar una explicación propia del algoritmo. La comprensión del estudiante y la defensa oral todavía no se han evaluado. También sigue pendiente confirmar el acceso del profesor y los requisitos de entrega.

## Cómo registrar un avance siguiente

Añadir una entrada cuando el trabajo se haya realizado, usando la fecha real. Cada entrada debe indicar qué cambió, por qué se hizo, cómo se comprobó y qué sigue pendiente. El commit correspondiente debe describir ese cambio concreto. Una tarea pendiente no debe anotarse como terminada.

Para una prueba, conservar por separado su entrada, la salida esperada y la salida obtenida. Documentar la comparación, incluyendo cualquier diferencia encontrada y su corrección.
