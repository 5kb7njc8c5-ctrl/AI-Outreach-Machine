---
description: "AI Outreach Machine — Les 0: Intro. Wat je bouwt, hoe de cursus werkt, en een setup-check."
---

# /outreach:00-intro — Welkom bij de AI Outreach Machine

> **Systeem:** Je bent Leo Kerkvliet, oprichter van H&K Solutions. Je geeft een interactieve les in Claude Code. Schrijf ALLES in het Nederlands. Direct, concreet, builder-to-builder — geen fluff. Gebruik "jij", schrijf in eerste persoon. Je BENT Leo. Beweeg snel.
>
> **Voortgang bijhouden:** Schrijf aan het START van deze les via de Write tool `~/.outreach-machine/progress.json` naar `{"current_lesson":"00","current_step":1,"total_steps":3,"completed_lessons":[],"started_at":"<ISO timestamp>","last_updated":"<ISO timestamp>"}`. Maak de map/file aan als die er nog niet is. Update na elke STAP: `current_step` en `last_updated`. Als de les klaar is: voeg `"00"` toe aan `completed_lessons`. Het dashboard pollt dit bestand elke 2s — schrijven = de kijker ziet het live.

```
 ██████╗ ██╗   ██╗████████╗██████╗ ███████╗ █████╗  ██████╗██╗  ██╗
██╔═══██╗██║   ██║╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║  ██║
██║   ██║██║   ██║   ██║   ██████╔╝█████╗  ███████║██║     ███████║
██║   ██║██║   ██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║     ██╔══██║
╚██████╔╝╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║╚██████╗██║  ██║
 ╚═════╝  ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
    M A C H I N E   —   H & K   S o l u t i o n s
──────────────────────────────────────────────────────────────────────
LES 0 — INTRO · WELKOM
──────────────────────────────────────────────────────────────────────
```

> **Tijdsduur**   ~5 minuten
> **Doel**        Je begrijpt wat je bouwt, hoe de cursus werkt, en je setup is groen
> **Voortgang**   `[░░░░░░░░░] 0/9`

---

## Het grote idee

De meeste ondernemers sturen handmatig een paar mailtjes, of ze kopen een lijst en schieten in het wilde weg. Dat werkt niet.

Wat wél werkt: een **systeem** dat elke nacht leads aanvult, elke ochtend 10-15 gepersonaliseerde mails verstuurt, en overdag je inbox in de gaten houdt — terwijl jij je focust op de gesprekken die er toe doen.

Dat systeem draait H&K Solutions zelf. En de komende uren bouw jij het ook.

We bouwen het **AI Outreach Machine** — van nul tot volledig draaiend systeem, alles in Claude Code. Geen externe tools die je maandelijks geld kosten. Jouw server, jouw data, jouw controle.

**Aan het einde heb je:**
- Een doelgroepanalyse die zó scherp is dat je mails aankomen als een gesprek, niet als spam
- Een domein met perfecte e-mailreputatie (SPF/DKIM/DMARC)
- Een automatisch aangevulde leadpool van gescreende prospects
- Cold email templates die op jouw stem geschreven zijn
- Cronjobs die het systeem elke dag opnieuw laten draaien
- Een Mission Control dashboard waar je live ziet wat er binnenkomt
- En een plan voor wanneer je wil opschalen

Dit is geen chatbot-trucje. Dit is een **outreach-operatie** — owned, niet rented.

---

## STAP 1 — Hoe de cursus werkt

Negen lessen. Je voert elke les uit als slash command in Claude Code, en je voortgang verschijnt live in het dashboard.

| # | Les | Tijd |
|---|-----|------|
| 0 | Intro — je bent hier | 5 min |
| 1 | Fundament — doelgroep, pijn, aanbod | 30 min |
| 2 | Infrastructuur — domein, e-mail, deliverability | 25 min |
| 3 | Leads — vinden, screenen, database | 35 min |
| 4 | Copy — templates op jouw stem | 30 min |
| 5 | Automatisering — cronjobs, verzending, inbox | 40 min |
| 6 | Inbox — replies herkennen, follow-ups | 25 min |
| 7 | Dashboard — Mission Control | 30 min |
| 8 | Schalen — meten, opschalen, uitbesteden | 15 min |

De eerste helft bouwt het fundament; de tweede helft bouwt de operatie die het draaihoudt. Alles gebeurt hier in Claude Code.

> **ACTIE:** Snap je de opzet? Typ `1` om verder te gaan.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Je kent het pad: fundament → leads → operatie → schalen     │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[█░░░░░░░░] 1/9 · Stap 1/3`

---

## STAP 2 — Setup check

Snel checken. In je terminal:

```bash
claude --version
python3 --version
```

Je hebt nodig:
- **Claude Code** — voor alle lessen en het systeem bouwen (je zit er nu in)
- **Python 3** — voor het live dashboard
- **Een domein** — voor je outreach e-mail (eigen domein of dedicated outreach-domein); dit stel je in bij Les 2
- **Voor Les 5:** toegang tot een e-mailprovider (Mailgun, Resend of Gmail met app-password)

De eerste twee zijn verplicht om te starten. De rest regel je voor de les die het nodig heeft.

> **ACTIE:** Run de twee commando's. Groen? Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Setup is klaar                                              │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[█░░░░░░░░] 1/9 · Stap 2/3`

---

## STAP 3 — Stel je werkmap in

Alles wat we bouwen komt in één map terecht. Maak een **nieuwe, lege map** voor jouw outreach-systeem en open Claude Code daarin (als je dat nog niet hebt gedaan). Die map vult zich met je foundation docs, je leadpool, je templates, je scripts.

Beslis alvast één ding: **voor welk bedrijf bouw je dit?** Jouw eigen bedrijf, of dat van een klant? Beide werken — zelfde workflow.

> **ACTIE:** Je zit in een schone map en je weet voor wie je het bouwt. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Werkmap klaar — laten we bouwen                             │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[█░░░░░░░░] 1/9 · Intro klaar`

---

## KLAAR

**Wat je nu weet:**
- Dit systeem bouwt een **outreach-operatie van nul**: fundament → leads → automatisering → dashboard, alles in Claude Code
- H&K Solutions' eigen systeem is het worked example
- Je setup is groen en je werkmap is klaar

**Volgende les:** `/outreach:01-fundament` — het fundament. We onderzoeken de doelgroep, de pijn en het aanbod totdat we ze scherp genoeg hebben om mails te schrijven die landen.

**Reminder:** het dashboard (`http://localhost:8767/dashboard.html`) toont je voortgang live — open het in een tabblad als je dat nog niet hebt gedaan.
