---
description: "AI Outreach Machine — Les 7: Dashboard. Mission Control — pipeline, verzending, reactiegraad in één overzicht."
---

# /outreach:07-dashboard — Mission Control

> **Systeem:** Je bent Leo Kerkvliet, oprichter van H&K Solutions. Nederlands, direct. Eerste persoon.
>
> **Deze les doet echt werk.** Bij STAP 2 lees je `~/.claude/commands/outreach/sops/07-dashboard-sop.md` en voer je die uit — bouw het HTML-dashboard dat live data leest uit de JSON-bestanden. Fallback: `sops/07-dashboard-sop.md`.
>
> **Voortgang bijhouden:** `{"current_lesson":"07",...}`. Voeg `"07"` toe bij voltooiing.

```
──────────────────────────────────────────────────────────────────────
LES 7 — DASHBOARD · MISSION CONTROL
──────────────────────────────────────────────────────────────────────
```

> **Tijdsduur**   ~30 minuten
> **Doel**        Eén overzicht dat live toont wat het systeem doet
> **Voortgang**   `[███████░░] 7/9 · Stap 0/3`

---

## Waarom een dashboard

Als je het systeem niet kunt zien, weet je niet of het werkt. En als je het weet, kun je bijsturen.

Het H&K Solutions dashboard toont op één scherm:
- **Pipeline** — warme leads, status, laatste activiteit
- **Verzending** — verzonden vandaag / deze week / totaal
- **Reactiegraad** — replies % per variant (A/B/C test)
- **Bounces** — signaal voor deliverability-problemen
- **Cronjob-status** — wanneer elke job voor het laatst draaide

Geen login, geen externe service, geen kosten. Eén HTML-bestand dat lokaal draait en je JSON-bestanden leest.

---

## STAP 1 — Datapunten

Het dashboard leest uit:
- `leads.json` — totaal leads, status-verdeling
- `replies.json` — reacties, categorieën
- `pipeline.json` — warme leads, datum
- `logs/verzending.log` — verzonden mails per dag

Controleer dat deze bestanden bestaan en data bevatten.

> **ACTIE:** Bestanden gecheckt. Typ `1`.

---

## STAP 2 — Bouw het dashboard

> **Claude, doe dit nu:** Lees `~/.claude/commands/outreach/sops/07-dashboard-sop.md` volledig door en voer die uit — bouw `dashboard.html` dat lokaal draait, de JSON-bestanden elke 30s opnieuw leest, en de bovenstaande datapunten toont in een overzichtelijk dark-mode design. Start een Python-server op poort 8767. Update `current_step`.

> **ACTIE:** Dashboard draait op `http://localhost:8767/dashboard.html`. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Mission Control live                                        │
└──────────────────────────────────────────────────────────────┘
```

---

## STAP 3 — Verifieer de data

Open het dashboard en check:
- Komen de aantallen overeen met wat er in je JSON-bestanden staat?
- Refresht het dashboard automatisch?
- Zie je de warme leads in de pipeline?

> **ACTIE:** Dashboard toont correcte data. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Dashboard geverifieerd — live data klopt                    │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[████████░] 8/9 · Les 7 klaar`

---

## KLAAR

**Wat je nu hebt:**
- `dashboard.html` — live Mission Control voor je outreach-systeem
- Python-server op poort 8767
- Real-time inzicht in pipeline, verzending en reactiegraad

**Volgende les:** `/outreach:08-schalen` — de laatste les. Wat je meet, wanneer je opschaalt, en wat je kunt uitbesteden als je wil groeien.
