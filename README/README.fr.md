# Filtres Sieve pour Proton

## Description
Ce dépôt fournit des scripts Sieve prêts à l'emploi pour les utilisateurs de Proton Mail. Sieve est un langage spécifique au domaine (DSL) pour le filtrage des e-mails côté serveur, permettant des actions comme déplacer les e-mails, marquer comme lus ou expirer. Le filtre des réseaux sociaux est le point de départ, avec des extensions pour d'autres catégories.

**Note sur les Domaines**: Les listes de domaines pour différents filtres (par exemple, réseaux sociaux, factures) sont stockées dans 'domains.txt'. Vous pouvez modifier ce fichier pour ajouter ou supprimer des domaines sans changer les scripts.

## Limitations
- Ces scripts sont optimisés pour Proton Mail et peuvent nécessiter des modifications pour d'autres services de messagerie (ex., supprimer les extensions spécifiques à Proton comme "vnd.proton.expire").
- Connaissances de base en programmation Sieve (ou scripting similaire) recommandées pour la personnalisation, car des erreurs peuvent entraîner des e-mails manqués ou rejetés.
- Les filtres s'appliquent uniquement aux e-mails entrants ; ils ne réorganisent pas les messages existants.
- Risques potentiels : Règles trop larges pourraient causer des faux positifs (ex., rejeter des e-mails importants) ; testez toujours minutieusement.
- Aucune garantie : Utilisez à vos propres risques, selon les normes open source.

## Utilisation
1. Connectez-vous à Proton Mail → Paramètres → Filtres → Ajouter un Filtre Sieve.
2. Copiez le script d'un fichier .sieve (par exemple, filters/social_media.sieve) et collez-le.
3. Personnalisez les domaines dans 'domains.txt' si nécessaire.
4. Testez avec des e-mails d'exemple.

**Filtres Disponibles** :
- Réseaux Sociaux : Filtre les notifications de X, Facebook, etc. (premier filtre dans le dépôt).
- Factures : Déplace les e-mails de facturation de PayPal, Amazon, etc.
- Publicités : Gère les e-mails promotionnels.
- À venir...

## Contribution
Forkez le dépôt, ajoutez de nouveaux filtres ou domaines, et soumettez une pull request. Suivez le Semantic Versioning pour les mises à jour (par exemple, v0.1.0).

## Licence
Licence MIT - Libre d'utilisation et de modification.