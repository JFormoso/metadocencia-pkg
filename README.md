# metadocencia <img src="inst/brand/logo.png" align="right" height="80"/>

<!-- badges: start -->
<!-- badges: end -->

Plantillas Quarto con la identidad institucional de [MetaDocencia](https://www.metadocencia.org) para crear reportes y presentaciones consistentes.

## Instalación

```r
# Desde GitHub
remotes::install_github("metadocencia/metadocencia")

# O con pak
pak::pak("metadocencia/metadocencia")
```

## Uso

### Crear un nuevo documento

```r
library(metadocencia)

# Reporte HTML autocontenido
nuevo_documento("informe-anual-2025", tipo = "reporte-html")

# Reporte PDF institucional
nuevo_documento("memoria-2025", tipo = "reporte-pdf")

# Presentación RevealJS
nuevo_documento("reunion-directorio", tipo = "presentacion")
```

Esto crea un directorio con todos los archivos necesarios:

```
informe-anual-2025/
├── informe-anual-2025.qmd   ← editá aquí el contenido
├── _quarto.yml              ← configuración del formato
├── _brand.yml               ← identidad institucional
├── README.md
└── assets/
    ├── tema-html.scss       ← estilos institucionales
    └── logo.png
```

### Mantener la identidad actualizada

Cuando la marca de MetaDocencia se actualice, podés propagar los cambios a proyectos existentes:

```r
# Verificar qué proyectos están desactualizados
diagnosticar_brand(proyectos = fs::dir_ls("~/reportes", type = "directory"))

# Actualizar proyectos seleccionados
actualizar_brand(proyectos = c("~/reportes/informe-q3", "~/reportes/memoria"))

# Actualizar sin confirmación (para scripts/CI)
actualizar_brand(proyectos = fs::dir_ls("~/reportes"), confirmar = FALSE)
```

## Identidad institucional

| Elemento | Valor |
|----------|-------|
| Azul (Pantone 3025C) | `#00506F` |
| Rojo (Pantone 180C) | `#C83737` |
| Naranja (Pantone 021C) | `#F77B20` |
| Heading 1 | Barlow 37pt bold `#404040` |
| Heading 2 | Barlow 19pt bold `#C83737` |
| Heading 3 | Barlow 16pt `#00506F` |
| Cuerpo | Open Sans 12pt negro |
| Links | `#1155CC` |

## Estructura del paquete

```
metadocencia/
├── R/
│   ├── nuevo_documento.R      # crear proyectos desde plantilla
│   └── actualizar_brand.R     # sincronizar identidad institucional
└── inst/
    ├── brand/
    │   ├── _brand.yml          # fuente de verdad de identidad
    │   └── logo.png
    └── templates/
        ├── reporte-html/skeleton/
        ├── reporte-pdf/skeleton/
        └── presentacion/skeleton/
```
