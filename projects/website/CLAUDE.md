# opa.janvv.nl

Personal website for Jan. Technical blog (English) and personal writing (Dutch) on Grav CMS.

- **URL:** https://opa.janvv.nl
- **Tagline:** "Retired, but not disconnected"

## Development principles

- **KISS:** Prefer simple solutions. This is a personal blog, not enterprise software.
- **Use Grav's built-in features:** Don't reinvent what Grav already provides.
- **Test each change:** Verify locally before publishing.
- **Iterate small:** One feature at a time.
- **Commit proactively:** When a feature is complete or a decision is made, commit and push immediately.
- **Follow Grav conventions:** Use standard Grav patterns. Check docs before implementing.

## Quick commands

```bash
# Local development
php -S localhost:8000 system/router.php

# Publish to server
./publish.sh
```

## Writing posts

### New tech post (English)

Create folder: `user/pages/02.tech/YYYY-MM-DD-slug/item.md`

```yaml
---
title: Your Title Here
date: 2025-12-16
taxonomy:
    category: [tech]
    tag: [linux, git]
    language: [en]
description: Brief description for SEO and previews.
---

Post content in Markdown.
```

### New krabbel (Dutch)

Create folder: `user/pages/03.krabbels/YYYY-MM-DD-slug/item.md`

```yaml
---
title: Je Titel Hier
date: 2025-12-16
taxonomy:
    category: [krabbels]
    tag: [taal, verhaal]
    language: [nl]
description: Korte beschrijving voor SEO en previews.
---

Inhoud in Markdown.
```

### Images in posts

Place images in the post folder alongside `item.md`:

```
user/pages/02.tech/2025-12-16-my-post/
├── item.md
├── screenshot.png
└── diagram.svg
```

Reference in Markdown: `![Alt text](screenshot.png)`

## Site structure

```
/                    → Landing page
/tech/               → English technical posts
/krabbels/           → Dutch personal posts
/about/              → English bio
/over-mij/           → Dutch bio
/pri-mi/             → Esperanto bio
/contact/            → English contact page
/kontakt/            → Dutch contact page
/kontakto/           → Esperanto contact page
```

## Folder structure

```
user/pages/
├── 01.home/default.md
├── 02.tech/
│   ├── blog.md              # List page config
│   └── [posts]/item.md
├── 03.krabbels/
│   ├── blog.md              # List page config
│   └── [posts]/item.md
├── 04.about/default.md
├── 05.over-mij/default.md
├── 06.pri-mi/default.md
├── 07.contact/default.md
├── 08.kontakt/default.md
└── 09.kontakto/default.md
```

## Theme

Custom theme: `user/themes/opa/`

- Catppuccin Mocha dark color scheme
- System monospace fonts (no external loading)
- Syntax highlighting via highlight.js (CDN, catppuccin-mocha theme)
- Localized date formatting (English/Dutch/Esperanto via partials/date.html.twig)
- Lowercase UI, mixed case content
- When adding full-width block elements after `.post-content`, include `clear: both` to clear floated images

### Key files

```
user/themes/opa/
├── css/main.css             # All styles
├── templates/
│   ├── partials/base.html.twig   # Layout wrapper
│   ├── default.html.twig         # Static pages
│   ├── blog.html.twig            # List pages
│   ├── item.html.twig            # Single posts
│   └── error.html.twig           # 404 page
```

### CSS variables

```css
:root {
    --bg-primary: #1e1e2e;
    --bg-secondary: #313244;
    --text-primary: #cdd6f4;
    --text-muted: #a6adc8;
    --accent: #89b4fa;
    --accent-secondary: #a6e3a1;
    --border: #45475a;
    --content-width: 800px;
}
```

## Translation links

Pages can link to translations. Example for `/about/default.md`:

```yaml
translations:
    - { path: /over-mij, flag: '🇳🇱', label: Nederlands, lang: nl }
```

Language preference is saved to localStorage when a translation link is clicked (no auto-redirect).

## Comments

Custom Grav plugin (`user/plugins/comments/`) for tech and krabbels posts.

- **Form:** name, email (optional), comment text, Cloudflare Turnstile captcha
- **Storage:** YAML files in `/lxcdata/grav-comments` (bind-mounted into CT 123, Docker-mounted into containers)
- **Notifications:** email via Brevo HTTP API to jan@janvv.nl
- **Features:** one-level threaded replies, localised labels (en/nl), no auth required
- **Config:** `user/config/plugins/comments.yaml` on server (contains Turnstile + Brevo keys, excluded from rsync)

## Feeds and SEO

- RSS: `/tech.rss`, `/krabbels.rss`
- Sitemap: `/sitemap.xml`
- Analytics: Cloudflare Web Analytics (zone-level)
- Search Console: verified, sitemap submitted

## Writing tips

- Use descriptive titles ("Omarchy dual monitor setup" not "Monitor fix")
- Include a `description` in frontmatter for SEO
- Tag posts appropriately for discoverability
- Test locally before publishing

## General writing rules (all languages)

