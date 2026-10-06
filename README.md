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
| `pruebas/` | 17 pares oficiales y dos pares propios de entrada/salida |
| `resultados/` | Salidas reales obtenidas y registro de compilación |
| `material_original/` | Enunciado, rúbrica y datos originales de esta matrícula |
| `GUIA_CODIGO.md` | Explicación del programa para estudiar |

El programa solo usa `stdio.h`, variables, arreglos fijos, condicionales y ciclos dentro de `main`.

## Requisitos generales añadidos por el profesor

El encabezado obligatorio está al principio de `20250442.c`. Incluye los datos conocidos del estudiante y marca PENDIENTE para la sección y el enlace real del Code Challenge. Esos dos campos deben completarse antes de entregar.

El programa incluye una descripción de `main(void)`, de sus entradas por consola y de su retorno, además de comentarios en las partes que definen el algoritmo. La explicación del alumno vale el 50 % de los criterios generales compartidos; `GUIA_CODIGO.md` ayuda a prepararla.

`GUIA_GITHUB.md` contiene los pasos completos para crear la cuenta, publicar el proyecto con GitHub Desktop y registrar tus cambios posteriores.

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

También se pueden escribir directamente los datos numéricos en la consola al ejecutar el programa. No aparece una pregunta para pedirlos porque el formato de salida lo prohíbe. Cada ejecución procesa un solo caso.

## Git y GitHub

El proyecto está publicado en este repositorio. El historial comienza con un commit de importación de la versión actual. Registra los cambios posteriores del programa, la documentación y las pruebas mediante nuevos commits.

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
git add 20250442.c ANALISIS.md PRUEBA_ESCRITORIO.md PRUEBAS_PROPIAS.md RESULTADOS_PRUEBAS.md
git commit -m "Describir el cambio real realizado"
git push
```

Incluye también `README.md` y los nuevos archivos de prueba o evidencia en `git add` cuando los modifiques o crees. Cambia el mensaje del commit para describir el avance concreto.

## Nota sobre los puntos

La actividad que compartiste indica 10 puntos; el PDF y la rúbrica indican 25. Los materiales no explican cómo se relacionan esas escalas. Conviene aclararlo con el profesor. Los entregables preparados siguen todos los criterios del PDF.
