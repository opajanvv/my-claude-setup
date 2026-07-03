---
name: review-text
description: >
  Review text with direct, style-aware feedback based on Jan's personal writing voice.
  Use when Jan asks to review, proofread, or get feedback on text he has written or is writing.
  Supports both Dutch and English. Triggers: "review this text", "review my post",
  "check this article", "proofread", "/review-text", or any request to give feedback on
  written content (blog posts, articles, about pages, documentation, emails, LinkedIn posts).
---

# Review text

Review provided text with direct, useful feedback. No sugarcoating. Match feedback to Jan's established writing style.

## Workflow

1. Read the text (file path, pasted content, or clipboard).
2. Detect the language (Dutch or English).
3. Load the matching style reference:
   - English: read `references/style-examples-en.md`
   - Dutch: read `references/style-examples-nl.md`
4. Review the text (see criteria below).
5. Output feedback as bullet points.

## Review criteria

- **Clarity**: Is the meaning obvious? Any ambiguous sentences?
- **Structure**: Does it flow logically? Is the order sensible?
- **Voice consistency**: Does it sound like Jan? Flag anything that drifts toward corporate speak, chatbot tone, or overly formal language. Jan writes conversationally, with short sentences, dry humor, and direct address.
- **Argument strength**: Do claims hold up? Missing evidence?
- **Grammar and style**: Errors, awkward phrasing, unnecessary words?
- **Tone fit**: Consider the format. A casual blog post can have humor or irony; technical docs usually shouldn't. Don't flag informal tone as a problem when it fits the context.

## Jan's writing style (summary)

Shared traits across both languages:
- Conversational first-person, talks directly to the reader
- Short sentences, short paragraphs, punchy delivery
- Dry, self-deprecating, observational humor
- Rhetorical questions as transitions
- No filler, no throat-clearing, no corporate fog
- Contractions and informal phrasing are normal
- An analytical/mathematical mind showing through even in casual writing
- Bold for emphasis on key concepts (sparingly)

English-specific: uses "you know" as a conversational bridge, self-deprecating asides in parentheses or after colons.

Dutch-specific: wordplay and linguistic humor, ellipsis for trailing thoughts, very short column-like pieces, sparse emoji.

LinkedIn posts (both languages): first line is a standalone hook; short paragraphs (1-3 sentences), no headers; reactive/topical; ends with open question or observation, not a forced CTA; no hashtags. Dutch LinkedIn is argumentative -- no trailing ellipsis (that's for short Dutch column pieces).

LinkedIn comments: ultra-compressed; open with "Exactly." or "Mee eens, [name]."; state the point immediately.

## Output format

Each bullet should:
- Quote the specific problematic text
- Explain what's wrong
- Suggest a fix (when not obvious)

Be direct. If something's weak, say so. Skip "this is great, but..." framing.

### Example

- "The system will be implemented in a timely manner" -- corporate fog. What does this actually mean? Try: "We'll ship by March."
- "It's important to note that..." -- throat-clearing. Delete and start with what's actually important.
- The third paragraph argues X, but paragraph five contradicts it. Pick one or acknowledge the tension.
- "Wij willen u graag informeren dat..." -- ambtenarentaal. Jan schrijft: "Even dit:" of begint gewoon met de inhoud.

## Style references

Detailed writing samples for comparison are in:
- `references/style-examples-en.md` — 6 English texts (about page, blog posts, LinkedIn post, LinkedIn comment, blog comment, email)
- `references/style-examples-nl.md` — 21 Dutch texts (blog posts, LinkedIn posts/comments, newspaper comment, satire, and 15 emails spanning formal letters, tech discussions, short replies, church admin, complaints, and personal notes)

Load the relevant file when reviewing to compare tone and voice against real examples.

## Corpus reference

A larger corpus of cleaned sent mail (~95 NL, ~2 EN messages, 90-day window) is available at `~/.claude/corpus/gmail/` (not synced via mystrap). Use this for broader pattern analysis when the curated examples are insufficient. Update it with `gmail-corpus-export --incremental`.

## Corpus-derived observations

These patterns emerged from analysis of Jan's sent mail corpus and supplement the style summary above:

- **Email openings**: Dutch emails open with "Ha [name]" (informal), "Beste [name]" (semi-formal), or "Geachte [naam]" (formal). Never "Hoi" alone without name. English emails open with "Hi [name]".
- **Sign-offs**: Dutch emails use "Hartelijke groet" (warm) or "Met vriendelijke groet" (formal). Some close with "Ik hoor/lees het wel" which doubles as both sign-off and gentle nudge. Esperanto signoffs ("Saluton!", "Kore") appear in correspondence with Esperanto-speaking friends.
- **Reply structure**: Short replies are dense — often 2-4 sentences that combine acknowledgment, opinion, and a dry aside. Long replies open with context, then structured analysis (numbered points, parallel comparisons), and close with a proposed next step.
- **Formal register**: Jan's voice survives formal constraints. Letters to companies ("Geachte heer/mevrouw") still use conversational rhythm, rhetorical questions, and the occasional "Maar...." The politeness is genuine, not corporate.
- **Complaint style**: Factual timeline, then a single dry punchline. Never raises voice. "Of zie ik dat verkeerd?" is the signature polite-but-firm button.
- **Code-switching**: English tech terms appear naturally in Dutch sentences ("Ik zet IPv6 overal uit. Geen gezeik, voor mij is IPv4 goed genoeg."). Not forced, never translated — the English term is the natural one.
- **Self-deprecation in email**: More raw than in published writing. "Tjonge, wat ben ik erin getuind zeg." "Primitief." "Ik kan het natuurlijk zo laten, maar ik kan het niet laten..."
- **Structured thinking**: Numbered lists, parallel constructions, and step-by-step diagnosis appear frequently — the programmer's mind at work, more visible in email than in blog posts.
