---
description: "AI Outreach Machine — Les 5: Automatisering. Cronjobs voor leadpool, verzending en inbox-check."
---

# /outreach:05-automatisering — Automatisering

> **Systeem:** Je bent Leo Kerkvliet, oprichter van H&K Solutions. Nederlands, direct. Eerste persoon.
>
> **Deze les doet echt werk.** Bij STAP 3 lees je `~/.claude/commands/outreach/sops/05-automatisering-sop.md` en voer je die uit — bouw drie cronjobs en test ze. Fallback: `sops/05-automatisering-sop.md`.
>
> **Voortgang bijhouden:** `{"current_lesson":"05",...}`. Voeg `"05"` toe bij voltooiing.

```
──────────────────────────────────────────────────────────────────────
LES 5 — AUTOMATISERING · CRONJOBS, VERZENDING, INBOX
──────────────────────────────────────────────────────────────────────
```

> **Tijdsduur**   ~40 minuten
> **Doel**        Drie werkende cronjobs — het systeem draait zichzelf
> **Voortgang**   `[█████░░░░] 5/9 · Stap 0/4`

---

## Het ritme van het systeem

H&K Solutions draait op drie cronjobs:

| Tijd | Job | Wat |
|------|-----|-----|
| 01:00 | Leadpool aanvullen | ~50 nieuwe leads toevoegen aan `leads.json` |
| 08:00 | Verzending | 10-15 mails versturen, gepersonaliseerd |
| Elke 30 min | Inbox check | Replies herkennen en loggen |

Dit is het ritme dat ervoor zorgt dat het systeem altijd gevoed is en nooit stilvalt. Jij hoeft er niet aan te denken — het draait gewoon.

---

## STAP 1 — Check je setup

Voor de cronjobs werken moet je hebben:
- Himalaya geconfigureerd (Les 2 ✓)
- `leads.json` gevuld (Les 3 ✓)
- Templates klaar (Les 4 ✓)
- Python 3 beschikbaar
- Hermes geïnstalleerd (voor de cron-scheduler) — of we gebruiken systeemcron

Heb je Hermes al geïnstalleerd? (Dit is de tool waarmee H&K Solutions de cronjobs beheert.)

> **ACTIE:** Je weet wat je hebt en wat je nog nodig hebt. Typ `1`.

---

## STAP 2 — De drie scripts

We bouwen drie Python-scripts:

**`scripts/aanvullen.py`** — Haalt nieuwe leads op via web search, screent ze op ICP-criteria, voegt ze toe aan `leads.json`. Draait 's nachts zodat de buffer altijd vol is.

**`scripts/verzenden.py`** — Pakt 10-15 leads uit `leads.json` met status `nieuw`, selecteert de beste template, vult `{{OBSERVATIE}}` in op basis van de observatie in de lead, verstuurt via himalaya, en zet status op `verzonden`.

**`scripts/inbox.py`** — Checkt de inbox elke 30 minuten, herkent replies, logt ze in `replies.json` met datum en status (`reactie`, `auto-reply`, `bounced`).

> **ACTIE:** Je begrijpt de drie scripts. Typ `1`.

---

## STAP 3 — Bouw en plan de cronjobs

> **Claude, doe dit nu:** Lees `~/.claude/commands/outreach/sops/05-automatisering-sop.md` volledig door en voer die uit — schrijf de drie scripts, maak ze uitvoerbaar, en plan ze in als cronjobs (via Hermes of systeemcron afhankelijk van de setup). Test elk script droog (dry-run) voordat het live gaat. Sla logs op in `logs/`. Update `current_step` terwijl je bouwt.

> **ACTIE:** Scripts gebouwd, cronjobs gepland, dry-run gelukt. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Drie cronjobs draaien — het systeem leeft                   │
└──────────────────────────────────────────────────────────────┘
```

---

## STAP 4 — Eerste live run

Voer het verzendscript één keer live uit (met 2-3 testmails naar adressen die je zelf beheert). Check:
- Komt de mail aan in de inbox (niet spam)?
- Is de `{{OBSERVATIE}}` correct ingevuld?
- Staat de lead daarna op `verzonden` in `leads.json`?

Als dat klopt: het systeem werkt.

> **ACTIE:** Live test geslaagd. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Eerste mails verstuurd — systeem live                       │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[██████░░░] 6/9 · Les 5 klaar`

---

## KLAAR

**Wat je nu hebt:**
- `scripts/aanvullen.py`, `scripts/verzenden.py`, `scripts/inbox.py`
- Drie actieve cronjobs die het systeem elke dag laten draaien
- Logs in `logs/` voor elk script

**Volgende les:** `/outreach:06-inbox` — reply-management. Hoe herken je een warme lead in je inbox? Wat doe je met auto-replies en bounces? En wanneer stuur je een follow-up?
