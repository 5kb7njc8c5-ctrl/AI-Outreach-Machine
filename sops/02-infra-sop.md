# SOP — Infrastructuur (Les 2)

> **Dit is Les 2.** Voer dit uit nadat de cursist de vier vragen in STAP 1 van `/outreach:02-infra` heeft beantwoord. Je configureert de e-mailinfrastructuur en installeert himalaya als CLI-client.

---

## Vereiste input

1. **Domein** — welk domein wordt gebruikt voor outreach
2. **DNS-provider** — waar de domein-DNS beheerd wordt
3. **E-mailprovider** — Mailgun, Resend, Google Workspace, of eigen mailserver
4. **DNS-toegang** — of de cursist bij de DNS-instellingen kan

---

## Wat je bouwt

- Gecheckte en (indien nodig) gecorrigeerde SPF/DKIM/DMARC-records
- Himalaya geïnstalleerd en geconfigureerd voor de opgegeven e-mailprovider
- Verificatie dat een testmail aankomt en de headers correct zijn

---

## Instructies

### Stap 0 — Check bestaande DNS-records

Voer uit in de terminal:

```bash
# Check SPF
dig TXT <domein> | grep spf

# Check DKIM (pas de selector aan op basis van de provider)
dig TXT default._domainkey.<domein>
dig TXT mail._domainkey.<domein>

# Check DMARC
dig TXT _dmarc.<domein>
```

Rapporteer wat er staat. Als records ontbreken of incorrect zijn: ga door naar Stap 1.

### Stap 1 — SPF instellen

SPF-record formaat (aanpassen per provider):

**Mailgun:**
```
v=spf1 include:mailgun.org ~all
```

**Resend:**
```
v=spf1 include:spf.resend.com ~all
```

**Google Workspace:**
```
v=spf1 include:_spf.google.com ~all
```

**Eigen mailserver:**
```
v=spf1 ip4:<server-ip> ~all
```

Instructie aan cursist: voeg dit TXT-record toe aan je DNS bij `<domein>` (niet een subdomein).

### Stap 2 — DKIM instellen

DKIM-instelling is afhankelijk van de provider:
- **Mailgun / Resend:** genereer DKIM-sleutel in het dashboard, voeg de gegenereerde TXT-records toe
- **Google Workspace:** activeer DKIM in de Google Admin console, kopieer het record
- **Eigen mailserver:** genereer keypair met `opendkim-genkey`, voeg het publieke sleutel-record toe

Geef de cursist de exacte stappen voor hun provider. Vermeld de selector (bijv. `default`, `s1`, of wat de provider aangeeft).

Verificatie na toevoeging (wacht 5-15 min voor DNS-propagatie):
```bash
dig TXT <selector>._domainkey.<domein>
```

### Stap 3 — DMARC instellen

Minimaal DMARC-record (monitoring-modus, geen afwijzing):
```
v=DMARC1; p=none; rua=mailto:dmarc@<domein>
```

Voeg toe als TXT-record op `_dmarc.<domein>`.

Na enkele weken kun je upgraden naar `p=quarantine` of `p=reject` als de rapporten groen zijn.

### Stap 4 — Himalaya installeren en configureren

**Installatie:**
```bash
# macOS via Homebrew
brew install himalaya

# Of via cargo
cargo install himalaya
```

**Configuratie** — maak `~/.config/himalaya/config.toml` aan:

Voor **Mailgun** (SMTP):
```toml
[accounts.outreach]
email = "jij@jouwdomein.nl"
display-name = "Jouw Naam"

[accounts.outreach.smtp]
host = "smtp.mailgun.org"
port = 587
login = "postmaster@jouwdomein.mailgun.org"
passwd-cmd = "echo <MAILGUN_SMTP_PASSWORD>"

[accounts.outreach.imap]
host = "imap.mailgun.org"
port = 993
login = "jij@jouwdomein.nl"
passwd-cmd = "echo <MAILGUN_IMAP_PASSWORD>"
```

Voor **Google Workspace** (App Password):
```toml
[accounts.outreach]
email = "jij@jouwdomein.nl"
display-name = "Jouw Naam"

[accounts.outreach.smtp]
host = "smtp.gmail.com"
port = 587
login = "jij@jouwdomein.nl"
passwd-cmd = "echo <APP_PASSWORD>"

[accounts.outreach.imap]
host = "imap.gmail.com"
port = 993
login = "jij@jouwdomein.nl"
passwd-cmd = "echo <APP_PASSWORD>"
```

Pas aan op basis van de provider van de cursist.

### Stap 5 — Test verzending

```bash
# Stuur een testmail naar een adres dat je controleert
echo "Test van himalaya" | himalaya send --account outreach \
  --to "test@jouweigendomein.nl" \
  --subject "Himalaya test"
```

Check in de inbox:
- Komt de mail aan (niet in spam)?
- Toont de header `Authentication-Results` een groen SPF/DKIM/DMARC?

Als de mail in spam belandt: check de headers voor de reden.

### Stap 6 — Rapporteer

Geef een overzicht:
- SPF: ✅ / ❌ (met exacte record)
- DKIM: ✅ / ❌ (met selector)
- DMARC: ✅ / ❌
- Himalaya: ✅ werkend / ❌ fout (met foutmelding)
- Testmail: ✅ inbox / ❌ spam

Als iets ❌ is: geef de exacte volgende stap voor de cursist.

---

## Veelvoorkomende problemen

**DNS propagatie:** nieuwe records duren 5-60 minuten. Verificeer niet meteen na instellen.

**DKIM selector niet gevonden:** controleer of je de juiste selector gebruikt (vraag de provider als onduidelijk).

**Himalaya IMAP fout:** bij Google Workspace moet "Less secure app access" aan, of je gebruikt een App Password.

**Mail in spam ondanks groene headers:** het domein heeft nog geen reputatie. Warm-up is dan het enige antwoord — zie de warm-up regels in Les 2 STAP 4.
