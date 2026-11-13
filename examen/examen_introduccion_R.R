# =============================================================================
#  EXAMEN FINAL: Introducción a R (UCE 2026)
#  Valor: 60% de la nota final · Puntaje: 10 puntos
# =============================================================================
#
#  Nombre completo: ____
#  Correo:          ____
#
#  INSTRUCCIONES
#  1. Copia este archivo y "datos_examen.csv" en tu proyecto de R del curso:
#     el script en la carpeta del proyecto y el csv en la carpeta datos/.
#  2. Reemplaza cada ____ por el código o el valor que corresponda.
#  3. NO cambies los nombres de los objetos que empiezan con p1_, p2_, ..., r4_,
#     r5_, ... ni el de la tabla frejol. La revisión busca exactamente esos nombres.
#  4. Las respuestas escritas (objetos r4_, r5_, ...) van entre comillas, en una
#     o dos frases. Incluye los números que justifican tu respuesta.
#  5. Antes de entregar, reinicia R (Session > Restart R) y ejecuta TODO el
#     script con el botón "Source". Si aparece un error, el script no corre
#     completo y las preguntas siguientes no se pueden revisar.
#  6. Entrega solo este archivo .R, con tu nombre: examen_apellido_nombre.R
#
#  LOS DATOS
#  "datos_examen.csv": ensayo con 72 parcelas de fréjol.
#    fertilizante      : control, organico, quimico
#    riego             : bajo, alto
#    altura_cm         : altura de la planta a los 45 días (cm)
#    dias_floracion    : días desde la siembra hasta la floración
#    clorofila_antes   : índice de clorofila antes de una aplicación foliar
#    clorofila_despues : índice de clorofila en la misma parcela, después
#  Los datos son simulados para este examen.
# =============================================================================


# -----------------------------------------------------------------------------
# PREGUNTA 1 (0.5 puntos). Importar y preparar los datos
# Importa el archivo, convierte fertilizante y riego en factores y guarda el
# número de filas y de columnas.
# -----------------------------------------------------------------------------

frejol <- read.csv("____")
frejol$fertilizante <- ____(frejol$fertilizante)
frejol$riego <- factor(____)
str(frejol)

p1_n_filas    <- nrow(____)
p1_n_columnas <- ____(frejol)


# -----------------------------------------------------------------------------
# PREGUNTA 2 (1 punto). Estadísticos descriptivos
# Calcula la media, la mediana y la desviación estándar de altura_cm, y la
# altura media para cada fertilizante.
# -----------------------------------------------------------------------------

p2_media    <- ____(frejol$altura_cm)
p2_mediana  <- ____
p2_de       <- ____
p2_medias_fertilizante <- tapply(frejol$altura_cm, ____, ____)
p2_medias_fertilizante


# -----------------------------------------------------------------------------
# PREGUNTA 3 (1 punto). Intervalo de confianza
# Calcula el intervalo de confianza del 95% para la altura media.
# -----------------------------------------------------------------------------

p3_ic <- t.test(____)$conf.int
p3_ic


# -----------------------------------------------------------------------------
# PREGUNTA 4 (1 punto). Prueba t de una muestra
# La variedad, según el proveedor, alcanza en promedio 45 cm a los 45 días.
# ¿Hay evidencia de que la altura media de este ensayo es distinta de 45 cm?
# -----------------------------------------------------------------------------

p4_prueba <- t.test(frejol$altura_cm, mu = ____)
p4_prueba

r4_conclusion <- "____"


# -----------------------------------------------------------------------------
# PREGUNTA 5 (1 punto). Dos muestras independientes
# ¿Difiere la altura entre riego alto y riego bajo? Revisa la normalidad de
# cada grupo y la homogeneidad de varianzas, y luego haz la prueba t.
# -----------------------------------------------------------------------------

p5_shapiro_alto <- shapiro.test(frejol$altura_cm[frejol$riego == "alto"])$p.value
p5_shapiro_bajo <- shapiro.test(____)$p.value
p5_varianzas    <- var.test(altura_cm ~ riego, data = ____)
p5_prueba       <- t.test(____ ~ ____, data = frejol)
p5_prueba

r5_conclusion <- "____"


