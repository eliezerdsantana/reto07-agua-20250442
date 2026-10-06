# Comprueba los 17 casos oficiales y las dos pruebas propias en Windows.
# Guarda una carpeta nueva por ejecucion para conservar la evidencia anterior.
$ErrorActionPreference = 'Stop'
$ubicacionAnterior = Get-Location
$codigoFinal = 1

try {
    Set-Location -LiteralPath $PSScriptRoot
    Get-Command gcc -CommandType Application -ErrorAction Stop | Out-Null
    Get-Command git -CommandType Application -ErrorAction Stop | Out-Null

    $casos = @()
    for ($i = 1; $i -le 17; $i++) {
        $casos += ('caso_{0:D2}' -f $i)
    }
    $casos += 'propia_01', 'propia_02'

    foreach ($caso in $casos) {
        if (!(Test-Path -LiteralPath ("pruebas\$caso.in") -PathType Leaf) -or
            !(Test-Path -LiteralPath ("pruebas\$caso.out") -PathType Leaf)) {
            throw "Falta la entrada o la salida esperada de $caso."
        }
    }

    $nombreEjecucion = 'ejecucion_' + (Get-Date -Format 'yyyyMMdd_HHmmss_fff')
    $carpeta = Join-Path 'resultados\windows' $nombreEjecucion
    New-Item -ItemType Directory -Path $carpeta -ErrorAction Stop | Out-Null
    $carpetaAbsoluta = Join-Path $PSScriptRoot $carpeta
    $utf8 = New-Object System.Text.UTF8Encoding -ArgumentList $false

    $versionGcc = (& gcc --version | Out-String).TrimEnd()
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo consultar la version de GCC.' }
    $versionGit = (& git --version | Out-String).TrimEnd()
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo consultar la version de Git.' }
    $commit = (& git rev-parse HEAD | Out-String).TrimEnd()
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo identificar el commit local.' }
    $hashFuente = (Get-FileHash -LiteralPath '20250442.c' -Algorithm SHA256).Hash

    $entorno = @(
        ('Fecha local: ' + (Get-Date -Format o)),
        ('PowerShell: ' + $PSVersionTable.PSVersion.ToString()),
        ('Windows: ' + [Environment]::OSVersion.VersionString),
        ('Commit local: ' + $commit),
        ('SHA256 de 20250442.c: ' + $hashFuente),
        ('Git: ' + $versionGit),
        ('GCC: ' + $versionGcc),
        'Compilacion: gcc -std=c11 -Wall -Wextra 20250442.c -o reto.exe',
        'Comparacion: CRLF se convierte a LF solo para comparar.',
        'Se conservan mayusculas, espacios, lineas y salto final.',
        'Las salidas .actual se guardan sin modificar por cmd.exe.'
    )
    [IO.File]::WriteAllLines((Join-Path $carpetaAbsoluta 'entorno.txt'), $entorno, $utf8)

    $comandoCompilacion = 'gcc -std=c11 -Wall -Wextra 20250442.c -o reto.exe > "' +
                         $carpeta + '\compilacion.txt" 2>&1'
    & cmd.exe /d /c $comandoCompilacion
    $codigoCompilacion = $LASTEXITCODE
    if ($codigoCompilacion -ne 0) {
        Get-Content -LiteralPath (Join-Path $carpetaAbsoluta 'compilacion.txt')
        throw "La compilacion fallo con codigo $codigoCompilacion."
    }

    $resumen = New-Object 'System.Collections.Generic.List[string]'
    $resumen.Add('Compilacion: terminada con codigo 0.')
    $resumen.Add('Casos previstos: 19.')
    $resumen.Add('Comparacion sensible a mayusculas; solo se normaliza CRLF a LF.')
    $coinciden = 0
    $lf = [string][char]10
    $crlf = [string][char]13 + $lf

    foreach ($caso in $casos) {
        $archivoActual = Join-Path $carpetaAbsoluta "$caso.actual"
        $archivoError = Join-Path $carpetaAbsoluta "$caso.stderr.txt"
        $comandoPrueba = '.\reto.exe < "pruebas\' + $caso + '.in" > "' +
                        $carpeta + '\' + $caso + '.actual" 2> "' +
                        $carpeta + '\' + $caso + '.stderr.txt"'
        & cmd.exe /d /c $comandoPrueba
        $codigoPrueba = $LASTEXITCODE

        $esperado = [IO.File]::ReadAllText((Join-Path $PSScriptRoot "pruebas\$caso.out"))
        $obtenido = [IO.File]::ReadAllText($archivoActual)
        $errorVacio = ((Get-Item -LiteralPath $archivoError).Length -eq 0)
        $esIgual = $obtenido.Replace($crlf, $lf) -ceq $esperado.Replace($crlf, $lf)

        if ($codigoPrueba -eq 0 -and $errorVacio -and $esIgual) {
            $estado = 'COINCIDE'
            $coinciden++
        } else {
            $estado = 'REVISAR'
        }
        $linea = "$caso $estado CODIGO $codigoPrueba"
        Write-Host $linea
        $resumen.Add($linea)
        [IO.File]::WriteAllLines((Join-Path $carpetaAbsoluta 'resumen.txt'), $resumen, $utf8)
    }

    $resultado = "Resultado: $coinciden de 19 casos coinciden."
    $resumen.Add($resultado)
    [IO.File]::WriteAllLines((Join-Path $carpetaAbsoluta 'resumen.txt'), $resumen, $utf8)
    Write-Host $resultado
    Write-Host "Evidencias: $carpeta"
    if ($coinciden -eq 19) { $codigoFinal = 0 }
} catch {
    Write-Host ('ERROR: ' + $_.Exception.Message)
    if ($carpetaAbsoluta -and (Test-Path -LiteralPath $carpetaAbsoluta)) {
        [IO.File]::WriteAllText(
            (Join-Path $carpetaAbsoluta 'error_verificacion.txt'),
            $_.Exception.Message,
            $utf8
        )
        Write-Host "Revisar evidencias: $carpeta"
    }
} finally {
    Set-Location -LiteralPath $ubicacionAnterior.Path
}
exit $codigoFinal
