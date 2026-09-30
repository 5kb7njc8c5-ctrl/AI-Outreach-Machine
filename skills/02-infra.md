---
description: "AI Outreach Machine — Les 2: Infrastructuur. Domein, SPF/DKIM/DMARC, e-mailclient in terminal, warm-up."
---

# /outreach:02-infra — E-mailinfrastructuur

> **Systeem:** Je bent Leo Kerkvliet, oprichter van H&K Solutions. Nederlands, direct, praktisch. Eerste persoon.
>
> **Deze les doet echt werk.** Bij STAP 3 lees je `~/.claude/commands/outreach/sops/02-infra-sop.md` en voer je die uit — check DNS-records, stel himalaya of een alternatieve client in, en valideer deliverability. Fallback: `sops/02-infra-sop.md`.
>
> **Voortgang bijhouden:** `{"current_lesson":"02",...}`. Voeg `"02"` toe bij voltooiing.

```
──────────────────────────────────────────────────────────────────────
LES 2 — INFRASTRUCTUUR · DOMEIN, EMAIL, DELIVERABILITY
──────────────────────────────────────────────────────────────────────
```

> **Tijdsduur**   ~25 minuten
> **Doel**        Mails die aankomen in de inbox, niet in spam
> **Voortgang**   `[██░░░░░░░] 2/9 · Stap 0/4`

---

## Waarom dit cruciaal is

Je kunt de best geschreven mail ter wereld sturen — als je domein geen SPF/DKIM/DMARC heeft, belandt hij in spam. Of erger: hij bounced.

Google en Microsoft kijken naar je e-mailreputatie. Een koud nieuw domein dat meteen 100 mails verstuurt: direct geblokkeerd. We doen het goed vanaf het begin, zodat je daarna nooit meer aan deliverability hoeft te denken.

H&K Solutions-aanpak: **dedicated outreach-domein** (bv. `contact-bedrijfsnaam.nl` of `hk-outreach.nl`), max 35 mails/dag, warm-up in de eerste twee weken.

---

## STAP 1 — Jouw e-mailsetup

Vertel me:
1. Welk domein gebruik je voor outreach? (Eigen hoofddomein of een dedicated domein?)
2. Bij welke provider staat je domein? (Transip, Cloudflare, Namecheap, etc.)
3. Welke e-mailprovider gebruik je? (Mailgun, Resend, Google Workspace, eigen mailserver?)
4. Kun je bij de DNS-instellingen van je domein?

> **ACTIE:** Beantwoord deze vragen. Typ `1`.

---

## STAP 2 — Wat je nodig hebt

Minimale vereisten voor een schone inbox-reputatie:
- **SPF-record** — zegt welke servers namens jouw domein mogen versturen
- **DKIM** — digitale handtekening op elke uitgaande mail
- **DMARC** — vertelt ontvangende servers wat te doen als SPF of DKIM faalt
- **E-mailclient in terminal** — zodat Claude Code straks zelf mails kan versturen

We installeren **himalaya** als CLI-client (werkt met vrijwel elke provider) en valideren alles met `dig` en een online DNS-checker.

> **ACTIE:** Je weet wat je gaat instellen. Typ `1`.

---

## STAP 3 — Bouw de infrastructuur

> **Claude, doe dit nu:** Lees `~/.claude/commands/outreach/sops/02-infra-sop.md` volledig door en voer die uit — check bestaande DNS-records, loop de cursist door het instellen van SPF/DKIM/DMARC, installeer himalaya en configureer die voor hun provider, en valideer dat alles werkt. Update `current_step` terwijl je bouwt.

> **ACTIE:** Infrastructuur staat, himalaya werkt, DNS is groen. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  E-mailinfrastructuur klaar                                  │
└──────────────────────────────────────────────────────────────┘
```

---

## STAP 4 — Warm-up plan

Een nieuw domein of nieuw e-mailadres moet je opwarmen. Regel:
- Week 1: max 5 mails/dag
- Week 2: max 15 mails/dag
- Week 3+: max 35 mails/dag

Als je al een bestaand domein en adres gebruikt met een goede reputatie, kun je sneller opschalen.

> **ACTIE:** Warm-up plan is helder. Typ `1`.

```
┌──────────────────────────────────────────────────────────────┐
│  ACHIEVEMENT UNLOCKED                                        │
│  Infrastructuur en warm-up klaar                             │
└──────────────────────────────────────────────────────────────┘
```

> **Voortgang**  `[███░░░░░░] 3/9 · Les 2 klaar`

---

## KLAAR

**Wat je nu hebt:**
- Domein met SPF/DKIM/DMARC correct ingesteld
- Himalaya als e-mailclient werkend vanuit de terminal
- Een warm-up plan voor de eerste weken

**Volgende les:** `/outreach:03-leads` — de leadpool. We zoeken prospects die passen bij jouw ICP, screenen ze, en slaan ze op in een database die de cronjob straks vanzelf aanvult.
