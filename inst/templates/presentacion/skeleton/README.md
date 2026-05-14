# Template MetaDocencia

Este proyecto fue creado con el paquete `metadocencia`.

## Archivos incluidos

| Archivo | Descripción |
|---------|-------------|
| `*.qmd` | Documento principal — editá aquí el contenido |
| `_quarto.yml` | Configuración del formato (no modificar salvo necesidad) |
| `_brand.yml` | Identidad institucional (colores, tipografías) |
| `assets/` | Estilos SCSS, logo, plantilla LaTeX |

## Renderizar

```bash
# Desde la terminal, en el directorio del proyecto
quarto render nombre-del-archivo.qmd
```

O usá el botón **Render** en RStudio / Positron.

## Actualizar la identidad institucional

Si hubo cambios en la marca de MetaDocencia:

```r
metadocencia::actualizar_brand()
```

## Colores institucionales

| Color | Hex | Uso |
|-------|-----|-----|
| Azul (Pantone 3025C) | `#00506F` | Primario, H3, bordes |
| Rojo (Pantone 180C) | `#C83737` | H2, acento |
| Naranja (Pantone 021C) | `#F77B20` | Acento secundario, footer |
| Gris texto | `#404040` | H1, texto UI |
| Negro | `#000000` | Texto normal |
