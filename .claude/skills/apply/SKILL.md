---
description: Full application workflow — research job listing, analyze fit, tailor resume, write cover letter, create tracking file, find hiring manager, generate PDFs.
user_invocable: true
---

# Apply to a Job

End-to-end application workflow: research, analyze fit, tailor resume, write cover letter, track, and export PDFs.

## Usage

Pass a job listing URL or pasted job description as argument:
- `/apply https://jobs.lever.co/company/role-id`
- `/apply [paste full job description text]`

If no argument is given, ask the user for a job listing URL or description.

## Step 0: Parse Input & Extract Identifiers

Determine what `$ARGUMENTS` contains:

**If it is a URL:**
1. Fetch the listing using `WebFetch`. If WebFetch fails (LinkedIn, Greenhouse behind auth, etc.), use `mcp__rubber-duck__ask_duck` with the prompt: "Fetch this job listing and extract: company name, exact job title, location, salary range (if listed), tech stack requirements, responsibilities, qualifications (required and preferred), and the full job description text. URL: {url}"
2. If both fail, ask the user to paste the job description text.

**If it is pasted text:**
1. Parse the text directly to extract: company name, exact job title, location, salary, tech stack, requirements, responsibilities, qualifications.

**Extract naming identifiers:**
- `{company}` — lowercase company name; hyphenate only multi-word names (e.g., `acme`, `big-corp`). Match existing conventions in `applications/` and `resume/` directories
- `{role}` — lowercase, hyphenated short role name (e.g., `ai-engineer`, `senior-backend`)
- `{Company}` — display name with original casing (e.g., `Acme`, `BigCorp`)
- `{Role}` — display role title (e.g., `AI Data Engineer`, `Senior Backend Engineer`)

**Present to user for confirmation before proceeding:**
> Parsed: **{Company} — {Role}**
> Files will be: `applications/{company}-{role}.md`, `applications/{company}-cover-letter.md`, `resume/v?-{company}/` (base version chosen in Step 2)
> Proceed? (or correct the names)

Wait for user confirmation.

## Step 1: Research the Company

Research the company using multiple sources in parallel:

1. `WebSearch` — search for "{Company} company", "{Company} engineering blog", "{Company} crunchbase"
2. `WebFetch` — fetch the company's main website and /about or /team page
3. `mcp__rubber-duck__ask_duck` — "Research {Company}: What do they do? What's their tech stack? Any recent news, funding rounds, or notable engineering posts? What's their engineering culture like? Size and growth?"

Gather:
- What the company does (product, market, stage, funding)
- Tech stack and engineering culture
- Recent news or engineering blog posts
- Company size and growth trajectory
- Hiring manager (if findable)

Compile into 5-10 bullet research summary.

## Step 2: Analyze Fit & Decision Point

Read the user's profile to compare against job requirements:
- Read `profile/summary.md`
- Read `profile/strengths.md`
- Scan available base resume versions (`resume/v*/resume.md`, excluding company forks like `v1-google/`) to understand current framing

**Present company research and fit assessment to the user:**

### Company Research
- Present the 5-10 bullet research summary from Step 1 (what they do, tech stack, funding, size, recent news, engineering culture)

### Fit score: X/10

**Strong matches:**
- Each JD requirement that maps to concrete experience (with specific metrics/projects)

**Gaps / stretches:**
- Requirements where experience is thin or missing
- For each: is it addressable (transferable skill) or hard (no experience)?

**Positioning angle:**
- Based on `profile/strengths.md`, recommend which angle to lead with
- Suggest the resume headline (H2) and narrative framing

**Salary assessment:**
- Listed salary range vs. expectations
- Red/green flags (location restrictions, equity, contract type)

**Recommendation:** Apply / Skip / Apply with caveats

**DECISION POINT — Ask the user:**
1. Proceed with resume tailoring and cover letter? (yes / skip / adjust angle)
2. Which base resume version to fork from? List available `resume/v*/` directories (excluding company forks like `v1-google/`). Show the headline (H2) of each version to help the user choose.

**Stop here if the user says skip.**

## Step 3: Fork and Tailor the Resume

### 3a: Create the fork

1. Create `resume/v{N}-{company}/` based on the user's chosen base version
2. Copy `resume-style.css` from the base directory (unchanged)
3. Copy `resume.md` from the base directory as starting point

### 3b: Tailor the resume

