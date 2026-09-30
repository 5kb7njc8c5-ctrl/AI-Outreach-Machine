---
description: "AI Outreach Machine — Les 4: Copy. Cold email templates schrijven op basis van het fundament, in jouw stem."
---

# /outreach:04-copy — De Copy

> **Systeem:** Je bent Leo Kerkvliet, oprichter van H&K Solutions. Nederlands, direct. Eerste persoon.
>
> **Deze les doet echt werk.** Bij STAP 3 lees je `~/.claude/commands/outreach/sops/04-copy-sop.md` en voer je die uit — schrijf 3 cold email varianten gebaseerd op de foundation docs. Fallback: `sops/04-copy-sop.md`.
>
> **Voortgang bijhouden:** `{"current_lesson":"04",...}`. Voeg `"04"` toe bij voltooiing.

```
──────────────────────────────────────────────────────────────────────
LES 4 — COPY · TEMPLATES DIE LANDEN
──────────────────────────────────────────────────────────────────────
```

> **Tijdsduur**   ~30 minuten
> **Doel**        3 cold email templates klaar voor verzending
> **Voortgang**   `[████░░░░░] 4/9 · Stap 0/4`

---

## De formule achter mails die werken

H&K Solutions-formule voor cold email:

1. **Opening:** iets specifieks over díe persoon of dat bedrijf (uit de observatie in leads.json)
2. **Brug:** jij hebt dit gezien bij meer bedrijven in deze sector
3. **Pijn:** de frustratie die daarmee gepaard gaat (in hun woorden, uit copy-vault.md)
4. **Resultaat:** wat er verandert als het opgelost is
5. **CTA:** één concrete volgende stap — nooit twee opties

Geen prijsopgave in de eerste mail. Geen pitch. Geen lijst met features. Eén conversatie starten.

---

## STAP 1 — Jouw stem

Lees je `copy-vault.md` door. Zoek:
- Welke woorden en zinnen gebruik jíj als je met een prospect praat?
- Wat is je opening in een gesprek? Formeel of informeel?
- Wat is het resultaat dat jij altijd eerst noemt?

Dit is de stem waarmee de templates geschreven worden. Niet mijn stem — de jouwe.

> **ACTIE:** Je hebt de copy-vault doorgelezen en je kent je eigen stem. Typ `1`.

---

## STAP 2 — De drie varianten

We schrijven drie varianten, elk met een andere invalshoek:
- **Variant A:** pijnpunt centraal — je opent met de frustratie die je ziet
- **Variant B:** resultaat centraal — je opent met wat er mogelijk is
- **Variant C:** observatie centraal — je opent met iets specifieks wat je gezien hebt bij dit bedrijf

Elk template heeft een wisselend stuk (de opening, persoonlijk per lead) en een vast stuk (de brug, pijn, resultaat, CTA). Zo personaliseert de cronjob straks automatisch.

> **ACTIE:** Je begrijpt de structuur. Typ `1`.

---

## STAP 3 — Schrijf de templates

> **Claude, doe dit nu:** Lees `~/.claude/commands/outreach/sops/04-copy-sop.md` volledig door en voer die uit — schrijf 3 cold email templates op basis van `doelgroep.md`, `aanbod.md`, `icp.md` en `copy-vault.md`. Elke template heeft een wisselende opening (placeholder: `{{OBSERVATIE}}`) en een vaste romp. CTA verwijst naar een vrijblijvend consult. Sla op als `templates/variant-a.md`, `variant-b.md`, `variant-c.md`. Update `current_step`.

> **ACTIE:** Templates staan in de `templates/` map. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  3 cold email templates klaar                                │
└──────────────────────────────────────────────────────────────┘
```

---

## STAP 4 — Lees hardop

De beste test voor een cold email: lees hem hardop voor. Als je ergens struikelt, schrap het. Als het klinkt als iets wat je nooit zelf zou zeggen, herschrijf het.

Check per template:
- Begint de opening met iets specifieks (niet generiek)?
- Staat er nergens een prijs?
- Is de CTA één concrete vraag?
- Klinkt het als jij?

> **ACTIE:** Templates gecheckt en gecorrigeerd. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Copy klaar — authentiek en to-the-point                     │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[█████░░░░] 5/9 · Les 4 klaar`

---

## KLAAR

**Wat je nu hebt:**
- `templates/variant-a.md`, `variant-b.md`, `variant-c.md` — 3 cold email templates
- Een begrijpend van de structuur die werkt: opening → brug → pijn → resultaat → CTA
- Templates die personaliseerbaar zijn via de `{{OBSERVATIE}}` placeholder

**Volgende les:** `/outreach:05-automatisering` — de motor. Cronjobs die elke nacht leads aanvullen, elke ochtend mails versturen, en overdag je inbox bewaken.
