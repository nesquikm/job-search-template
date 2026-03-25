---
name: setup-profile
description: Interactive onboarding wizard that populates all job search files with your personal information. Run this first after cloning the template.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
---

# Job Search Profile Setup Wizard

You are guiding the user through setting up their private job search repository. This is an interactive, step-by-step process. Ask questions, wait for answers, then populate the files.

## Important Rules

- Go **one step at a time** — don't overwhelm with all questions at once
- After each step, **write the data to the actual files** before moving on
- Use `AskUserQuestion` for structured choices, plain questions for free-form input
- If the user doesn't have something (e.g., no articles yet), skip it gracefully and note it as a todo
- Be encouraging — this is a big task and the user is investing in their career

## Step 1: Basic Information

Ask for:
- Full name
- Location and timezone (e.g., "Berlin, Germany (GMT+1)")
- Email address
- Phone number (optional, for resume)
- GitHub username
- LinkedIn profile URL
- Other profiles (dev.to, Medium, personal website, etc.)

**After collecting:** Update `CLAUDE.md` (Project Overview, Key Context → Online presence), and create a starter `profile/summary.md` with the header info.

## Step 2: Target Roles

Ask for:
- What kind of roles are you looking for? (e.g., Senior Backend Engineer, AI Engineer, CTO)
- Remote preference (fully remote, hybrid, on-site, relocation OK?)
- Target salary range (annual USD)
- Geographic preferences (US companies, EU, anywhere?)
- What's your #1 priority in the next role? (compensation, learning, impact, title, etc.)

**After collecting:** Update `CLAUDE.md` (Key Context → Target), update `profile/strengths.md` with positioning section, add initial entries to `research/salary-data.md`.

## Step 3: Work Experience

Ask for each role (start from most recent):
- Company name and location
- Your title
- Start and end dates
- What the company does (one line)
- 2-3 bullet points of key achievements (quantify where possible!)
- Team size you worked with/led

Repeat until the user says they're done. Suggest they include at least the last 5 years.

**After collecting:** Update `profile/summary.md` (Work History), create `profiles/linkedin-experience.md`, and populate `resume/v1/resume.md` with the Experience section.

## Step 4: Skills & Tech Stack

Ask for:
- Primary programming languages (with years of experience)
- Frameworks and platforms (e.g., Flutter, React, Node.js, AWS)
- AI/ML tools if any (LLMs, MCP, RAG, prompt engineering, etc.)
- Databases and infrastructure
- Leadership experience (team sizes, CTO/lead roles)
- Any certifications or notable credentials

**After collecting:** Update `profile/summary.md` (Skills), `resume/v1/resume.md` (Skills section).

## Step 5: Key Projects & Open Source

Ask for:
- Notable open-source projects (with GitHub URLs and star counts)
- Key side projects or personal products
- Published packages (npm, pub.dev, PyPI, etc.)

**After collecting:** Update `profile/summary.md` (Open Source), `profiles/linkedin-projects.md`, `resume/v1/resume.md` (Open Source section). If they have a standout project, set up the Data Sync Point in `CLAUDE.md`.

## Step 6: Technical Writing & Content

Ask for:
- Published articles (title, platform, URL)
- Blog or newsletter
- Conference talks or podcasts
- Active communities (Reddit, Discord, HN)

**After collecting:** Update `content/my-articles.md`, `profile/summary.md` (Articles), `resume/v1/resume.md` (Technical Writing section). Set up article count Data Sync Point in `CLAUDE.md`.

## Step 7: Education

Ask for:
- University/school and degree
- Notable achievements (honors, publications, open source contributions)

**After collecting:** Update `resume/v1/resume.md` (Education section).

## Step 8: Strongest Angles & Positioning

Now that you have all the data, analyze it and:
- Identify the user's **core differentiator** (unique combination of skills)
- Suggest **positioning by role type** (how to pitch for each target role)
- Identify **gaps** to address

Write this analysis to `profile/strengths.md`.

## Step 9: LinkedIn Copy

Generate copy-paste-ready content:
- `profiles/linkedin-about.md` — About section (compelling, achievement-focused)
- Update `profiles/linkedin-projects.md` with actual project data
- Verify `profiles/linkedin-experience.md` has recommended titles

## Step 10: PDF Engine Choice

Ask the user which PDF engine they prefer:

> **How would you like to generate resume PDFs?**
>
> 1. **WeasyPrint** (recommended) — better ATS text extraction, smaller files, bullet markers preserved. Requires `brew install weasyprint` (or pip).
> 2. **md-to-pdf** — Chrome/Puppeteer-based, uses npm. Simpler setup if you already have Node.js.

**Based on their choice:**

- **WeasyPrint:** Use `resume/v1-weasyprint/` as the base. The resume.md has no YAML frontmatter; the CSS includes `@page` rules for margins. Delete the `resume/v1/` directory (md-to-pdf starter) and rename `resume/v1-weasyprint/` to `resume/v1/`.
- **md-to-pdf:** Use the existing `resume/v1/` as-is. Delete the `resume/v1-weasyprint/` directory.

Update `CLAUDE.md` to note which engine is in use.

## Step 11: Final Setup

1. Complete the active `resume/v1/resume.md` with all sections (YAML front matter for md-to-pdf, or clean markdown for WeasyPrint)
2. Update all `{PLACEHOLDER}` values in `CLAUDE.md` with real data
3. Update `todo.md` with personalized action items:
   - Mark setup steps as complete
   - Add "Upload resume to [platform]" items
   - Add "Apply to [company]" items based on target roles
4. Give the user a summary of everything that was set up
5. Suggest next steps:
   - Export resume to PDF: `/resume-pdf resume/v1`
   - Research target companies: *"Research [role] roles at [companies]"*
   - Start applying!

## Resuming

If the user has already partially completed setup (some files have real data), acknowledge what's done and pick up from where they left off. Check files for `{PLACEHOLDER}` markers or `<!-- SETUP: -->` comments to find what still needs filling in.
