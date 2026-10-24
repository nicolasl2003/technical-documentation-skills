# Interview Guide

This interview is MANDATORY. Ask the questions in the user's language.
Ask ONE batch at a time, wait for the answers, then move on.
Present options as numbered or lettered lists so the user can answer quickly
(e.g. "1b, 2a, 3 - the old wiki").

## Batch 1 - Goal and audience (ask this FIRST, alone)

> Avant de commencer, quelques questions pour bien cadrer la documentation :
>
> 1. **Livrable** : que voulez-vous produire ?
>    a) README  b) ADR  c) Diagrammes d'architecture  d) Tout
> 2. **Public cible** : a) utilisateurs finaux  b) contributeurs  c) équipe interne
>    d) recruteurs / portfolio  e) communauté open source
> 3. **Nouveau document ou mise à jour** d'un existant ?

(Translate to the user's language. Never ask more than 5 questions per batch.)

## Batch 2 - Existing sources

> 4. Existe-t-il de la **documentation sur laquelle me baser** ? (ancien README,
>    wiki, Notion, specs, doc d'API, notes de réunion, tickets, liens)
>    Donnez-moi les chemins ou les URLs.
> 5. Des **conventions à respecter** ? (template d'entreprise, ton, sections obligatoires)
> 6. Des éléments à **ne pas** inclure ? (URLs internes, noms de clients, secrets)

## Batch 3 - Style (README only)

> 7. **Style visuel** :
>    a) Minimal : sobre et classique
>    b) Modern : badges, emojis, tableaux, sections repliables
>    c) Showcase : en-tête animé, texte qui s'écrit, dégradés, mise en page centrée
> 8. **Couleur de marque** (code hex) ou souhaitez-vous que je choisisse une palette ?
>    Palettes proposées : a) violet/bleu  b) vert/cyan  c) orange/rouge  d) noir/blanc
> 9. **Visuels** : avez-vous un logo, des captures d'écran ou un GIF de démo ?
>    (sinon je mets des emplacements marqués TODO)

## Batch 4 - Type-specific
- **ADR**: What decision? Which options were considered? Constraints (budget,
  deadline, team skills)? Who decided, and when?
- **Diagrams**: Which view (global architecture, sequence of a flow, data model,
  deployment)? Which level of detail?

## Recap (mandatory)
Summarize all answers in 3 to 5 lines, then ask:
"Je lance la génération avec ces paramètres ?"
Only proceed after an explicit confirmation.