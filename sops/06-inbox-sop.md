# SOP — Inbox Management (Les 6)

> **Dit is Les 6.** Vereist: `replies.json` aanwezig (aangemaakt door inbox.py uit Les 5). Je bouwt de classificatie, follow-up logica en pipeline.

---

## Wat je bouwt

- `scripts/classificeer.py` — verwerkt `replies.json`, voegt toe aan `pipeline.json`, plant follow-ups
- `scripts/followup.py` — verstuurt follow-ups voor leads die 5 dagen niet gereageerd hebben
- Updated `leads.json` met opt-outs verwijderd

---

## `scripts/classificeer.py`

```python
#!/usr/bin/env python3
"""
classificeer.py — Verwerkt replies, classificeert, voegt warme leads toe aan pipeline.
Draait na elke inbox-check (kan gecombineerd worden met inbox.py).
"""
import json
import datetime
import os

REPLIES_FILE = "replies.json"
PIPELINE_FILE = "pipeline.json"
LEADS_FILE = "leads.json"
LOG_FILE = "logs/pipeline.log"

WARM_SIGNALEN = [
    "interesse", "meer weten", "wanneer", "bellen", "praten",
    "stuur me", "vertel me", "hoe werkt", "wat kost", "call",
    "afspraak", "demo", "vrijblijvend", "graag", "ja", "zeker"
]

OPT_OUT_SIGNALEN = [
    "uitschrijven", "unsubscribe", "verwijder", "geen interesse",
    "niet meer mailen", "stop met mailen", "afmelden"
]

def log(msg):
    ts = datetime.datetime.now().isoformat()
    os.makedirs("logs", exist_ok=True)
    with open(LOG_FILE, "a") as f:
        f.write(f"[{ts}] {msg}\n")
    print(f"[{ts}] {msg}")

def load_json(path, default):
    if not os.path.exists(path):
        return default
    with open(path) as f:
        return json.load(f)

def save_json(path, data):
    with open(path, "w") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

def classificeer_reply(tekst):
    tekst_lower = tekst.lower()
    if any(s in tekst_lower for s in OPT_OUT_SIGNALEN):
        return "opt-out"
    if any(s in tekst_lower for s in WARM_SIGNALEN):
        return "warm"
    return "neutraal"

def main():
    replies = load_json(REPLIES_FILE, [])
    pipeline = load_json(PIPELINE_FILE, [])
    leads = load_json(LEADS_FILE, [])
    
    nieuwe_pipeline_ids = {p["lead_id"] for p in pipeline}
    
    for reply in replies:
        if reply.get("verwerkt"):
            continue
            
        categorie = classificeer_reply(reply.get("tekst", ""))
        reply["categorie"] = categorie
        reply["verwerkt"] = True
        
        if categorie == "warm":
            if reply["lead_id"] not in nieuwe_pipeline_ids:
                pipeline.append({
                    "lead_id": reply["lead_id"],
                    "bedrijf": reply.get("bedrijf", ""),
                    "naam": reply.get("naam", ""),
                    "email": reply.get("email", ""),
                    "reply_tekst": reply.get("tekst", ""),
                    "datum": datetime.datetime.now().isoformat(),
                    "status": "actie nodig",
                    "notitie": ""
                })
                log(f"🔥 WARME LEAD: {reply.get('bedrijf', '')} — {reply.get('email', '')}")
                log(f"   Reply: {reply.get('tekst', '')[:100]}...")
        
        elif categorie == "opt-out":
            # Markeer lead als opt-out
            for lead in leads:
                if lead.get("email") == reply.get("email"):
                    lead["status"] = "opt-out"
            log(f"❌ Opt-out: {reply.get('email', '')}")
    
    save_json(REPLIES_FILE, replies)
    save_json(PIPELINE_FILE, pipeline)
    save_json(LEADS_FILE, leads)
    
    warm_count = sum(1 for p in pipeline if p.get("status") == "actie nodig")
    log(f"Pipeline: {warm_count} leads wachten op actie")

if __name__ == "__main__":
    main()
```

---

## `scripts/followup.py`

```python
#!/usr/bin/env python3
"""
followup.py — Verstuurt één follow-up mail aan leads die 5 dagen niet gereageerd hebben.
"""
import json
import subprocess
import datetime
import os

LEADS_FILE = "leads.json"
LOG_FILE = "logs/followup.log"
FOLLOWUP_TEMPLATE = "templates/followup.md"
FOLLOWUP_DAGEN = 5

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

def is_followup_nodig(lead):
    if lead.get("status") != "verzonden":
        return False
    if lead.get("followup_verzonden"):
        return False
    
    verzonden = lead.get("verzonden")
    if not verzonden:
        return False
    
    verzonden_dt = datetime.datetime.fromisoformat(verzonden)
    dagen_geleden = (datetime.datetime.now() - verzonden_dt).days
    return dagen_geleden >= FOLLOWUP_DAGEN

def main():
    leads = load_leads()
    followup_kandidaten = [l for l in leads if is_followup_nodig(l)]
    
    log(f"Follow-up kandidaten: {len(followup_kandidaten)}")
    
    # Laad follow-up template
    if not os.path.exists(FOLLOWUP_TEMPLATE):
        log(f"FOUT: {FOLLOWUP_TEMPLATE} niet gevonden. Maak dit bestand aan.")
        return
    
    with open(FOLLOWUP_TEMPLATE) as f:
        template = f.read()
    
    for lead in followup_kandidaten:
        naam = lead.get("naam", "").split()[0]
        tekst = template.replace("{{NAAM}}", naam)
        
        subject = f"Re: Korte vraag"  # pas aan per template
        
        cmd = [
            "himalaya", "send",
            "--account", "outreach",
            "--to", lead["email"],
            "--subject", subject,
        ]
        
        result = subprocess.run(cmd, input=tekst, text=True, capture_output=True)
        
        if result.returncode == 0:
            lead["followup_verzonden"] = datetime.datetime.now().isoformat()
            log(f"✅ Follow-up verstuurd: {lead['bedrijf']} ({lead['email']})")
        else:
            log(f"❌ Follow-up mislukt: {lead['bedrijf']} — {result.stderr}")
    
    save_leads(leads)

if __name__ == "__main__":
    main()
```

---

## Follow-up template

Maak `templates/followup.md` aan:

```markdown
**Onderwerp:** Re: Korte vraag

---

Hallo {{NAAM}},

Ik stuurde je vorige week een berichtje — wilde even checken of het is aangekomen en of het relevant is voor jou.

Als het niet past: geen probleem, dan hoor ik dat ook graag.

Met vriendelijke groet,
Leo Kerkvliet
H&K Solutions
```

---

## Instructie aan Claude Code

1. Schrijf `scripts/classificeer.py` en `scripts/followup.py` naar de scripts-map
2. Maak `templates/followup.md` aan
3. Voeg `classificeer.py` toe aan de inbox-cronjob (draait na `inbox.py`)
4. Voeg `followup.py` toe als aparte cronjob (bv. dagelijks om 09:00)
5. Test: voeg een test-reply toe aan `replies.json` met een warm signaal en draai classificeer.py
6. Verificeer dat de lead in `pipeline.json` verschijnt
