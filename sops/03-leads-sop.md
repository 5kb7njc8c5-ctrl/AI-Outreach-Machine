# SOP — Leads (Les 3)

> **Dit is Les 3.** Vereist: `icp.md` uit Les 1. Je zoekt 50+ prospects die passen bij het ICP, screent ze, en slaat op in `leads.json`.

---

## Vereiste input

1. **`icp.md`** — screeningscriteria uit Les 1
2. **Gekozen bronnen** — uit STAP 1 van Les 3

---

## Datastructuur — `leads.json`

Elk lead-object heeft deze velden:

```json
{
  "id": "unieke-id",
  "naam": "Voornaam Achternaam",
  "bedrijf": "Bedrijfsnaam",
  "website": "https://website.nl",
  "email": "naam@bedrijf.nl",
  "sector": "E-commerce / Retail / etc.",
  "rol": "Eigenaar / Marketing Manager / etc.",
  "fit_score": 3,
  "observatie": "Specifieke observatie: ze verkopen kleding via Instagram maar hebben geen geautomatiseerde e-mailflow",
  "status": "nieuw",
  "toegevoegd": "2026-01-01",
  "verzonden": null,
  "reply": null
}
```

**Fit-scores** (uit `icp.md`):
- 3 = perfecte fit, direct benaderen
- 2 = goede fit, benaderen als score-3 pool gevuld is
- 1 = twijfelgeval, alleen benaderen als buffer leeg dreigt

---

## Instructies

### Stap 0 — Lees `icp.md`

Lees de must-have criteria, nice-to-have, disqualifiers en het perfecte lead-voorbeeld. Houd deze actief in je werkgeheugen — elke lead wordt hier tegen afgezet.

### Stap 1 — Zoek leads per bron

Voor elke bron die de cursist in STAP 1 heeft aangegeven:

**LinkedIn:**
```
Zoekterm: "[sector] [rol] Nederland site:linkedin.com"
Filter op: bedrijfsgrootte, sector, locatie
```

**Google Maps:**
```
Zoekterm: "[type bedrijf] [stad of regio]"
Check: reviews, website aanwezig, actief bedrijf
```

**Branchevereniging / ledenpagina:**
```
Bezoek de ledenpagina, verzamel bedrijfsnamen, zoek websites
```

**Instagram:**
```
Zoekterm: "#[niche] site:instagram.com"
Check: actief account, commercieel product/dienst, contactinfo in bio
```

Per bron: zoek totdat je 60-70 kandidaten hebt gevonden. Van die 60-70 blijven er na screening ~50 over.

### Stap 2 — Screen elke kandidaat

Per kandidaat, check tegen `icp.md`:

1. Voldoet aan must-have criteria? → Zo nee: skip
2. Heeft disqualifiers? → Zo ja: skip
3. Bepaal fit-score (1/2/3) op basis van must-have + nice-to-have
4. Schrijf een concrete observatie: wat zie je aan dit bedrijf dat relevant is voor het aanbod?

De observatie is het meest waardevolle. Een goede observatie is:
- Specifiek voor dít bedrijf
- Gerelateerd aan het probleem dat jij oplost
- Iets dat je kunt zien zonder hen te spreken (website, social media, reviews)

Slechte observatie: "Ze zijn actief op social media"
Goede observatie: "Ze posten dagelijks op Instagram maar de bio heeft geen link naar een webshop — ze laten waarschijnlijk conversies liggen"

### Stap 3 — Zoek e-mailadressen

Methoden (in volgorde van betrouwbaarheid):
1. Direct op de website (contact/over ons pagina)
2. `info@`, `hallo@`, `contact@` + domeinnaam (check op MX-record)
3. Patroon afleiden: als `j.jansen@bedrijf.nl` bestaat, probeer `l.achternaam@bedrijf.nl`
4. LinkedIn-profiel (soms zichtbaar)
5. WHOIS (bij persoonlijke domeinen)

Format e-mailadres altijd als lowercase. Twijfel je? Voeg toe met notitie `[verificatie nodig]`.

### Stap 4 — Opslaan in `leads.json`

Schrijf alle gescreende leads naar `leads.json`. Sorteer op fit-score (3 eerst).

Minimum: 50 leads, waarvan minimaal 20 met fit-score 3.

### Stap 5 — Rapporteer

Geef een overzicht:
- Totaal gevonden kandidaten
- Totaal opgeslagen leads
- Verdeling fit-scores (1/2/3)
- Bronnen die het meest opleverden
- Leads met `[verificatie nodig]` (zodat de cursist die kan opvolgen)

---

## Kwaliteitscheck

- Zijn er minimaal 20 leads met fit-score 3?
- Heeft elke lead een specifieke observatie (niet generiek)?
- Zijn alle e-mailadressen plausibel (format, domein bestaat)?
- Zijn er geen disqualifiers door de screening heen geslopen?
