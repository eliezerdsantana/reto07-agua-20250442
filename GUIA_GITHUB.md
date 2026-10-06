# Guía de principio a fin: proyecto, pruebas y GitHub

## Ruta de trabajo

1. Conservar la carpeta anterior de tu computadora.
2. Iniciar sesión en tu cuenta de GitHub y configurar GitHub Desktop.
3. Clonar el repositorio publicado en una carpeta nueva.
4. Completar el encabezado con tu sección y el enlace real del Code Challenge.
5. Ejecutar las pruebas en tu computadora y registrar evidencias y avances reales.
6. Preparar la explicación del programa y entregar el enlace y los archivos solicitados.

Un repositorio guarda el proyecto y el historial de sus cambios. Un commit registra una versión con un mensaje que explica el cambio. Hacer push envía esos commits desde tu computadora a GitHub.

## 1. Conservar la carpeta anterior

Conserva tu carpeta actual para no perder cambios locales. Si borraste su carpeta `.git`, esa copia ya no contiene el historial ni la configuración del repositorio.

Recupera el proyecto mediante una clonación en una carpeta distinta, por ejemplo `reto07-agua-recuperado`. La copia clonada contiene el código, la documentación, las pruebas y la carpeta `.git`.

## 2. Iniciar sesión

Abre [GitHub](https://github.com/) e inicia sesión con la cuenta propietaria del proyecto, `eliezerdsantana`.

El repositorio del trabajo es [reto07-agua-20250442](https://github.com/eliezerdsantana/reto07-agua-20250442).

## 3. Configurar GitHub Desktop

Si todavía no tienes GitHub Desktop, utiliza la [descarga oficial](https://desktop.github.com/download/).

Abre la aplicación e inicia sesión en GitHub.com. En Windows, revisa File > Options > Git. Configura como nombre de autor `Eliezer Daniels Santana` y utiliza un correo de tu cuenta de GitHub o el correo privado que GitHub te proporcione.

Esa configuración se aplica a los commits nuevos que hagas desde la aplicación.

## 4. Clonar el repositorio publicado

En GitHub Desktop:

1. Selecciona File > Clone repository.
2. Abre la pestaña URL.
3. Introduce `https://github.com/eliezerdsantana/reto07-agua-20250442.git`.
4. En Local path, elige una carpeta nueva, distinta de tu copia anterior.
5. Haz clic en Clone.
6. Revisa la pestaña History: inicialmente debe mostrar el commit de importación de la versión actual del proyecto.

Si tienes cambios locales pendientes, copia únicamente los archivos que modificaste desde la carpeta anterior hacia la nueva. Revisa la pestaña Changes antes de registrar esos cambios.

## 5. Comprobar el repositorio

El proyecto ya está publicado en GitHub. Comprueba que la copia clonada contiene `20250442.c`, `README.md`, los documentos y las carpetas de pruebas y resultados.

El repositorio es privado. Confirma qué acceso necesita el profesor para evaluarlo y utiliza el enlace de este mismo repositorio en la entrega.

## 6. Abrir y probar en VS Code

En VS Code, usa Archivo > Abrir carpeta y selecciona la carpeta del proyecto. Abre `20250442.c` y completa la sección y el enlace de la actividad en el encabezado.

Abre una terminal de VS Code. Comprueba si tienes GCC:

```text
gcc --version
```

Si muestra una versión, compila:

```text
gcc -std=c11 -Wall -Wextra 20250442.c -o reto.exe
```

Si indica que no reconoce gcc, comparte el mensaje para configurar el compilador antes de continuar. VS Code edita el código; el compilador es el programa que lo convierte en un ejecutable.

Para ejecutar el caso 16 desde PowerShell:

```text
cmd /c "reto.exe < pruebas\caso_16.in"
```

Debe mostrar:

```text
FILA 1 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 2 EVENTOS 0 IMPACTO 0 RACHA 0 INICIO 0
FILA 3 EVENTOS 1 IMPACTO 44 RACHA 1 INICIO 3
COLUMNAS 0 0 1 0 0
PRIORIDAD 3
COLUMNA 3
```

Después ejecuta los otros casos, cambiando el nombre del archivo `.in`. Compara cada resultado con su `.out`. La versión preparada ya pasó los 19 casos en el entorno de preparación; las ejecuciones en tu computadora servirán para comprobar tu instalación y producir tus evidencias.

Puedes guardar una salida real de tu computadora en un archivo nuevo:

```text
cmd /c "reto.exe < pruebas\propia_01.in > resultados\propia_01_mi_pc.txt"
```

La redirección `>` escribe el resultado en el archivo indicado. También puedes tomar capturas de las ejecuciones si el profesor exige imágenes. Los archivos de texto y las capturas deben representar pruebas que hayas ejecutado.

## 7. Registrar cada avance real

Después de completar el encabezado, guardar nuevas evidencias o mejorar una explicación:

1. Guarda los archivos en VS Code.
2. Vuelve a GitHub Desktop y revisa los cambios mostrados.
3. Escribe un mensaje concreto en Summary, por ejemplo `Completar seccion y enlace del encabezado` o `Agregar resultados de pruebas ejecutadas en mi computadora`.
4. Haz clic en Commit to main, si la rama seleccionada es main.
5. Haz clic en Push origin para enviarlo a GitHub.
6. Comprueba el cambio en el repositorio de la web.

Un commit guarda el avance localmente; Push origin lo sube. Realiza ambos durante tu trabajo, como pide la actividad. La primera versión reúne el estado actual del proyecto; registra tus propias correcciones y pruebas a medida que las realices.

## 8. Preparar la explicación

Lee `GUIA_CODIGO.md` y practica con las dos pruebas propias. Debes poder explicar:

- Qué representan N, M, L, U, la matriz y cada vector.
- Por qué se valida toda la matriz antes de imprimir el informe.
- Cómo funciona la condición del evento y por qué la primera columna se excluye.
- Cómo se calcula y suma el impacto.
- Cómo se interrumpe una racha y se conserva su inicio más temprano.
- Cómo se resuelven los desempates de filas y columnas.
- Por qué los índices de los arreglos empiezan en 0 y los impresos en 1.
- Qué ocurre cuando no hay eventos o la entrada es inválida.

La explicación representa el 50 % de los criterios generales que compartiste. Para practicar, cambia mentalmente un número de una prueba, predice qué resultados cambiarían y verifica tu predicción ejecutando el programa.

## 9. Entregar

Antes de entregar, comprueba que el encabezado tenga todos tus datos y el enlace correcto; que el código compile en tu computadora; que aparezcan los documentos y las evidencias en GitHub; y que el profesor pueda abrir el repositorio.

Entrega el archivo `20250442.c`, el enlace del repositorio y los documentos o archivos que solicite la actividad en su casilla de entrega. El enlace mostrado en las normas generales pertenece al Proyecto Final: el campo Link práctica de este código debe contener la dirección del Code Challenge correspondiente.

## Documentación oficial consultada

- [Introducción a la cuenta de GitHub](https://docs.github.com/es/get-started/onboarding/getting-started-with-your-github-account).
- [Configurar GitHub Desktop](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/setting-up-github-desktop).
- [Clonar un repositorio con GitHub Desktop](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository?tool=desktop).
- [Publicar un proyecto existente con GitHub Desktop](https://docs.github.com/en/desktop/adding-and-cloning-repositories/adding-an-existing-project-to-github-using-github-desktop).
- [Configurar Git para GitHub Desktop](https://docs.github.com/en/desktop/configuring-and-customizing-github-desktop/configuring-git-for-github-desktop).
- [Registrar y revisar cambios](https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop).
