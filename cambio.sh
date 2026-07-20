# --- AUTOMATIZACIÓN DE GIT ---
echo "🚀 Subiendo cambios automáticamente a GitHub..."
git add .
git commit -m "Automatizado: Actualización de galería $(date +'%d-%m-%Y %H:%M')"
git push origin main
echo "🎉 ¡Todo listo! Tu web se está actualizando en internet."

