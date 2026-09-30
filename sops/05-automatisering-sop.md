# SOP — Automatisering (Les 5)

> **Dit is Les 5.** Vereist: himalaya werkend (Les 2), `leads.json` gevuld (Les 3), templates klaar (Les 4). Je bouwt drie Python-scripts en plant ze als cronjobs.

---

## De drie scripts

### `scripts/aanvullen.py`

Doel: Elke nacht de leadpool aanvullen zodat er altijd ≥50 leads met status `nieuw` zijn.

```python
#!/usr/bin/env python3
"""
aanvullen.py — Vult de leadpool aan tot minimaal 50 nieuwe leads.
Draait via cronjob om 01:00.
"""
import json
import subprocess
import datetime
import os

LEADS_FILE = "leads.json"
MIN_BUFFER = 50
LOG_FILE = "logs/aanvullen.log"

def log(msg):
    ts = datetime.datetime.now().isoformat()
    os.makedirs("logs", exist_ok=True)
    with open(LOG_FILE, "a") as f:
        f.write(f"[{ts}] {msg}\n")
    print(f"[{ts}] {msg}")

def load_leads():
    if not os.path.exists(LEADS_FILE):
        return []
    with open(LEADS_FILE) as f:
        return json.load(f)

def save_leads(leads):
    with open(LEADS_FILE, "w") as f:
        json.dump(leads, f, indent=2, ensure_ascii=False)

def count_new(leads):
    return sum(1 for l in leads if l.get("status") == "nieuw")

def main():
    leads = load_leads()
    nieuw = count_new(leads)
    log(f"Huidige leadpool: {len(leads)} totaal, {nieuw} nieuw")
    
    if nieuw >= MIN_BUFFER:
        log(f"Buffer vol ({nieuw} >= {MIN_BUFFER}). Niets te doen.")
        return
    
    needed = MIN_BUFFER - nieuw
    log(f"Buffer aanvullen: {needed} nieuwe leads nodig")
    
    # Hier roep je de zoek-logica aan (web search, LinkedIn scrape, etc.)
    # Dit wordt ingevuld op basis van de bronnen die de cursist in Les 3 heeft gekozen.
    # Placeholder: log dat dit geconfigureerd moet worden.
    log(f"[CONFIGUREER] Zoeklogica hier toevoegen op basis van jouw bronnen (zie icp.md)")
    log(f"Aanvullen klaar. Nieuwe buffer: {count_new(load_leads())}")

if __name__ == "__main__":
    main()
```

### `scripts/verzenden.py`

Doel: Elke ochtend 10-15 gepersonaliseerde mails versturen.

```python
#!/usr/bin/env python3
"""
verzenden.py — Verstuurt 10-15 gepersonaliseerde cold emails.
Draait via cronjob om 08:00.
"""
import json
import subprocess
import datetime
import os
import random

LEADS_FILE = "leads.json"
TEMPLATES_DIR = "templates"
LOG_FILE = "logs/verzending.log"
MAX_PER_DAG = 15
MIN_PER_DAG = 10

def log(msg):
    ts = datetime.datetime.now().isoformat()
    os.makedirs("logs", exist_ok=True)
    with open(LOG_FILE, "a") as f:
        f.write(f"[{ts}] {msg}\n")
    print(f"[{ts}] {msg}")

def load_leads():
    with open(LEADS_FILE) as f:
        return json.load(f)

def save_leads(leads):
    with open(LEADS_FILE, "w") as f:
        json.dump(leads, f, indent=2, ensure_ascii=False)

def load_template(variant):
    path = os.path.join(TEMPLATES_DIR, f"variant-{variant}.md")
    with open(path) as f:
        return f.read()

def personaliseer(template, lead):
    """Vul placeholders in op basis van lead-data."""
    tekst = template
    tekst = tekst.replace("{{NAAM}}", lead.get("naam", "").split()[0])
    tekst = tekst.replace("{{OBSERVATIE}}", lead.get("observatie", ""))
    tekst = tekst.replace("{{AFZENDER}}", "Leo Kerkvliet")  # aanpassen per gebruiker
    return tekst

def extract_subject(template_text):
    """Haal de onderwerpregel op uit het template."""
    for line in template_text.split("\n"):
        if line.startswith("**Onderwerp:**"):
            return line.replace("**Onderwerp:**", "").strip()
    return "Korte vraag"

def stuur_mail(lead, template_text):
    """Verstuur via himalaya."""
    subject = extract_subject(template_text)
    body = "\n".join(
        line for line in template_text.split("\n")
        if not line.startswith("**Onderwerp:**") and not line.startswith("---") and not line.startswith("# Template")
    ).strip()
    
    cmd = [
        "himalaya", "send",
        "--account", "outreach",
        "--to", lead["email"],
        "--subject", subject,
    ]
    
    result = subprocess.run(cmd, input=body, text=True, capture_output=True)
    return result.returncode == 0

def main():
    leads = load_leads()
    
    # Selecteer leads: score-3 eerst, dan score-2
    kandidaten = [l for l in leads if l.get("status") == "nieuw"]
    kandidaten.sort(key=lambda x: x.get("fit_score", 1), reverse=True)
    
    te_versturen = kandidaten[:MAX_PER_DAG]
    
    if len(te_versturen) < MIN_PER_DAG:
        log(f"WAARSCHUWING: Slechts {len(te_versturen)} leads beschikbaar (min {MIN_PER_DAG}). Buffer aanvullen!")
    
    log(f"Versturen: {len(te_versturen)} mails")
    
    varianten = ["a", "b", "c"]
    
    for i, lead in enumerate(te_versturen):
        variant = varianten[i % len(varianten)]  # roterend A/B/C
        template = load_template(variant)
        tekst = personaliseer(template, lead)
        
        succes = stuur_mail(lead, tekst)
        
        if succes:
            lead["status"] = "verzonden"
            lead["verzonden"] = datetime.datetime.now().isoformat()
            lead["template_variant"] = variant
            log(f"✅ {lead['bedrijf']} ({lead['email']}) — variant {variant.upper()}")
        else:
            log(f"❌ MISLUKT: {lead['bedrijf']} ({lead['email']})")
    
    save_leads(leads)
    log(f"Verzending klaar. {sum(1 for l in te_versturen if l.get('status') == 'verzonden')} succesvol.")

if __name__ == "__main__":
    main()
```

