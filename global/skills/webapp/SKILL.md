---
name: webapp
description: Ondersteuning voor de lichtbron-admin webapp — selfhosted ASP.NET Core 8 + Blazor Server + SQLite + EF Core applicatie voor de kerkpenningmeester van De Lichtbron. Gebruik deze skill wanneer Jan "/webapp" typt, wil werken aan de webapp, de volgende fase wil oppakken, of een vraag heeft over architectuur of implementatie van dit project.
---

# webapp

Selfhosted web applicatie die Google Sheets (Boekhouding 2026 + notjortt) vervangt voor de penningmeester van De Lichtbron.

## Locatie en bronnen

- **Code**: `~/dev/penningmeester/webapp/` (submap in de bestaande repo)
- **Spec**: `webapp/spec.md` — architectuur, stack, datamodel, migratiestrategie
- **Plan**: `webapp/todo.md` — 8 fasen met checkboxes

Lees altijd eerst `webapp/todo.md` om de eerste open stap te vinden. Lees `webapp/spec.md` voor relevante context bij die stap.

## Werkwijze per sessie

1. Lees `webapp/todo.md`, vind de eerste onafgevinkte stap
2. Lees `webapp/spec.md` voor relevante context
3. Presenteer Jan een voorstel: wat ga je doen, welke bestanden raak je aan
4. Maak een nieuwe branch aan (`git checkout -b fase-N-omschrijving`)
5. Implementeer stap voor stap; vink elke stap af in `todo.md` zodra die klaar is
6. Na afronding van een fase: commit, merge naar main, branch verwijderen

## Stack

| Laag | Keuze |
|---|---|
| Framework | ASP.NET Core 8 + Blazor Server |
| Database | SQLite via EF Core |
| PDF | QuestPDF |
| Email | Google Workspace SMTP (penningmeester@delichtbron.nl) |
| Hosting | Docker Compose op Proxmox |
| Externe toegang | Cloudflare Tunnel (al ingericht) |
| Authenticatie | Cloudflare Access (geen eigen loginlaag in de app) |

## Conventies

- Blazor Server (niet WebAssembly): geen aparte API-laag nodig
- EF Core migrations voor alle schemawijzigingen; nooit handmatig de database aanpassen
- Boekhouding: Bij = credit, Af = debet
- Sheets API credentials: `~/.config/calendar-cli/token-sheets.json`
- Grootboekschema lokale kopie: `grootboekschema.csv` (leidend voor lezen)
- Jan is .NET backend developer, geen Blazor-ervaring: licht Blazor-patronen toe waar nodig
