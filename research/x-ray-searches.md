# X-ray Search Strings

X-ray search finds jobs and people *inside* websites — bypassing weak internal search and access limits. Two methods available:

| | Google (manual) | DDG via Duck (automated) |
|---|---|---|
| **Precision** | High — full Boolean, `site:` operator | Medium — natural language only |
| **Effort** | Copy-paste into browser | Run via `ask_duck`, hands-free |
| **CAPTCHA risk** | None (you're human) | None (DDG API) |
| **Bulk scanning** | Tedious (one query at a time) | Easy (run all tracks in one prompt) |
| **Best for** | Targeted ATS searches, LinkedIn hiring managers | Broad discovery, daily sweeps |

## How to use

### Google (manual)

1. Copy-paste a search string into Google exactly as written
2. Replace location filters as needed (e.g., add your country or city)
3. Adjust keywords to match specific roles
4. Sort by date (Tools → Past week/month) to find fresh listings

### DDG via Duck (automated)

DDG doesn't support `site:` or complex Boolean. Use natural-language queries instead.

**Run a single search:**
```
Use `ask_duck` with prompt:
"Use the ddgsearch `search` tool to search for: {DDG query}. Return the top 10 results with title, URL, and a one-line description."
```

**Run all tracks at once:**
```
Use `ask_duck` with prompt:
"Use the ddgsearch `search` tool to run these searches one by one:
1. {Track A DDG query}
2. {Track B DDG query}
3. {Track C DDG query}
4. {Track D DDG query}
Deduplicate results across all searches. Return a combined list with title, URL, company, and which track matched."
```

**Follow up on results:** use `ask_duck` with `fetch_content` or `fetch` to scrape individual listing URLs.

## Job Search Tracks

<!-- SETUP: These tracks are examples. Customize the search terms to match your target roles and tech stack. Add or remove tracks as needed. -->

### Track A: AI / MCP / LLM Engineer

**A1 — Broad AI/LLM (Remote/EU)**

Google:
```
("AI Engineer" OR "LLM Engineer" OR "ML Engineer" OR "AI Developer" OR "Senior Software Engineer")
("LLM" OR "AI agent" OR "MCP" OR "Model Context Protocol" OR "prompt engineering" OR "AI tooling")
(remote OR "fully remote" OR "work from anywhere" OR Europe OR EMEA OR "United Kingdom" OR UK OR Germany OR Netherlands OR France)
-junior -intern -internship -student
```

DDG via Duck:
```
senior AI LLM engineer remote Europe 2026
```

**A2 — ATS platforms (Greenhouse/Lever/Ashby)**

Google:
```
("AI Engineer" OR "LLM" OR "AI agent" OR "MCP" OR "prompt engineering")
("Senior" OR "Staff" OR "Lead") (Engineer OR Developer)
(remote OR Europe OR EMEA OR UK OR Germany OR Netherlands)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:workable.com)
-junior -intern
```

DDG via Duck:
```
senior AI engineer remote greenhouse.io OR lever.co 2026
```

**A3 — AI + developer tooling / infrastructure**

Google:
```
("AI Engineer" OR "Developer Tools" OR "AI Infrastructure" OR "Platform Engineer")
("LLM" OR "AI agent" OR "multi-model" OR "orchestration" OR "developer experience")
("Senior" OR "Staff" OR "Lead") (Engineer OR Developer)
(remote OR Europe OR EMEA OR UK)
-junior -intern
```

DDG via Duck:
```
senior AI developer tools infrastructure engineer remote 2026
```

### Track B: Flutter / Mobile Lead

**B1 — Broad Flutter (Remote/EU)**

Google:
```
("Flutter Engineer" OR "Flutter Developer" OR "Mobile Engineer" OR "Mobile Developer" OR "Lead Mobile")
(Flutter OR Dart)
(remote OR "fully remote" OR "work from anywhere" OR Europe OR EMEA OR UK OR Germany OR Netherlands OR France)
-junior -intern -internship -student
```

DDG via Duck:
```
senior Flutter mobile engineer remote Europe 2026
```

**B2 — ATS platforms**

Google:
```
(Flutter OR Dart OR "Mobile Engineer")
("Senior" OR "Lead" OR "Staff") (Engineer OR Developer)
(remote OR Europe OR EMEA OR UK OR Germany OR Netherlands)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:workable.com)
-junior -intern
```

DDG via Duck:
```
Flutter developer remote greenhouse.io OR lever.co 2026
```

**B3 — Mobile + AI intersection**

Google:
```
("Mobile Engineer" OR "Flutter" OR "Mobile Developer")
("AI" OR "LLM" OR "machine learning" OR "prompt engineering" OR "chatbot")
("Senior" OR "Lead" OR "Staff")
(remote OR Europe OR EMEA)
-junior -intern
```

DDG via Duck:
```
senior mobile engineer AI LLM chatbot remote 2026
```

### Track C: Blockchain / Solana

**C1 — Solana / Rust (Remote/EU)**

Google:
```
("Blockchain Engineer" OR "Web3 Engineer" OR "Smart Contract Engineer" OR "Protocol Engineer" OR "Solana Developer")
(Solana OR Rust OR "smart contract" OR "smart contracts")
(remote OR "EU remote" OR Europe OR EMEA OR UK OR Germany OR Netherlands)
-junior -intern -bootcamp
```

DDG via Duck:
```
Solana blockchain engineer remote Europe 2026
```

**C2 — ATS platforms**

Google:
```
("Blockchain Engineer" OR "Web3 Engineer" OR "Smart Contract Engineer")
(Solana OR Rust OR "smart contract")
(remote OR Europe OR EMEA OR UK)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:workable.com)
-junior -intern
```

DDG via Duck:
```
blockchain smart contract engineer remote greenhouse.io OR lever.co 2026
```

### Track D: CTO / Founding Engineer / Engineering Lead

**D1 — CTO / Head of Engineering (Remote)**

Google:
```
(CTO OR "Chief Technology Officer" OR "VP Engineering" OR "Head of Engineering" OR "Founding Engineer")
(remote OR "fully remote" OR Europe OR EMEA)
(startup OR "Series A" OR "Series B" OR "Seed" OR "early stage")
("mobile" OR "AI" OR "Flutter" OR "full-stack")
-junior -intern
```

DDG via Duck:
```
CTO founding engineer startup remote AI mobile 2026
```

**D2 — ATS platforms**

Google:
```
(CTO OR "Founding Engineer" OR "Head of Engineering" OR "Engineering Lead")
(remote OR Europe OR EMEA)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:wellfound.com)
-junior -intern
```

DDG via Duck:
```
CTO founding engineer remote greenhouse.io OR wellfound.com 2026
```

## Finding Hiring Managers (LinkedIn X-ray)

After finding a relevant role, X-ray LinkedIn to identify the decision-maker. Replace `"Company Name"` with the actual company.

> **Note:** DDG doesn't index LinkedIn profiles well. Use Google for hiring manager searches.

**General engineering leadership:**
```
site:linkedin.com/in ("Head of Engineering" OR "VP Engineering" OR "Director of Engineering" OR CTO OR "Chief Technology Officer" OR "Engineering Manager" OR "Senior Engineering Manager") "Company Name"
```

**Mobile / Flutter leadership:**
```
site:linkedin.com/in ("Head of Mobile" OR "Mobile Lead" OR "Mobile Engineering Manager" OR "Flutter Lead") "Company Name"
```

**AI / ML leadership:**
```
site:linkedin.com/in ("Head of AI" OR "AI Lead" OR "ML Engineering Manager" OR "VP of AI" OR "Director of AI") "Company Name"
```

**Early-stage startups (founder is usually the hiring manager):**
```
site:linkedin.com/in (CTO OR "Co-founder" OR "Founder & CTO" OR "Founder") "Company Name"
```

## Tips

- **Sort by date** — use Google's "Past week" or "Past month" filter to find fresh listings
- **Rotate tracks** — don't search all tracks daily; rotate A/B/C/D across the week
- **Save searches** — bookmark Google strings in a browser folder for quick daily use
- **Duck sweeps** — use DDG via duck for quick daily broad sweeps, then switch to Google for precision
- **Refine over time** — add company names you discover to an exclusion list if they keep appearing but aren't relevant
- **Combine with job boards** — these searches supplement, not replace, direct board browsing