**Avoid em-dashes (—).** They're a common AI tell. Prefer:
- Commas for slight pauses
- Colons to introduce something
- Full stops to separate thoughts
- Ellipsis (...) for trailing off or dramatic pauses (especially in Dutch)

Em-dashes are not forbidden, but should be rare and intentional.

## Writing style: English (tech posts)

Jan is a native Dutch speaker. The English should be correct and readable, but not sound like it was written by a native Brit. Use **British English** spelling (colour, favour, recognise).

**Voice and tone:**
- Direct and practical. Get to the point, no unnecessary padding
- Personal "I" voice throughout
- Conversational but informative
- Dry humour when appropriate, never forced

**Structure:**
- Short paragraphs, often single sentences
- Clear technical explanations without being academic
- Code blocks and lists for technical content
- Questions used rhetorically: "Why?", "So, why do I still use it?"

**Language patterns:**
- Contractions are fine: "I'm", "don't", "it's", "can't", "you'll"
- Sentence starters like "Well,", "So,", "And", "Anyway" are natural
- Direct reader address: "If you want to know...", "you know what"
- Self-deprecating when fitting: "leaving it there was dumb"
- Occasional emoji (😛 😀 🙂) but sparingly

**Avoid:**
- Overly formal or academic language
- Excessive hedging or politeness ("perhaps", "might I suggest")
- Native British idioms that feel unnatural
- Marketing speak or enthusiasm that sounds fake

**Examples from existing posts:**
- "Omarchy is said to be *opinionated*. Is it? Yes: highly opinionated, to put it mildly."
- "Omarchy is the first Linux distribution I've used that ships without `vi`. In my opinion, that's a cardinal sin."
- "I sat there thinking: 'Why have I been writing blog posts about manually installing packages when I could just... script it all?'"

## Writing style: Dutch (krabbels)

Jan is native Dutch. The Dutch writing should feel natural and colloquial, clearly from someone who thinks in Dutch.

**Voice and tone:**
- Playful and lighthearted
- Often focused on language observations and wordplay
- Casual "ik" voice
- Humour through everyday observations

**Structure:**
- Short, punchy paragraphs
- Often a setup followed by an observation or punchline
- Ellipsis (...) for pauses and effect

**Language patterns:**
- Informal constructions: "Althans...", "Nou", "Wow"
- Direct statements without hedging
- Occasional emoji (😀) when it fits the playful tone
- Natural sentence flow. Write as you'd speak

**Avoid:**
- Formal or stiff language
- Anglicisms where good Dutch alternatives exist
- Overly long sentences
- Academic or business Dutch

**Examples from existing posts:**
- "Ik kocht pas een nieuw pak printerpapier. Althans... ik dacht dat het printerpapier was."
- "Nou, reken dan maar dat het echt heel streng bewaakt wordt."
- "Zo bezien is het bordje ook gewoon een regel uit een Frans-Nederlandse woordenlijst. 😀"

## Writing style: Esperanto (occasional)

Jan has studied Esperanto and uses it occasionally. The Esperanto should be correct and clear, accessible to an international readership.

**Voice and tone:**
- Natural Esperanto flow, not stiff or overly formal
- Clear and accessible. Avoid rare or overly literary vocabulary
- Friendly and warm, similar in feel to the English version
- Write as an experienced Esperantist would speak, not as a textbook

**Grammar and vocabulary:**
- Correct use of the accusative (-n) and other grammatical features
- Proper use of affixes: -iĝ- (become), -ig- (cause), -ej- (place), etc.
- Compound words where natural: "softvar-arkitekto", "longdistancaj"
- Correlatives used correctly (tio, kio, ĉio, etc.)
- Prefer common roots over obscure alternatives
- **Use Esperanto's word-building system.** Prefer constructions with prefixes and suffixes over borrowings or literal translations. Examples: "enamiĝi" (fall in love), "surkapiĝi" (put on one's head), "enmaniĝi" (take in hand). This is idiomatic Esperanto.

**Structure:**
- Straightforward sentence structure
- Avoid overly complex subordinate clauses
- Paragraphs similar in length to English

**Avoid:**
- Showing off with rare vocabulary or neologisms
- Overly literal translations from Dutch or English
- Archaic or "Fundamento-only" purism. Modern standard Esperanto is fine

**Example from the site:**
- "De trukartoj ĝis AI: jen mia kariero en unu frazo."
- "Dankon pro via vizito. Ne hezitu skribi!"

## Multilingual content

When content exists in multiple languages:
- **Same meaning, different flow.** Preserve the content and intent, not the exact wording.
- **No word-for-word translation.** Each version should read naturally in its language.
- **Respect language idioms.** Use expressions that fit each language.
- **Match the tone.** If the English is dry and direct, the Dutch should feel equally natural (but Dutch-natural, not English-natural).

Example: A joke or wordplay in Dutch may not translate. Find an equivalent that works in English, or adjust the content to fit.

## Reference

- **Grav docs:** https://learn.getgrav.org/
- **Live site:** https://opa.janvv.nl