# -----------------------------------------------------------------------------
# PREGUNTA 6 (1 punto). Muestras emparejadas
# ¿Cambió el índice de clorofila después de la aplicación foliar? Revisa la
# normalidad de las diferencias y haz la prueba adecuada.
# -----------------------------------------------------------------------------

p6_diferencias <- frejol$clorofila_despues - ____
p6_shapiro     <- shapiro.test(____)$p.value
p6_prueba      <- t.test(frejol$clorofila_despues, frejol$clorofila_antes, paired = ____)
p6_prueba

r6_conclusion <- "____"


# -----------------------------------------------------------------------------
# PREGUNTA 7 (1 punto). Cuando los datos no son normales
# ¿Difieren los días hasta la floración entre riego alto y riego bajo?
# a) Revisa la normalidad de cada grupo.
# b) Elige UNA de estas dos opciones y deja la otra comentada:
#    - prueba de Wilcoxon para dos muestras, o
#    - prueba t sobre el logaritmo de dias_floracion.
# c) Justifica tu elección y da tu conclusión en r7_conclusion.
# -----------------------------------------------------------------------------

p7_shapiro_alto <- shapiro.test(frejol$dias_floracion[frejol$riego == "alto"])$p.value
p7_shapiro_bajo <- ____

# Opción 1: Wilcoxon
# p7_prueba <- wilcox.test(____ ~ ____, data = frejol)

# Opción 2: prueba t sobre el logaritmo
# p7_prueba <- t.test(log(____) ~ riego, data = frejol)

p7_prueba

r7_conclusion <- "____"


# -----------------------------------------------------------------------------
# PREGUNTA 8 (1.5 puntos). ANOVA de una vía
# ¿Depende la altura del fertilizante? Ajusta el ANOVA, revisa sus supuestos
# y, si corresponde, identifica qué fertilizantes difieren.
# -----------------------------------------------------------------------------

boxplot(altura_cm ~ fertilizante, data = frejol)

p8_modelo   <- aov(____ ~ ____, data = frejol)
summary(p8_modelo)

p8_shapiro  <- shapiro.test(residuals(____))$p.value
p8_bartlett <- bartlett.test(altura_cm ~ fertilizante, data = frejol)$p.value
p8_tukey    <- TukeyHSD(____)
p8_tukey

r8_conclusion <- "____"


# -----------------------------------------------------------------------------
# PREGUNTA 9 (1.5 puntos). ANOVA de dos vías
# ¿Dependen los días hasta la floración del fertilizante, del riego o de su
# interacción?
# a) Ajusta el modelo con interacción sobre dias_floracion y revisa los supuestos.
# b) Repite con log(dias_floracion).
# c) Con base en los diagnósticos y en la interacción, elige el modelo final
#    (p9_modelo_final) y da tu conclusión.
# -----------------------------------------------------------------------------

p9_modelo_dias <- aov(dias_floracion ~ fertilizante ____ riego, data = frejol)
summary(p9_modelo_dias)
p9_shapiro_dias  <- shapiro.test(residuals(p9_modelo_dias))$p.value
p9_bartlett_dias <- bartlett.test(dias_floracion ~ interaction(fertilizante, riego), data = frejol)$p.value

p9_modelo_log <- aov(____(dias_floracion) ~ fertilizante * riego, data = frejol)
summary(p9_modelo_log)
p9_shapiro_log  <- shapiro.test(residuals(____))$p.value
p9_bartlett_log <- bartlett.test(log(dias_floracion) ~ interaction(fertilizante, riego), data = frejol)$p.value

p9_modelo_final <- ____
summary(p9_modelo_final)

r9_conclusion <- "____"


# -----------------------------------------------------------------------------
# PREGUNTA 10 (0.5 puntos). Exportar resultados
# Calcula la altura media para cada combinación de fertilizante y riego y
# guárdala en "resultados/medias_examen.csv", sin los nombres de las filas.
# -----------------------------------------------------------------------------

p10_medias <- aggregate(altura_cm ~ fertilizante + riego, data = frejol, FUN = ____)
p10_medias

dir.create("resultados", showWarnings = FALSE)
write.csv(____, "resultados/medias_examen.csv", row.names = ____)


# =============================================================================
#  FIN DEL EXAMEN. Reinicia R, ejecuta todo con "Source" y entrega este archivo.
# =============================================================================
