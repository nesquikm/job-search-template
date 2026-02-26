---
description: Research job openings from a URL, job board, or company. Fetches listings, filters for fit, checks location/salary, and summarizes findings.
user_invocable: true
---

# Scout Job Openings

Research and evaluate job openings from a URL, job board, or company careers page.

## Usage

Pass a URL (job board, company careers page, or individual listing) or a company name:
- `/scout https://weworkremotely.com`
- `/scout https://acme.com/careers`
- `/scout Sourcegraph`

If no argument is given, ask the user what to search.

## Step 0: Determine Input Type

Classify `$ARGUMENTS`:

- **Job board URL** (weworkremotely.com, remotive.com, himalayas.app, etc.) → go to Step 1a
- **Company careers page** (e.g., `company.com/careers`) → go to Step 1b
- **Individual job listing URL** → go to Step 1c
- **Company name** (no URL) → go to Step 1b (find their careers page first)

## Step 1a: Job Board — Fetch Listings

### Multi-strategy fetch (try in order until one works)

1. **WebFetch** the URL directly
2. If blocked (403, empty, JS-rendered): use `mcp__rubber-duck__ask_duck` with prompt: "Fetch this URL and list all job openings with title, company, salary, and location: {url}"
3. If still empty: **WebSearch** for the board + relevant keywords (from the user's profile — see Step 2)
4. If the board has known APIs, try those:
   - Greenhouse boards: `https://api.greenhouse.io/v1/boards/{company}/jobs?content=true`
   - Lever: `https://api.lever.co/v0/postings/{company}`

### Pagination

If the board supports pagination and results look promising, fetch 2-3 pages.

## Step 1b: Company — Find and Fetch Careers Page

1. **WebSearch** for "{Company} careers jobs remote engineering"
2. Try common career page patterns:
   - `{domain}/careers`, `{domain}/jobs`, `careers.{domain}`
   - ATS boards: search for `greenhouse.io/{company}`, `jobs.lever.co/{company}`, `jobs.ashbyhq.com/{company}`
3. If the company uses **Greenhouse**, fetch the API directly:
   - `https://api.greenhouse.io/v1/boards/{company-slug}/jobs?content=true`
   - Try slug variations: `{company}`, `{companysecurity}`, `{company}io`, etc.
4. **WebFetch** the careers page. If blocked, use `mcp__rubber-duck__ask_duck`.
5. Extract all engineering/tech roles.

## Step 1c: Individual Listing — Fetch Details

1. **WebFetch** the listing URL
2. If blocked: `mcp__rubber-duck__ask_duck` with prompt: "Fetch this job listing and extract: company name, job title, location, salary range, tech stack, requirements, responsibilities, qualifications. URL: {url}"
3. If it's a Greenhouse/Lever URL, try the API equivalent
4. Proceed directly to Step 3 (single-listing assessment)

## Step 2: Filter for Relevance

Read `CLAUDE.md` → Key Context → **Target** and **Strongest angles** to understand what roles and locations to look for.

From the fetched listings, filter for roles matching the user's profile:

### Target keywords

Derive keywords from `CLAUDE.md` Key Context and `profile/strengths.md`. Typical categories:
- Primary skills (e.g., AI/ML, mobile, backend, blockchain)
- Seniority level (e.g., Senior, Staff, Lead, Principal)
- Leadership (CTO, VP Engineering, Head of Engineering, Founding Engineer, Engineering Manager)

### Disqualifiers (skip immediately, note reason)

Derive from `CLAUDE.md` Key Context (target location, salary expectations):
- **Location restricted** to regions that exclude the user's location (check `CLAUDE.md` for target/constraints)
- **On-site / hybrid** with no remote option (unless relocation is appealing — ask if unclear)
- **Seniority mismatch** — too junior or too senior for the user's profile
- **Language requirements** the user doesn't meet
- **Salary significantly below expectations** (if stated in profile)

### Maybe pile
- Remote roles at companies that might consider international contractors — flag as "worth asking"
- Roles slightly outside core skills but at great companies — flag as "stretch"

## Step 3: Assess Each Relevant Role

For each role that passes the filter, produce a quick assessment:

### Per-role assessment

Read `profile/summary.md` and `profile/strengths.md` (if not already read in this session).

For each role:
- **Title & Company**
- **Location**: Remote worldwide / Remote US / Hybrid / etc.
- **Salary**: Range if listed, or "not listed"
- **Fit score**: 1-10 (quick gut check against profile)
- **Strong matches**: 2-3 bullet points mapping to the user's actual experience
- **Gaps**: Key requirements the user doesn't have
- **Verdict**: Apply / Skip / Worth investigating / Stretch

### For individual listings (Step 1c)

Do a deeper assessment:
- Full fit analysis (like Step 2 in `/apply`)
- Research the company briefly (what they do, size, funding)
- Recommend whether to proceed with `/apply`

## Step 4: Present Results

### Summary table

Present a markdown table sorted by fit score (highest first):

```
| # | Role | Company | Location | Salary | Fit | Verdict |
|---|------|---------|----------|--------|-----|---------|
| 1 | AI Engineer | Acme | Remote WW | $150-180K | 8/10 | Apply |
| 2 | Sr Backend | BigCo | Remote US | $120-150K | 6/10 | Worth asking (US-remote) |
| 3 | Flutter Dev | StartupX | Remote EU | Not listed | 7/10 | Apply |
```

### Skipped roles (collapsed)

Briefly list roles that were skipped and why:
- "Sr. ML Engineer @ DataCo — US security clearance required"
- "Junior Developer @ SmallCo — seniority mismatch"

### Recommendations

- Which roles to pursue immediately (fit 7+)
- Which to investigate further (fit 5-6 with interesting aspects)
- Any companies worth watching even if no current match

## Step 5: Update todo.md (if actionable results found)

If any roles score 6+ fit:

1. Open `todo.md`
2. Under `## Applications (Priority Order)`, add entries for recommended roles:
   - Format: `- [ ] Review: {Company} — {Role} ({salary}, {location}) — **fit ~{X}/10**, {brief note}. [listing]({url})`
   - Use "Review:" prefix (not "Apply:") since the user hasn't decided yet
3. If this was a new job board not already tracked, add it to the relevant section

**Ask the user before updating todo.md** — present the proposed additions first.

## Error Handling

- **All fetch strategies fail:** Report what was tried, suggest the user paste content or try a different URL
- **No relevant roles found:** Report the search was done, note what was available (e.g., "23 listings, all US-only or unrelated stacks"), suggest checking back later
- **Ambiguous company name:** WebSearch to disambiguate, confirm with user
- **Rate limited:** Report it, suggest trying again later or using a different source