Modify `resume/v{N}-{company}/resume.md`:

1. **YAML frontmatter:** Update `stylesheet` path to `resume/v{N}-{company}/resume-style.css`
2. **Headline (H2):** Change to match the target role (e.g., "AI Data Engineer | LLM Extraction Pipelines & Content Discovery")
3. **Timezone line:** Adjust "flexible for X overlap" to match the role's timezone
4. **Links line:** Remove irrelevant links (e.g., pub.dev if not Flutter). Add language line if relevant
5. **Summary:** Rewrite to lead with the positioning angle. Open with the target role identity. Weave in the most relevant project/metric
6. **Skills section:** Reorder categories to match JD priority. Lead with their primary tech stack. De-emphasize irrelevant skills. Add legitimately held skills from JD not in the base
7. **Experience — role titles:** Adjust to de-emphasize irrelevant words (e.g., "Mobile" for backend roles)
8. **Experience — bullets:** Reframe through the relevant lens. Do NOT fabricate — only reframe existing accomplishments. Cross-check against `profile/summary.md`
9. **Experience — company descriptions:** Adjust framing for relevance
10. **Open Source / Writing section:** Adjust emphasis based on relevance

**Rules:**
- NEVER invent experience or metrics that don't exist in the profile
- Keep the resume to exactly 1 page (A4) — critical. If adding bullets, remove less relevant ones
- Maintain the exact markdown structure and formatting conventions of the base

### 3c: Self-review pass 1 — Requirements coverage

Go through every requirement in the JD (required and preferred):
- Is it addressed somewhere in the resume?
- If a strong match exists, is it prominent enough?
- If a gap exists, is the closest transferable experience visible?

Fix any gaps found.

### 3d: Self-review pass 2 — Quality and consistency

Check for:
- Typos, grammar, awkward phrasing
- Consistent date formats and style
- No orphaned references (e.g., mentioning Flutter in summary when de-emphasized elsewhere)
- H2 headline matches the narrative in the summary
- Skills section categories make sense together
- Resume tells a coherent story top to bottom
- Will fit on exactly 1 page

Fix any issues found.

### 3e: Duck verification

Use `mcp__rubber-duck__ask_duck`:

> You are a senior technical recruiter reviewing a resume for the role of {Role} at {Company}. Here is the job description: [paste key requirements]. Here is the resume: [paste full resume.md content]. Score the resume 1-10 for: (1) relevance to this specific role, (2) impact of bullet points, (3) ATS keyword coverage, (4) overall narrative coherence. Flag any red flags, missing keywords, or improvements.

If the duck identifies significant issues (score below 7 on any dimension or critical missing keywords), fix them and re-verify once.

## Step 4: Write the Cover Letter

### 4a: Draft the cover letter

Create `applications/{company}-cover-letter.md`:

```markdown
---
pdf_options:
  format: A4
  margin:
    top: 20mm
    bottom: 20mm
    left: 20mm
    right: 20mm
---

# Cover Letter — {Company}, {Role}

Hi,

[Opening hook — 1-2 sentences connecting YOUR specific experience to THEIR specific problem. Reference their product/problem, not your background. Not generic.]

**[Claim 1 with bold lead-in.]** [2-3 sentences with specific metrics and project names. Map directly to their top requirement.]

**[Claim 2 with bold lead-in.]** [2-3 sentences. Map to their second priority.]

**[Claim 3 (optional) with bold lead-in.]** [Third strong angle or honest gap acknowledgment.]

[Closing — 1-2 sentences. Timezone, availability.]

{YOUR_NAME}
{YOUR_EMAIL} | {YOUR_PHONE}
{YOUR_GITHUB_URL}
```

**Cover letter rules:**
- 200-300 words total (excluding header and signature)
- Never use generic phrases like "I'm excited about your mission" — always be specific
- Each bolded claim must include at least one concrete metric or project name
- If there's a notable gap, address it honestly in one claim paragraph (see existing cover letters in `applications/` for patterns)
- Opening hook should reference THEIR product/problem
- Link to your key open-source project if relevant; otherwise minimize links in body

### 4b: Self-review pass 1 — Alignment

- Does the opening hook reference their specific product/problem?
- Does each claim map to a specific JD requirement?
- Are all metrics accurate (cross-check against `profile/summary.md` and resume)?
- Is the tone confident but not arrogant?
- Are gaps addressed honestly where needed?