### `scripts/inbox.py`

Doel: Inbox checken, replies classificeren, loggen in `replies.json`.

```python
#!/usr/bin/env python3
"""
inbox.py — Checkt de inbox en classificeert replies.
Draait via cronjob elke 30 minuten.
"""
import json
import subprocess
import datetime
import os

REPLIES_FILE = "replies.json"
PIPELINE_FILE = "pipeline.json"
LOG_FILE = "logs/inbox.log"

WARM_SIGNALEN = [
    "interesse", "meer weten", "wanneer", "bellen", "praten",
    "stuur me", "vertel me", "hoe werkt", "wat kost", "call",
    "afspraak", "demo", "vrijblijvend"
]

AUTO_REPLY_SIGNALEN = [
    "out of office", "afwezig", "vakantie", "automatisch antwoord",
    "auto-reply", "op vakantie", "niet aanwezig"
]

OPT_OUT_SIGNALEN = [
    "uitschrijven", "unsubscribe", "verwijder", "geen interesse",
    "niet meer mailen", "stop met mailen"
]

def log(msg):
    ts = datetime.datetime.now().isoformat()
    os.makedirs("logs", exist_ok=True)
    with open(LOG_FILE, "a") as f:
        f.write(f"[{ts}] {msg}\n")

def load_json(path, default):
    if not os.path.exists(path):
        return default
    with open(path) as f:
        return json.load(f)

def save_json(path, data):
    with open(path, "w") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

def classificeer(tekst):
    tekst_lower = tekst.lower()
    if any(s in tekst_lower for s in OPT_OUT_SIGNALEN):
        return "opt-out"
    if any(s in tekst_lower for s in AUTO_REPLY_SIGNALEN):
        return "auto-reply"
    if any(s in tekst_lower for s in WARM_SIGNALEN):
        return "warm"
    return "neutraal"

def haal_inbox_op():
    """Haal ongelezen mails op via himalaya."""
    result = subprocess.run(
        ["himalaya", "list", "--account", "outreach", "--folder", "INBOX", "--max-width", "0"],
        capture_output=True, text=True
    )
    # Parse de output — himalaya geeft een tabel terug
    # Vereenvoudigd: geef de raw output terug voor verwerking
    return result.stdout

def main():
    replies = load_json(REPLIES_FILE, [])
    pipeline = load_json(PIPELINE_FILE, [])
    
    log("Inbox check gestart")
    inbox_output = haal_inbox_op()
    
    # Verwerk inbox_output — pas aan op basis van himalaya's werkelijke output
    # Dit is een placeholder die werkt zodra himalaya geconfigureerd is
    log(f"Inbox check klaar. {len(pipeline)} warme leads in pipeline.")
    
    save_json(REPLIES_FILE, replies)
    save_json(PIPELINE_FILE, pipeline)

if __name__ == "__main__":
    main()
```

---

## Cronjobs instellen

### Via Hermes (aanbevolen als Hermes geïnstalleerd is)

Voeg toe via `hermes cron add`:
```
0 1 * * *   cd /pad/naar/jouw/outreach && python3 scripts/aanvullen.py
0 8 * * *   cd /pad/naar/jouw/outreach && python3 scripts/verzenden.py
*/30 * * * * cd /pad/naar/jouw/outreach && python3 scripts/inbox.py
```

### Via systeemcron (altijd beschikbaar)

```bash
crontab -e
```

Voeg toe:
```
0 1 * * *    cd /pad/naar/jouw/outreach && python3 scripts/aanvullen.py >> logs/cron.log 2>&1
0 8 * * *    cd /pad/naar/jouw/outreach && python3 scripts/verzenden.py >> logs/cron.log 2>&1
*/30 * * * * cd /pad/naar/jouw/outreach && python3 scripts/inbox.py >> logs/cron.log 2>&1
```

---

## Dry-run test

Voordat je live gaat, test elk script met dry-run:

```bash
# Test verzendscript — stuur naar jezelf
python3 scripts/verzenden.py --dry-run  # als je een --dry-run flag toevoegt
# Of: pas MAX_PER_DAG tijdelijk aan naar 1 en to-adres naar je eigen e-mail
```

Check na de test:
- Mail ontvangen?
- Lead op `verzonden` in `leads.json`?
- Correct gelogd in `logs/verzending.log`?

---

## Instructie aan Claude Code

1. Schrijf de drie scripts naar `scripts/` op basis van bovenstaande templates
2. Pas de configuratie aan op basis van de setup van de cursist (himalaya account-naam, afzender, etc.)
3. Maak `logs/` aan
4. Plan de cronjobs via Hermes of systeemcron
5. Voer een dry-run uit en rapporteer het resultaat
