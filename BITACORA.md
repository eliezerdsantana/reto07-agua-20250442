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

## Cómo registrar un avance siguiente

Añadir una entrada cuando el trabajo se haya realizado, usando la fecha real. Cada entrada debe indicar qué cambió, por qué se hizo, cómo se comprobó y qué sigue pendiente. El commit correspondiente debe describir ese cambio concreto. Una tarea pendiente no debe anotarse como terminada.

Para una prueba, conservar por separado su entrada, la salida esperada y la salida obtenida. Documentar la comparación, incluyendo cualquier diferencia encontrada y su corrección.