Fix any issues.

### 4c: Self-review pass 2 — Language and length

- Word count within 200-300?
- No generic phrases or filler?
- Natural flow from hook to claims to closing?
- Signature format matches existing cover letters?

Fix any issues.

### 4d: Duck verification

Use `mcp__rubber-duck__ask_duck`:

> You are a hiring manager for the {Role} position at {Company}. Review this cover letter. Does the opening hook grab attention? Do the claims feel specific and credible? Is anything generic, vague, or overselling? Would you want to interview this person? Suggest one specific improvement. Cover letter: [paste content]

If the duck identifies a specific weakness, address it.

## Step 5: Create Application Tracking File

Create `applications/{company}-{role}.md` using the structure from `applications/_template.md`, filled in with actual data:

- Status: Preparing
- Role details from the parsed job listing
- Fit assessment (strong matches + gaps) from Step 2
- Key contacts from research
- Timeline: today's date + "Application prepared"
- Notes: research highlights, keyword matches, interview prep notes

## Step 5b: Find Hiring Manager

X-ray LinkedIn to identify the engineering decision-maker who likely owns this hire.

**Run 1-2 WebSearch queries based on the role and company stage:**

General engineering leadership:
```
site:linkedin.com/in ("Head of Engineering" OR "VP Engineering" OR "Director of Engineering" OR CTO OR "Engineering Manager") "{Company}"
```

For early-stage startups (Seed – Series A), also search:
```
site:linkedin.com/in (CTO OR "Co-founder" OR "Founder") "{Company}"
```

For AI/ML roles, also search:
```
site:linkedin.com/in ("Head of AI" OR "AI Lead" OR "ML Engineering Manager" OR "VP of AI" OR "Director of AI") "{Company}"
```

**Pick the best target** based on company stage:
- Seed – Series A → CTO, Founder
- Series B – C → Engineering Manager, Director of Engineering
- Late stage / Enterprise → VP Engineering, Head of [Area]

**Update the tracking file** — fill in the Key Contacts table with the best match (name + LinkedIn URL). If multiple strong candidates found, list the top 2.

If no results found, note: "No hiring manager found via X-ray — try manual LinkedIn search"

**Present findings to user:**
> **Hiring manager found:** {Name} — {Title} at {Company}
> LinkedIn: {URL}
>
> Consider warming up their profile (view + like a post) before reaching out in 1-2 days.

## Step 6: Update todo.md

Add the application entry in `todo.md`:
- Look for the `## Applications (Priority Order)` section
- Add a new unchecked entry matching the format of existing entries (e.g., `- [ ] Apply: {Company} — {Role} ({salary}, {location}) — preparing`)
- Use em dashes (—) consistently with the rest of the list

## Step 7: Generate PDFs

**Important:** Run each `md-to-pdf` call in a separate sequential command — do NOT chain with `&&` or run in parallel. Puppeteer/Chromium stalls when multiple instances launch concurrently.

1. Resume PDF:
   ```
   npx md-to-pdf resume/v{N}-{company}/resume.md
   ```
   Verify `resume/v{N}-{company}/resume.pdf` exists. Report file size.

2. Cover letter PDF (separate command):
   ```
   npx md-to-pdf applications/{company}-cover-letter.md
   ```
   Verify `applications/{company}-cover-letter.pdf` exists. Report file size.

## Step 8: Final Summary

Present completion summary:

> ### Application ready: {Company} — {Role}
>
> **Files created:**
> - Resume: `resume/v{N}-{company}/resume.pdf` ({size})
> - Cover letter: `applications/{company}-cover-letter.pdf` ({size})
> - Tracking: `applications/{company}-{role}.md`
> - Updated: `todo.md`
>
> **Fit score:** X/10
> **Key angle:** {1-sentence positioning summary}
>
> **Next steps:**
> - Submit application at: {URL}
> - Update tracking file status to "Applied" after submission
> - Follow up if no response by: {date ~2 weeks out}

## Error Handling

- **URL fetch fails:** Try `ask_duck` → ask user to paste text
- **Company name ambiguous:** Ask user to confirm before creating files
- **Resume exceeds 1 page:** Trim bullets, tighten language — never go to 2 pages
- **Duck unavailable:** Proceed with self-review only, note it was skipped
- **Files already exist:** Ask user if re-application or name adjustment needed
