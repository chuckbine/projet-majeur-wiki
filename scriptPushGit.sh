#!/bin/bash

# Configuration
INTERVAL=600
DROPBOX_DIR="/home/fernand/Dropbox/Comite_Projets majeurs/Publication_Web/Wiki-CoopOnze/"
QUARTZ_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Démarrage de la sync Dropbox -> Git -> GitHub "

while true; do
  cd "$QUARTZ_DIR"

  # 1. Copier le contenu de Dropbox vers le dossier local content/
  # rsync met à jour uniquement les fichiers modifiés et supprime ceux effacés dans Dropbox
  rsync -rtv --delete --no-perms --no-owner --no-group --exclude='.obsidian' --exclude='*~' "$DROPBOX_DIR" "$QUARTZ_DIR/content/" > /dev/null
  # 2. Vérifier s'il y a des changements pour Git
  # Met à jour l'index Git sans commiter
  git add -A

  # Vérifie s'il y a de véritables modifications de contenu indexées
  if ! git diff --cached --quiet; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Changements de contenu détectés. Push en cours..."
    
    git commit -m "Auto-update : $(date '+%Y-%m-%d %H:%M:%S')"
    git push
    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Push effectué avec succès."
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Aucun changement de contenu."
  fi

  sleep $INTERVAL
done
