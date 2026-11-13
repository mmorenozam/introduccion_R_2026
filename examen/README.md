# Examen final: Introducción a R

Examen de **código para completar**: los estudiantes reciben un script de R con espacios en blanco (`____`), lo completan en su proyecto y entregan el archivo `.R`.

## Qué se entrega a los estudiantes

Solo estos dos archivos (a partir del 7 de diciembre):

- `examen_introduccion_R.R`: el examen.
- `datos_examen.csv`: 72 parcelas de fréjol, datos simulados para el examen.

**No distribuyas la carpeta `clave/`.** Está en `.gitignore` para que no llegue a GitHub ni al sitio.

## Contenido y puntaje (10 puntos)

| Pregunta | Tema | Módulo | Puntos |
|:--|:--|:--:|:--:|
| 1 | Importar datos y crear factores | 1 | 0.5 |
| 2 | Estadísticos descriptivos | 1 | 1 |
| 3 | Intervalo de confianza | 2 | 1 |
| 4 | Prueba t de una muestra | 2 | 1 |
| 5 | Dos muestras independientes | 2 | 1 |
| 6 | Muestras emparejadas | 2 | 1 |
| 7 | Datos no normales: Wilcoxon o transformación | 2 | 1 |
| 8 | ANOVA de una vía, supuestos y Tukey | 3 | 1.5 |
| 9 | ANOVA de dos vías, interacción y transformación | 3, 4 | 1.5 |
| 10 | Exportar resultados | 4 | 0.5 |

Cada pregunta combina valores calculados (objetos con nombres fijos: `p1_n_filas`, `p5_prueba`, ...) y, de la 4 a la 9, una conclusión escrita (`r4_conclusion`, ...).

## Carpeta `clave/`

- `examen_resuelto.R`: el examen completo, con conclusiones de referencia.
- `clave.json`: valores esperados, tolerancias, puntaje por componente y criterios para las conclusiones escritas. Está pensado para que lo lea tanto una persona como un programa.
- `valores_completos.json`: todos los resultados intermedios (útil para retroalimentación).
- `revisar_examen.R`: la revisión automática del código (ver abajo).
- `prompt_revision_ia.md`: instrucciones para que un modelo de IA puntúe las conclusiones escritas.

Los valores se calcularon fuera de R. Antes del examen, ejecuta una vez `clave/examen_resuelto.R` y comprueba que coincide con `clave.json`.

## Revisión automática

La revisión tiene dos capas: **6.5 puntos de código**, que revisa un script de R, y **3.5 puntos de conclusiones escritas**, que revisa una IA (o tú) con una rúbrica.

### 1. Código: `clave/revisar_examen.R`

Pon las entregas (`.R`) en una carpeta, por ejemplo `examen/entregas/`, y desde la carpeta `examen/` ejecuta:

```bash
Rscript clave/revisar_examen.R entregas
```

El script:

- ejecuta cada entrega en una sesión de R separada, en una carpeta temporal con `datos/datos_examen.csv`, con un máximo de 120 segundos por entrega;
- si una línea da error, la anota y sigue, para poder revisar el resto del examen;
- compara los objetos `p1_` a `p10_` con `clave.json` (tolerancia relativa de 0.001) y comprueba que se creó `resultados/medias_examen.csv`;
- acepta los dos caminos válidos de la pregunta 7 (Wilcoxon o t sobre el logaritmo) y los modelos finales válidos de la 9.

Resultados en `examen/revision/` (también en `.gitignore`):

| Archivo | Contenido |
|:--|:--|
| `notas_codigo.csv` | una fila por estudiante: nombre, puntos por pregunta, total de código, número de errores y si conviene revisarla a mano |
| `detalle/estudiante_XX.txt` | retroalimentación componente por componente, con los errores de ejecución |
| `para_ia/estudiante_XX.json` | conclusiones escritas, criterios y resultados de código, **sin el nombre del estudiante** |

**Pruébalo antes del examen.** Copia `clave/examen_resuelto.R` y `examen_introduccion_R.R` (la versión en blanco) a `entregas/` y ejecuta el script. El resuelto debe sacar 6.5 de 6.5. El que está en blanco debe sacar 0, con errores en casi todas las líneas. El script es código que no ha corrido todavía en R: si algo falla, me pasas el mensaje y lo corrijo.

**Seguridad:** el script ejecuta código escrito por los estudiantes. Úsalo en una carpeta aparte, sin permisos de administrador, o mejor en un contenedor.

### 2. Conclusiones: `clave/prompt_revision_ia.md`

Para cada `para_ia/estudiante_XX.json`, un modelo de IA lee las instrucciones de `prompt_revision_ia.md` y devuelve los puntos y una retroalimentación corta por pregunta, marcando los casos dudosos. Como los archivos son anónimos, no se envían nombres a ningún servicio externo; `notas_codigo.csv` guarda la correspondencia entre `estudiante_XX` y el nombre.

### Nota final

Nota = `total_codigo` + puntos de las conclusiones. Revisa las entregas marcadas en `revisar_a_mano` y las conclusiones marcadas `"revisar": true`, y firma la nota.
