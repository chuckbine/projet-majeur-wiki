#!/bin/bash

# Configuration : Temps d'attente en secondes (5 minutes = 300 s)
INTERVAL=300

# Se placer dans le dossier du script
cd "$(dirname "$0")"

echo "Démarrage du script de push automatique (toutes les 5 min)..."

while true; do
  # Vérifier s'il y a des changements dans le dépôt (modifications ou nouveaux fichiers)
  if [[ -n $(git status --porcelain) ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Changements détectés. Push en cours..."
    
    # Ajouter tous les changements
    git add -A
    
    # Commit avec la date et l'heure
    git commit -m "Auto-update : $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Push vers le dépôt distant
    git push
    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Push effectué avec succès."
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Aucun changement."
  fi

  # Attendre 5 minutes avant la prochaine vérification
  sleep $INTERVAL
done
