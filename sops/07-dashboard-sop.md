# SOP — Dashboard (Les 7)

> **Dit is Les 7.** Vereist: `leads.json`, `replies.json`, `pipeline.json`, `logs/` bestaan. Je bouwt een HTML-dashboard dat lokaal draait en live data toont.

---

## Wat je bouwt

- `dashboard.html` — self-contained HTML dashboard
- Python-server op poort 8767
- `scripts/dashboard-server.py` — start de server

---

## Dashboard HTML

Schrijf `dashboard.html` met deze secties:

```html
<!DOCTYPE html>
<html lang="nl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Outreach Mission Control</title>
  <style>
    /* Dark mode, clean, professioneel */
    body {
      background: #0a0a0a;
      color: #e5e5e5;
      font-family: 'Inter', -apple-system, sans-serif;
      margin: 0;
      padding: 24px;
    }
    
    .header {
      border-bottom: 1px solid #222;
      padding-bottom: 16px;
      margin-bottom: 24px;
    }
    
    .header h1 {
      font-size: 20px;
      font-weight: 600;
      color: #fff;
      margin: 0;
    }
    
    .header .subtitle {
      font-size: 13px;
      color: #666;
      margin-top: 4px;
    }
    
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 16px;
      margin-bottom: 32px;
    }
    
    .card {
      background: #111;
      border: 1px solid #222;
      border-radius: 8px;
      padding: 20px;
    }
    
    .card .label {
      font-size: 12px;
      color: #666;
      text-transform: uppercase;
      letter-spacing: 0.05em;
      margin-bottom: 8px;
    }
    
    .card .value {
      font-size: 32px;
      font-weight: 700;
      color: #fff;
    }
    
    .card .sub {
      font-size: 12px;
      color: #555;
      margin-top: 4px;
    }
    
    .pipeline-table {
      width: 100%;
      border-collapse: collapse;
    }
    
    .pipeline-table th {
      text-align: left;
      font-size: 11px;
      color: #555;
      text-transform: uppercase;
      letter-spacing: 0.05em;
      padding: 8px 12px;
      border-bottom: 1px solid #1a1a1a;
    }
    
    .pipeline-table td {
      padding: 12px;
      border-bottom: 1px solid #111;
      font-size: 13px;
    }
    
    .badge {
      display: inline-block;
      padding: 2px 8px;
      border-radius: 4px;
      font-size: 11px;
      font-weight: 600;
    }
    
    .badge.warm { background: #1a3a1a; color: #4ade80; }
    .badge.actie { background: #3a2a00; color: #fbbf24; }
    
    .last-updated {
      font-size: 11px;
      color: #444;
      margin-top: 24px;
    }
  </style>
</head>
<body>
  <div class="header">
    <h1>🎯 Outreach Mission Control</h1>
    <div class="subtitle" id="subtitle">Laden...</div>
  </div>
  
  <div class="grid" id="metrics">
    <!-- Gevuld door JS -->
  </div>
  
  <div class="card" style="margin-bottom: 24px;">
    <div class="label">Pipeline — Warme Leads</div>
    <table class="pipeline-table" id="pipeline-table">
      <thead>
        <tr>
          <th>Bedrijf</th>
          <th>Naam</th>
          <th>Datum</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody id="pipeline-body">
        <!-- Gevuld door JS -->
      </tbody>
    </table>
  </div>
  
  <div class="last-updated" id="last-updated"></div>
  
  <script>
    async function loadJSON(path) {
      try {
        const r = await fetch(path + '?t=' + Date.now());
        if (!r.ok) return null;
        return await r.json();
      } catch { return null; }
    }
    
    function fmt(n) { return n ?? '—'; }
    
    async function update() {
      const leads = await loadJSON('leads.json') ?? [];
      const pipeline = await loadJSON('pipeline.json') ?? [];
      const replies = await loadJSON('replies.json') ?? [];
      
      const totaal = leads.length;
      const nieuw = leads.filter(l => l.status === 'nieuw').length;
      const verzonden = leads.filter(l => l.status === 'verzonden').length;
      const warm = pipeline.filter(p => p.status === 'actie nodig').length;
      const opt_out = leads.filter(l => l.status === 'opt-out').length;
      const reactiegraad = verzonden > 0 
        ? ((replies.filter(r => r.categorie === 'warm').length / verzonden) * 100).toFixed(1) 
        : '0.0';
      
      document.getElementById('subtitle').textContent = 
        `${new Date().toLocaleDateString('nl-NL', {weekday:'long', day:'numeric', month:'long'})}`;
      
      const metrics = [
        { label: 'Leads in pool', value: totaal, sub: `${nieuw} nieuw` },
        { label: 'Verzonden totaal', value: verzonden, sub: 'alle tijd' },
        { label: 'Reactiegraad', value: reactiegraad + '%', sub: 'warm replies' },
        { label: 'Pipeline', value: warm, sub: 'actie nodig' },
        { label: 'Opt-outs', value: opt_out, sub: 'verwijderd' },
      ];
      
      document.getElementById('metrics').innerHTML = metrics.map(m => `
        <div class="card">
          <div class="label">${m.label}</div>
          <div class="value">${fmt(m.value)}</div>
          <div class="sub">${m.sub}</div>
        </div>
      `).join('');
      
      const pipelineBody = document.getElementById('pipeline-body');
      if (pipeline.length === 0) {
        pipelineBody.innerHTML = '<tr><td colspan="4" style="color:#444;padding:20px">Nog geen warme leads</td></tr>';
      } else {
        pipelineBody.innerHTML = pipeline
          .sort((a,b) => new Date(b.datum) - new Date(a.datum))
          .map(p => `
            <tr>
              <td>${p.bedrijf ?? '—'}</td>
              <td>${p.naam ?? '—'}</td>
              <td>${p.datum ? new Date(p.datum).toLocaleDateString('nl-NL') : '—'}</td>
              <td><span class="badge ${p.status === 'actie nodig' ? 'actie' : 'warm'}">${p.status ?? '—'}</span></td>
            </tr>
          `).join('');
      }
      
      document.getElementById('last-updated').textContent = 
        'Bijgewerkt: ' + new Date().toLocaleTimeString('nl-NL');
    }
    
    update();
    setInterval(update, 30000); // refresh elke 30 seconden
  </script>
</body>
</html>
```

---

## `scripts/dashboard-server.py`

```python
#!/usr/bin/env python3
"""Start de dashboard-server op poort 8767."""
import http.server
import socketserver
import os
import sys

PORT = 8767

os.chdir(os.path.dirname(os.path.abspath(__file__ + "/..")))

Handler = http.server.SimpleHTTPRequestHandler
Handler.log_message = lambda *args: None  # stil

print(f"Dashboard draait op http://localhost:{PORT}/dashboard.html")
print("Stop met Ctrl+C")

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    httpd.serve_forever()
```

---

## Instructie aan Claude Code

1. Schrijf `dashboard.html` naar de root van de werkmap
2. Schrijf `scripts/dashboard-server.py`
3. Start de server: `python3 scripts/dashboard-server.py &`
4. Open `http://localhost:8767/dashboard.html` in de browser
5. Verificeer dat de cijfers overeenkomen met de daadwerkelijke data in de JSON-bestanden
6. Als de bestanden leeg zijn: maak test-data aan zodat het dashboard iets toont
