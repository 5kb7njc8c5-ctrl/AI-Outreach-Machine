# AI Outreach Machine — door H&K Solutions

Een interactieve cursus. Lees de instructies in je Claude Code terminal, voer ze live uit, en volg je voortgang in het dashboard. **9 lessen, één werkdag, gratis.**

Ga van **nul naar een draaiend outreach-systeem — volledig in Claude Code**: doelgroeponderzoek → e-mailinfrastructuur → leadpool → gepersonaliseerde cold emails → automatische verzending via cronjobs → inbox-management → Mission Control dashboard.

We bouwen het systeem dat H&K Solutions zelf gebruikt als worked example — **10-15 verzonden mails per dag, gescreende leads, replies die binnenkomen** — zodat je precies ziet hoe het werkt, en het daarna zelf draait voor jouw bedrijf of dat van een klant.

---

## Wat je hebt gebouwd aan het einde

1. **Vier foundation docs** — `doelgroep.md`, `aanbod.md`, `icp.md`, `copy-vault.md`.
2. **Een werkende e-mailinfrastructuur** — eigen domein, SPF/DKIM/DMARC geconfigureerd, warm-up klaar, e-mailclient werkend vanuit de terminal.
3. **Een leadpool van 50+ gescreende leads** — in een JSON/CSV, gesorteerd op fit.
4. **Cold email templates** — gebaseerd op jouw onderzoek, op jouw stem.
5. **Geautomatiseerde cronjobs** — leadpool aanvullen (nacht), verzending (ochtend), inbox checken (overdag).
6. **Een inbox-workflow** — replies herkend, follow-ups gepland, jijzelf alleen betrokken als het telt.
7. **Een Mission Control dashboard** — pipeline, verzonden, reactiepercentage — alles in één overzicht.
8. **Een schaalplan** — wat je meet, wanneer je opschaalt, wat je uitbesteedt.

---

## Installatie (2 min)

**Haal de cursus op:**

```bash
git clone https://github.com/5kb7njc8c5-ctrl/AI-Outreach-Machine.git
cd AI-Outreach-Machine
```

*(Geen git? Klik op de groene **Code** knop → **Download ZIP**, pak uit en ga de map in.)*

**Je hebt nodig:**
- Claude Code geïnstalleerd (`claude --version`)
- Python 3 (`python3 --version`)
- Een domein voor outreach (eigen domein of een dedicated outreach-domein)
- Voor Les 8: toegang tot een e-mailprovider (Mailgun, Resend of Gmail met app-password)

**Installeer:**

```bash
# vanuit de uitgepakte cursusmap:
./install.sh
```

Het script:
1. Kopieert de 9 lesson skills naar `~/.claude/commands/outreach/`
2. Kopieert de SOPs + prompts naar de juiste subfolders
3. Maakt een voortgangsmap aan in `~/.outreach-machine/`
4. Start het dashboard op `http://localhost:8767/dashboard.html`
5. Opent je browser automatisch

**Start:**

Maak een **nieuwe lege map voor jouw outreach-systeem**, open Claude Code daarin, en voer uit:

```
/outreach:00-intro
```

---

## Lessen

| # | Command | Tijd | Onderwerp |
|---|---------|------|-----------|
| 0 | `/outreach:00-intro` | 5 min | Welkom + wat je bouwt + setup check |
| 1 | `/outreach:01-fundament` | 30 min | Doelgroep, pijn, aanbod → 4 foundation docs |
| 2 | `/outreach:02-infra` | 25 min | Domein, SPF/DKIM/DMARC, e-mailclient in terminal |
| 3 | `/outreach:03-leads` | 35 min | Leads vinden, screenen, database opzetten |
| 4 | `/outreach:04-copy` | 30 min | Cold email templates op basis van jouw onderzoek |
| 5 | `/outreach:05-automatisering` | 40 min | Cronjobs: aanvullen, verzenden, inbox checken |
| 6 | `/outreach:06-inbox` | 25 min | Replies herkennen, follow-ups, escalatie |
| 7 | `/outreach:07-dashboard` | 30 min | Mission Control: pipeline + cijfers in één view |
| 8 | `/outreach:08-schalen` | 15 min | Wat je meet, wanneer je opschaalt, wat daarna |

---

## Hoe het systeem werkt

Het is exact het systeem dat H&K Solutions zelf draait. Iedere nacht wordt de leadpool aangevuld. Iedere ochtend gaan 10-15 mails de deur uit. Overdag checkt een cronjob de inbox elke 30 minuten. Als er een reply binnenkomt, word jij er alleen bij gehaald als het echt telt.

De SOPs in `sops/` zijn de werkende draaiboeken — Claude Code leest ze en bouwt het systeem voor je. Je kunt ze ook los gebruiken als je al een deel hebt staan.

---

## Aan het einde

Dit systeem heb je nu zelf gebouwd en in beheer. Als je wil dat H&K Solutions het voor jou bouwt, beheert en optimaliseert — plan een vrijblijvend consult:

**→ https://calendly.com/hk-solutions/callmaillink**

---

*H&K Solutions · hk-solutions.nl · Leo Kerkvliet*
