# Reto 07 — Agua: recuperación de reservas

Eliezer Daniels Santana — Matrícula 20250442.

## Contenido para la entrega

| Archivo o carpeta | Contenido |
| --- | --- |
| `20250442.c` | Programa completo en C |
| `ANALISIS.md` | Entradas, salidas, restricciones, variables y pseudocódigo |
| `PRUEBA_ESCRITORIO.md` | Seguimiento manual de eventos, impactos y rachas |
| `PRUEBAS_PROPIAS.md` | Dos pruebas propias con entrada, salida esperada y justificación |
| `RESULTADOS_PRUEBAS.md` | Registro de ejecuciones y comparación con resultados esperados |
| `BITACORA.md` | Revisiones, decisiones justificadas y avances con su evidencia |
| `pruebas/` | 17 pares oficiales y dos pares propios de entrada/salida |
| `resultados/` | Salidas reales obtenidas y registro de compilación |
| `evidencias/windows/` | Capturas y registros de la compilación local, del caso 16 y de los 19 casos en Windows |
| `verificar_pruebas_windows.ps1` | Comprobación de los 19 casos y guardado de nuevas salidas en Windows |
| `material_original/` | Enunciado, rúbrica y datos originales de esta matrícula |
| `GUIA_CODIGO.md` | Explicación del programa para estudiar |

El programa solo usa `stdio.h`, variables, arreglos fijos, condicionales y ciclos dentro de `main`.

## Requisitos generales añadidos por el profesor

El encabezado obligatorio está al principio de `20250442.c`. Incluye los datos conocidos del estudiante y marca PENDIENTE para la sección y el enlace real del Code Challenge. Esos dos campos deben completarse antes de entregar.

El programa incluye una descripción de `main(void)`, de sus entradas por consola y de su retorno, además de comentarios en las partes que definen el algoritmo. La explicación del alumno vale el 50 % de los criterios generales compartidos; `GUIA_CODIGO.md` ayuda a prepararla.

`GUIA_GITHUB.md` contiene los pasos para clonar el repositorio con GitHub Desktop, probar el programa y registrar los cambios posteriores.

## Compilar y ejecutar

Desde la carpeta del proyecto, en una terminal con GCC instalado:

```bash
gcc -std=c11 -Wall -Wextra 20250442.c -o reto
./reto < pruebas/caso_16.in
```

Para Windows:

```text
gcc -std=c11 -Wall -Wextra 20250442.c -o reto.exe
```

En el Símbolo del sistema, ejecutar:

```text
reto.exe < pruebas\caso_16.in
```

En PowerShell, la redirección de entrada de este ejemplo se puede ejecutar mediante:

```text
cmd /c "reto.exe < pruebas\caso_16.in"
```

La salida de ese caso debe ser:

```text
FILA 1 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 2 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 3 EVENTOS 1 IMPACTO 44 RACHA 1 INICIO 3
COLUMNAS 0 0 1 0 0
PRIORIDAD 3
COLUMNA 3
```

El 06/10/2026 se compiló el programa y se comprobó visualmente el caso 16 en la computadora del estudiante; esa [primera prueba](evidencias/windows/PRIMERA_PRUEBA.md) está documentada. Después se ejecutó el verificador completo: las 17 pruebas oficiales y las dos propias mostraron coincidencia, todas con código de salida 0. La [captura de los 19 casos y su registro](evidencias/windows/PRUEBAS_COMPLETAS.md) conservan ese resultado.

Las salidas reales, el entorno, el registro de compilación y el resumen están publicados en [resultados de Windows](resultados/windows/ejecucion_20261006_103035_034), incorporados mediante el commit `00366ac`. Se revisaron los 19 archivos de salida frente a sus esperados: todos coinciden al normalizar únicamente CRLF a LF. Los archivos de errores y el registro de compilación están vacíos.

Para ejecutar la comprobación desde PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\verificar_pruebas_windows.ps1
```

El script vuelve a compilar y guarda una carpeta nueva en `resultados/windows/` con el entorno, los diagnósticos de compilación, las salidas de los 19 casos y el resumen. La comparación conserva todo el texto y normaliza solo CRLF a LF. Antes de registrar el avance, revisa el resumen real y cualquier caso marcado `REVISAR`.

También se pueden escribir directamente los datos numéricos en la consola al ejecutar el programa. No aparece una pregunta para pedirlos porque el formato de salida lo prohíbe. Cada ejecución procesa un solo caso.

## Git y GitHub

El proyecto está publicado en este repositorio. El historial comienza con un commit de importación de la versión actual, que ya contiene el programa completo. Registra los cambios posteriores del programa, la documentación y las pruebas mediante nuevos commits.

`BITACORA.md` documenta las revisiones desde esa versión, sus motivos, la evidencia disponible y los pendientes. Añade una entrada después de realizar cada avance y describe el cambio real en el commit correspondiente.

Para ver el historial:

```text
git log --oneline
```

Para tus próximos cambios, configura tu nombre y el correo de tu cuenta o el correo privado de GitHub. Reemplaza el texto del correo por el real:

```text
git config user.name "Eliezer Daniels Santana"
git config user.email "TU_CORREO_DE_GITHUB"
```

Si borraste la carpeta `.git` de tu copia local, recupera el historial clonando el repositorio en una carpeta nueva:

```text
git clone https://github.com/eliezerdsantana/reto07-agua-20250442.git reto07-agua-recuperado
cd reto07-agua-recuperado
```

Conserva la carpeta anterior y copia a la nueva únicamente los archivos que hayas modificado. Configura tu nombre y correo dentro de la carpeta recuperada antes del siguiente commit.

Para registrar y subir cada cambio posterior:

```text
git add 20250442.c ANALISIS.md PRUEBA_ESCRITORIO.md PRUEBAS_PROPIAS.md RESULTADOS_PRUEBAS.md BITACORA.md
git commit -m "Describir el cambio real realizado"
git push
```

Incluye también `README.md` y los nuevos archivos de prueba o evidencia en `git add` cuando los modifiques o crees. Cambia el mensaje del commit para describir el avance concreto.

## Nota sobre los puntos

La actividad que compartiste indica 10 puntos; el PDF y la rúbrica indican 25. Los materiales no explican cómo se relacionan esas escalas. Conviene aclararlo con el profesor. Los entregables preparados siguen todos los criterios del PDF.
