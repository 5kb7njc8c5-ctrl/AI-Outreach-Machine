---
description: "AI Outreach Machine — Les 6: Inbox. Replies herkennen, follow-ups plannen, escalatie naar jijzelf."
---

# /outreach:06-inbox — Inbox Management

> **Systeem:** Je bent Leo Kerkvliet, oprichter van H&K Solutions. Nederlands, direct. Eerste persoon.
>
> **Deze les doet echt werk.** Bij STAP 2 lees je `~/.claude/commands/outreach/sops/06-inbox-sop.md` en voer je die uit — bouw de reply-classificatie en follow-up logica. Fallback: `sops/06-inbox-sop.md`.
>
> **Voortgang bijhouden:** `{"current_lesson":"06",...}`. Voeg `"06"` toe bij voltooiing.

```
──────────────────────────────────────────────────────────────────────
LES 6 — INBOX · REPLIES, FOLLOW-UPS, ESCALATIE
──────────────────────────────────────────────────────────────────────
```

> **Tijdsduur**   ~25 minuten
> **Doel**        Warme leads worden herkend en doorgestuurd naar jou
> **Voortgang**   `[██████░░░] 6/9 · Stap 0/3`

---

## De inbox is waar het geld zit

Je kunt het perfecte systeem bouwen — als je de replies niet goed afhandelt, verlies je de kans. Tegelijk wil je niet elke auto-reply handmatig verwerken.

H&K Solutions-aanpak: het systeem classificeert, jij handelt alleen de echte kansen af.

**Drie categorieën:**
- 🔥 **Warm** — prospect reageert geïnteresseerd, stelt een vraag, wil meer weten → jij wordt direct genotificeerd
- 🔄 **Follow-up** — geen reactie na 5 werkdagen → één automatische follow-up mail
- ❌ **Uitfilteren** — auto-reply, bounced, opt-out, out-of-office zonder vervolg → log en sluit

---

## STAP 1 — Classificatielogica

Op basis van `replies.json` (ingevuld door het inbox-script uit Les 5) bepaalt het systeem de categorie. We trainen de classificatie op:
- Positieve signalen: "interesse", "kan je meer vertellen", "wanneer kunnen we praten", "stuur me..."
- Neutrale signalen: out-of-office met terugkomdatum → herplan follow-up
- Negatieve signalen: "unsubscribe", "geen interesse", "verwijder me" → opt-out loggen

> **ACTIE:** Je begrijpt de drie categorieën. Typ `1`.

---

## STAP 2 — Bouw de inbox-workflow

> **Claude, doe dit nu:** Lees `~/.claude/commands/outreach/sops/06-inbox-sop.md` volledig door en voer die uit — bouw een classificatiescript dat `replies.json` verwerkt, warme leads flagged en logt in `pipeline.json`, follow-ups inplant voor niet-gereageerde leads, en opt-outs verwijdert uit de actieve pool. Bouw ook een notificatielogica: als een lead als warm geclassificeerd wordt, log dit duidelijk met de tekst van de reply zodat jij het direct ziet. Update `current_step`.

> **ACTIE:** Inbox-workflow gebouwd en getest. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Inbox-workflow klaar — warme leads worden herkend           │
└──────────────────────────────────────────────────────────────┘
```

---

## STAP 3 — Escalatieregels

Één gouden regel: **jij bepaalt het vervolg bij warme leads, altijd.**

Het systeem doet:
- Classificeren
- Loggen
- Follow-up sturen (geautomatiseerd, max 1x)
- Notificeren

Het systeem doet NIET:
- Antwoorden op warme replies
- Afspraken inplannen
- Prijzen noemen
- Onderhandelen

Dat ben jij. Het systeem geeft je de lead en de context — jij pakt het op.

> **ACTIE:** Escalatieregels zijn helder en ingebouwd. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Jij staat altijd in de lead bij warme prospects             │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[███████░░] 7/9 · Les 6 klaar`

---

## KLAAR

**Wat je nu hebt:**
- Classificatiescript dat replies sorteert op warm/follow-up/uitfilteren
- `pipeline.json` — een actueel overzicht van warme leads
- Follow-up logica die automatisch één herinnering verstuurt
- Escalatieregels: jij handelt altijd de warme leads af

**Volgende les:** `/outreach:07-dashboard` — Mission Control. Eén overzicht waar je live ziet hoeveel er verzonden is, wat de reactiegraad is, en welke leads in de pipeline zitten.
