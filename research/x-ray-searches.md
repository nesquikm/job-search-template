# Google X-ray Boolean Search Strings

Google X-ray search uses `site:` and Boolean operators to find jobs and people *inside* websites via Google — bypassing weak internal search and access limits.

## How to use

1. Copy-paste a search string into Google exactly as written
2. Replace location filters as needed (e.g., add your country or city)
3. Adjust keywords to match specific roles
4. Sort by date (Tools → Past week/month) to find fresh listings

## Job Search Tracks

<!-- SETUP: These tracks are examples. Customize the search terms to match your target roles and tech stack. Add or remove tracks as needed. -->

### Track A: AI / MCP / LLM Engineer

**A1 — Broad AI/LLM (Remote/EU)**
```
("AI Engineer" OR "LLM Engineer" OR "ML Engineer" OR "AI Developer" OR "Senior Software Engineer")
("LLM" OR "AI agent" OR "MCP" OR "Model Context Protocol" OR "prompt engineering" OR "AI tooling")
(remote OR "fully remote" OR "work from anywhere" OR Europe OR EMEA OR "United Kingdom" OR UK OR Germany OR Netherlands OR France)
-junior -intern -internship -student
```

**A2 — ATS platforms (Greenhouse/Lever/Ashby)**
```
("AI Engineer" OR "LLM" OR "AI agent" OR "MCP" OR "prompt engineering")
("Senior" OR "Staff" OR "Lead") (Engineer OR Developer)
(remote OR Europe OR EMEA OR UK OR Germany OR Netherlands)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:workable.com)
-junior -intern
```

**A3 — AI + developer tooling / infrastructure**
```
("AI Engineer" OR "Developer Tools" OR "AI Infrastructure" OR "Platform Engineer")
("LLM" OR "AI agent" OR "multi-model" OR "orchestration" OR "developer experience")
("Senior" OR "Staff" OR "Lead") (Engineer OR Developer)
(remote OR Europe OR EMEA OR UK)
-junior -intern
```

### Track B: Flutter / Mobile Lead

**B1 — Broad Flutter (Remote/EU)**
```
("Flutter Engineer" OR "Flutter Developer" OR "Mobile Engineer" OR "Mobile Developer" OR "Lead Mobile")
(Flutter OR Dart)
(remote OR "fully remote" OR "work from anywhere" OR Europe OR EMEA OR UK OR Germany OR Netherlands OR France)
-junior -intern -internship -student
```

**B2 — ATS platforms**
```
(Flutter OR Dart OR "Mobile Engineer")
("Senior" OR "Lead" OR "Staff") (Engineer OR Developer)
(remote OR Europe OR EMEA OR UK OR Germany OR Netherlands)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:workable.com)
-junior -intern
```

**B3 — Mobile + AI intersection**
```
("Mobile Engineer" OR "Flutter" OR "Mobile Developer")
("AI" OR "LLM" OR "machine learning" OR "prompt engineering" OR "chatbot")
("Senior" OR "Lead" OR "Staff")
(remote OR Europe OR EMEA)
-junior -intern
```

### Track C: Blockchain / Solana

**C1 — Solana / Rust (Remote/EU)**
```
("Blockchain Engineer" OR "Web3 Engineer" OR "Smart Contract Engineer" OR "Protocol Engineer" OR "Solana Developer")
(Solana OR Rust OR "smart contract" OR "smart contracts")
(remote OR "EU remote" OR Europe OR EMEA OR UK OR Germany OR Netherlands)
-junior -intern -bootcamp
```

**C2 — ATS platforms**
```
("Blockchain Engineer" OR "Web3 Engineer" OR "Smart Contract Engineer")
(Solana OR Rust OR "smart contract")
(remote OR Europe OR EMEA OR UK)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:workable.com)
-junior -intern
```

### Track D: CTO / Founding Engineer / Engineering Lead

**D1 — CTO / Head of Engineering (Remote)**
```
(CTO OR "Chief Technology Officer" OR "VP Engineering" OR "Head of Engineering" OR "Founding Engineer")
(remote OR "fully remote" OR Europe OR EMEA)
(startup OR "Series A" OR "Series B" OR "Seed" OR "early stage")
("mobile" OR "AI" OR "Flutter" OR "full-stack")
-junior -intern
```

**D2 — ATS platforms**
```
(CTO OR "Founding Engineer" OR "Head of Engineering" OR "Engineering Lead")
(remote OR Europe OR EMEA)
(site:greenhouse.io OR site:lever.co OR site:jobs.ashbyhq.com OR site:wellfound.com)
-junior -intern
```

## Finding Hiring Managers (LinkedIn X-ray)

After finding a relevant role, X-ray LinkedIn to identify the decision-maker. Replace `"Company Name"` with the actual company.

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
- **Save searches** — bookmark each string in a browser folder for quick daily use
- **Refine over time** — add company names you discover to an exclusion list if they keep appearing but aren't relevant
- **Combine with job boards** — these searches supplement, not replace, direct board browsing
