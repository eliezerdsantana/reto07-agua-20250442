/********************************************************************
 * Programación para mecatrónicos
 * Nombre: Eliezer Daniels Santana
 * Matrícula: 20250442
 * Sección: Miércoles
 * Práctica: Code Challenge - Primer parcial - Reto 07
 * Fecha: 05/10/2026
 * Link práctica: https://aulavirtual.itla.edu.do/mod/assign/view.php?id=253496
 ********************************************************************/

#include <stdio.h>

#define MAXIMO 30

/**
 * @brief Analiza niveles de agua y genera un informe de recuperación.
 *
 * Parámetros de la función: ninguno; se declara como main(void).
 * Entrada por consola: N, M, L, U y N filas de M niveles enteros.
 * Salida por consola: eventos, impactos y rachas de cada fila,
 * conteos por columna, fila prioritaria y columna destacada.
 *
 * @return 0 al terminar. Los datos inválidos se indican imprimiendo ERROR.
 * Criterio de éxito: validar la entrada y respetar el formato del informe.
 */
int main(void) {
    int N, M, L, U;
    int matriz[MAXIMO][MAXIMO];
    /* Cada vector guarda un resumen; {0} inicializa todas sus posiciones. */
    int eventos_fila[MAXIMO] = {0};
    long impacto_fila[MAXIMO] = {0};
    int racha_fila[MAXIMO] = {0};
    int inicio_fila[MAXIMO] = {0};
    int eventos_columna[MAXIMO] = {0};
    int total_eventos = 0;
    int prioridad = 0;
    int columna = 0;
    int i, j;

    /* scanf debe leer los cuatro datos de la cabecera de entrada. */
    if (scanf("%d %d %d %d", &N, &M, &L, &U) != 4) {
        printf("ERROR\n");
        return 0;
    }

    /* Validar dimensiones antes de acceder a la matriz. */
    if (N < 1 || N > MAXIMO || M < 1 || M > MAXIMO ||
        L < 0 || L > U || U > 1000) {
        printf("ERROR\n");
        return 0;
    }

    /* Validar todos los niveles antes de imprimir cualquier resultado. */
    for (i = 0; i < N; i++) {
        for (j = 0; j < M; j++) {
            if (scanf("%d", &matriz[i][j]) != 1 ||
                matriz[i][j] < 0 || matriz[i][j] > 1000) {
                printf("ERROR\n");
                return 0;
            }
        }
    }

    /* Recorrer horizontalmente cada fila sin cambiar los niveles originales. */
    for (i = 0; i < N; i++) {
        int racha_actual = 0;
        int inicio_actual = 0;

        for (j = 0; j < M; j++) {
            /* Evento: anterior < L y actual >= U, desde la segunda columna.
               && evita acceder a j - 1 cuando j es cero. */
            if (j >= 1 && matriz[i][j - 1] < L && matriz[i][j] >= U) {
                /* Sumar solo los eventos y sus saltos al resumen de la fila. */
                eventos_fila[i]++;
                impacto_fila[i] += (long)matriz[i][j] - matriz[i][j - 1];
                /* El evento pertenece a la columna del valor actual. */
                eventos_columna[j]++;
                total_eventos++;

                /* Guardar el inicio con indice desde 1 al comenzar una racha. */
                if (racha_actual == 0) {
                    inicio_actual = j + 1;
                }
                racha_actual++;

                /* Solo una racha mayor reemplaza a la primera maxima. */
                if (racha_actual > racha_fila[i]) {
                    racha_fila[i] = racha_actual;
                    inicio_fila[i] = inicio_actual;
                }
            } else {
                /* Una posicion sin evento interrumpe la racha en curso. */
                racha_actual = 0;
            }
        }
    }

    /* Sin eventos, prioridad y columna conservan el valor cero. */
    if (total_eventos > 0) {
        for (i = 0; i < N; i++) {
            if (eventos_fila[i] > 0) {
                if (prioridad == 0) {
                    prioridad = i + 1;
                } else {
                    int mejor = prioridad - 1;
                    int es_mejor = 0;

                    /* Comparar en orden: racha, impacto y cantidad de eventos. */
                    if (racha_fila[i] > racha_fila[mejor]) {
                        es_mejor = 1;
                    } else if (racha_fila[i] == racha_fila[mejor]) {
                        if (impacto_fila[i] > impacto_fila[mejor]) {
                            es_mejor = 1;
                        } else if (impacto_fila[i] == impacto_fila[mejor] &&
                                   eventos_fila[i] > eventos_fila[mejor]) {
                            es_mejor = 1;
                        }
                    }

                    /* En empate completo se conserva la fila anterior. */
                    if (es_mejor) {
                        prioridad = i + 1;
                    }
                }
            }
        }

        /* Recorrer en orden y actualizar solo si hay mas eventos:
           los empates conservan la columna de menor numero. */
        for (j = 0; j < M; j++) {
            if (eventos_columna[j] > 0) {
                if (columna == 0) {
                    columna = j + 1;
                } else if (eventos_columna[j] > eventos_columna[columna - 1]) {
                    columna = j + 1;
                }
            }
        }
    }

    /* Imprimir etiquetas exactas e indices desde 1. %ld corresponde a long. */
    for (i = 0; i < N; i++) {
        printf("FILA %d EVENTOS %d IMPACTO %ld RACHA %d INICIO %d\n",
               i + 1, eventos_fila[i], impacto_fila[i],
               racha_fila[i], inicio_fila[i]);
    }

    printf("COLUMNAS");
    for (j = 0; j < M; j++) {
        printf(" %d", eventos_columna[j]);
    }
    printf("\nPRIORIDAD %d\nCOLUMNA %d\n", prioridad, columna);

    return 0;
}
