# SOP — Copy (Les 4)

> **Dit is Les 4.** Vereist: `doelgroep.md`, `aanbod.md`, `icp.md`, `copy-vault.md` uit Les 1. Je schrijft drie cold email templates met een wisselende opening en een vaste romp.

---

## De structuur van elke template

```
[ONDERWERPREGEL] — kort, specifiek, geen clickbait

[OPENING — wisselend per lead]
{{OBSERVATIE}} — iets specifieks over dit bedrijf of deze persoon

[BRUG — vast]
Jij hebt dit ook gezien bij andere [type bedrijf] in [sector].

[PIJN — vast, in de taal van de doelgroep]
[Uit copy-vault.md]

[RESULTAAT — vast]
[Concreet resultaat, geen features, geen prijs]

[CTA — vast]
[Één vraag die een gesprek opent — nooit twee opties]
```

---

## De drie varianten

**Variant A — Pijnpunt centraal**
- Opening: je observeert een situatie die waarschijnlijk leidt tot de pijn
- Brug: "Dit zie ik vaker bij bedrijven als dat van jou"
- Pijn: directe beschrijving van de frustratie (uit copy-vault.md)
- Resultaat: wat er verandert als dit is opgelost
- CTA: "Is dit iets wat bij jou ook speelt?"

**Variant B — Resultaat centraal**
- Opening: je noemt een resultaat dat vergelijkbare bedrijven hebben bereikt
- Brug: "Dat is precies wat we ook bij [type bedrijf] in [sector] zien"
- Pijn: de tegenhanger — wat je mist als je dit resultaat niet haalt
- Resultaat: concreet en meetbaar
- CTA: "Mag ik je laten zien hoe dit voor jou werkt?"

**Variant C — Observatie centraal**
- Opening: een heel specifieke observatie over dít bedrijf (wat je ziet op website/social)
- Brug: "Daarin zie ik een kans die de meeste [type bedrijf] laten liggen"
- Pijn: de gemiste kans (zachter geformuleerd dan variant A)
- Resultaat: wat mogelijk is als de kans gepakt wordt
- CTA: "Wanneer heb je 20 minuten om dit door te praten?"

---

## Instructies

### Stap 0 — Lees de foundation docs

Lees `doelgroep.md`, `aanbod.md` en `copy-vault.md` volledig. Trek er uit:
- De drie sterkste probleemzinnen (voor de pijn-sectie)
- Het concrete resultaat (voor de resultaat-sectie)
- De verboden woorden (die mogen nergens in de templates staan)
- De trigger-woorden (die wil je juist wél gebruiken)

### Stap 1 — Schrijf Variant A

```markdown
# Template A — Pijnpunt centraal

**Onderwerp:** [kort, specifiek — max 8 woorden]

---

Hallo {{NAAM}},

{{OBSERVATIE}} — [een zin die de observatie verbindt aan wat daarna komt]

[Brug — 1-2 zinnen: dit zie ik vaker]

[Pijn — 1-2 zinnen in de exacte taal van de doelgroep]

[Resultaat — 1-2 zinnen: concreet, geen features]

[CTA — 1 vraag]

Met vriendelijke groet,
{{AFZENDER}}
```

### Stap 2 — Schrijf Variant B

Zelfde structuur, resultaat-centraal. Zie bovenstaand kader.

### Stap 3 — Schrijf Variant C

Zelfde structuur, observatie-centraal. Meest persoonlijk aanvoelend.

### Stap 4 — Valideer elke template

Per template, check:
- **Geen prijs** — nergens in de mail
- **Geen pitch** — geen lijst met features of diensten
- **Één CTA** — nooit twee opties of twee vragen
- **{{OBSERVATIE}} is een placeholder** — de opening personaliseert per lead
- **Verboden woorden** — geen van de woorden uit `copy-vault.md` verboden-lijst
- **Lengte** — max 150 woorden (exclusief opening en CTA)

Hardop-test: lees de mail voor. Struikel je ergens? Herschrijf het.

### Stap 5 — Sla op

- `templates/variant-a.md`
- `templates/variant-b.md`
- `templates/variant-c.md`

Maak ook `templates/README.md` aan met:
- Uitleg van de `{{NAAM}}`, `{{OBSERVATIE}}`, `{{AFZENDER}}` placeholders
- Wanneer je welke variant inzet (A: warme niche, B: resultaat-gedreven beslissers, C: als je echt iets specifiek gezien hebt)

### Stap 6 — Rapporteer

Geef een overzicht van de drie templates en welke keuzes je hebt gemaakt (waarom die opening, die pijnzin, die CTA). De cursist moet kunnen bijsturen als het niet goed voelt.

---

## Kwaliteitsstandaard

Dit is de test: stuur template A naar een goede kennis die de doelgroep kent. Vraagt die persoon "heb je dit voor mij geschreven?" — dan is het goed. Klinkt het generiek — dan is het terug naar de tekentafel.
