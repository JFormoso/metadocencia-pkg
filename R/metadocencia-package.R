#' metadocencia: Plantillas institucionales de MetaDocencia para Quarto
#'
#' El paquete `metadocencia` proporciona plantillas Quarto con la identidad
#' institucional de MetaDocencia (colores, tipografías, logo) para crear
#' reportes HTML, reportes PDF y presentaciones RevealJS de manera consistente.
#'
#' @section Funciones principales:
#' - [metadocencia::nuevo_documento()]: Crea un nuevo proyecto Quarto a partir de una plantilla institucional.
#' - [metadocencia::actualizar_brand()]: Actualiza el `_brand.yml` en proyectos existentes.
#'
#' @section Tipos de documento disponibles:
#' - `"reporte-html"`: Reporte HTML autocontenido con TOC y numeración de secciones.
#' - `"reporte-pdf"`: Reporte PDF via XeLaTeX con encabezado y pie institucional.
#' - `"presentacion"`: Presentación RevealJS con tema institucional.
#'
#' @docType package
#' @name metadocencia-package
#' @aliases metadocencia
"_PACKAGE"
