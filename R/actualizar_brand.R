#' Actualizar el `_brand.yml` en proyectos existentes
#'
#' Reemplaza el archivo `_brand.yml` en uno o varios proyectos con la versión
#' actual del paquete. Útil cuando la identidad institucional de MetaDocencia
#' cambia y se necesita propagar las actualizaciones a proyectos ya creados.
#'
#' @param proyectos Vector de rutas a directorios de proyectos Quarto.
#'   Por defecto usa el directorio de trabajo actual `"."`.
#' @param confirmar Si `TRUE` (por defecto), pide confirmación interactiva
#'   antes de sobreescribir cada archivo. Usá `FALSE` para scripts o CI/CD.
#'
#' @return Vector de rutas actualizadas, de forma invisible.
#'
#' @examples
#' \dontrun{
#' # Actualizar el proyecto actual
#' actualizar_brand()
#'
#' # Actualizar varios proyectos
#' actualizar_brand(
#'   proyectos = c("~/reportes/informe-q3", "~/reportes/memoria-anual")
#' )
#'
#' # Sin confirmación (para scripts)
#' actualizar_brand(proyectos = fs::dir_ls("~/reportes"), confirmar = FALSE)
#' }
#'
#' @seealso [metadocencia::diagnosticar_brand()] para verificar qué proyectos están desactualizados.
#'
#' @export
actualizar_brand <- function(proyectos = ".", confirmar = TRUE) {

  brand_nuevo <- system.file("brand", "_brand.yml",
                              package = "metadocencia",
                              mustWork = TRUE)
  hash_nuevo  <- unname(tools::md5sum(brand_nuevo))

  actualizados <- character(0)
  omitidos     <- character(0)

  for (proyecto in proyectos) {

    proyecto <- fs::path_expand(proyecto)

    # Verificar que el directorio existe
    if (!fs::dir_exists(proyecto)) {
      cli::cli_warn("No existe el directorio: {.path {proyecto}}")
      next
    }

    brand_destino <- fs::path(proyecto, "_brand.yml")

    # Verificar si ya está actualizado
    if (fs::file_exists(brand_destino)) {
      hash_local <- unname(tools::md5sum(as.character(brand_destino)))
      if (hash_local == hash_nuevo) {
        cli::cli_alert_info("{.path {proyecto}}: ya está actualizado, omitiendo.")
        next
      }
    }

    # Pedir confirmación si corresponde
    if (confirmar && fs::file_exists(brand_destino)) {
      respuesta <- readline(
        paste0("  ¿Sobreescribir _brand.yml en '", proyecto, "'? [s/N]: ")
      )
      if (!tolower(trimws(respuesta)) %in% c("s", "si", "sí", "y", "yes")) {
        cli::cli_alert_warning("Omitido: {.path {proyecto}}")
        omitidos <- c(omitidos, proyecto)
        next
      }
    }

    fs::file_copy(brand_nuevo, brand_destino, overwrite = TRUE)
    cli::cli_alert_success("Actualizado: {.path {proyecto}}")
    actualizados <- c(actualizados, proyecto)
  }

  # Resumen final
  cli::cli_rule()
  cli::cli_bullets(c(
    "v" = "{length(actualizados)} proyecto(s) actualizado(s).",
    "!" = "{length(omitidos)} proyecto(s) omitido(s)."
  ))

  invisible(actualizados)
}


#' Diagnosticar estado del `_brand.yml` en proyectos existentes
#'
#' Compara el `_brand.yml` de uno o varios proyectos con la versión actual
#' del paquete e informa si están actualizados, desactualizados o ausentes.
#'
#' @param proyectos Vector de rutas a directorios de proyectos Quarto.
#'   Por defecto usa el directorio de trabajo actual `"."`.
#'
#' @return Un `data.frame` con columnas `proyecto` y `estado`
#'   (`"actualizado"`, `"desactualizado"`, `"ausente"`), de forma invisible.
#'
#' @examples
#' \dontrun{
#' diagnosticar_brand(proyectos = fs::dir_ls("~/reportes", type = "directory"))
#' }
#'
#' @export
diagnosticar_brand <- function(proyectos = ".") {

  brand_paquete <- system.file("brand", "_brand.yml",
                                package = "metadocencia",
                                mustWork = TRUE)
  hash_paquete  <- unname(tools::md5sum(brand_paquete))

  resultados <- lapply(proyectos, function(p) {
    p <- fs::path_expand(p)
    brand_local <- fs::path(p, "_brand.yml")

    estado <- if (!fs::file_exists(brand_local)) {
      "ausente"
    } else if (unname(tools::md5sum(as.character(brand_local))) == hash_paquete) {
      "actualizado"
    } else {
      "desactualizado"
    }

    data.frame(proyecto = as.character(p), estado = estado,
               stringsAsFactors = FALSE)
  })

  resultado_df <- do.call(rbind, resultados)

  # Mostrar resumen con colores en consola
  for (i in seq_len(nrow(resultado_df))) {
    switch(resultado_df$estado[i],
      "actualizado"     = cli::cli_alert_success("{resultado_df$proyecto[i]}"),
      "desactualizado"  = cli::cli_alert_warning("{resultado_df$proyecto[i]}"),
      "ausente"         = cli::cli_alert_danger("{resultado_df$proyecto[i]}")
    )
  }

  invisible(resultado_df)
}
