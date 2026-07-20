#!/bin/bash

# Archivo HTML principal
HTML_FILE="index.html"
# Carpeta donde están las fotos
IMG_DIR="imagenes"

# Validar que existan el archivo y la carpeta
if [ ! -f "$HTML_FILE" ] || [ ! -d "$IMG_DIR" ]; then
    echo "❌ Error: No se encuentra index.html o la carpeta imagenes/"
    exit 1
fi

echo "📸 Leyendo fotos de la carpeta '$IMG_DIR'..."

# Crear un archivo temporal para ir armando el código de las fotos
TMP_GALERIA=$(mktemp)

# Recorrer todas las imágenes (.png, .jpg, .jpeg, .webp) de la carpeta
# Nota: Excluimos 'hero.jpg' si está en la misma carpeta para que no se duplique
for foto in "$IMG_DIR"/*.{png,jpg,jpeg,webp,PNG,JPG,JPEG,WEBP}; do
    # Validar si el archivo realmente existe (por si la extensión no encuentra nada)
    [ -e "$foto" ] || continue
    
    # Obtener solo el nombre del archivo (ej: foto1.png)
    FILENAME=$(basename "$foto")
    
    # Ignorar la imagen de fondo del hero si se llama hero.jpg
    if [ "$FILENAME" = "hero.jpg" ]; then
        continue
    fi

    # Crear un título limpio basado en el nombre del archivo para que sea descriptivo
    # Cambia guiones bajos por espacios y quita la extensión
    TITULO_LIMPIO=$(echo "$FILENAME" | cut -f 1 -d '.' | sed 's/_/ /g' | sed 's/-/ /g')

    # Escribir el bloque HTML exacto con tu diseño de cuadrícula moderna
    cat <<EOF >> "$TMP_GALERIA"
            <article class="portfolio-item">
                <div class="image-container">
                    <img src="$IMG_DIR/$FILENAME" alt="$TITULO_LIMPIO - Harry Stilos">
                </div>
                <div class="info-container">
                    <span class="item-tag">Diseño Profesional</span>
                    <h3 class="item-title">${TITULO_LIMPIO^}</h3>
                    <p class="item-description">Acabado perfecto con técnicas avanzadas de salón.</p>
                </div>
            </article>
EOF
done

# Combinar el código insertándolo exactamente entre las marcas INICIO y FIN
sed -i "/<!-- INICIO_GALERIA -->/,/<!-- FIN_GALERIA -->/{//!d;}" "$HTML_FILE"
sed -i "/<!-- INICIO_GALERIA -->/r $TMP_GALERIA" "$HTML_FILE"

# Limpiar archivo temporal
rm "$TMP_GALERIA"

echo "✅ ¡Cuadrícula actualizada con éxito en index.html!"


# --- AUTOMATIZACIÓN DE GIT ---
echo "🚀 Subiendo cambios automáticamente a GitHub..."
git add .
git commit -m "Automatizado: Actualización de galería $(date +'%d-%m-%Y %H:%M')"
git push origin principal
echo "🎉 ¡Todo listo! Tu web se está actualizando en internet."

