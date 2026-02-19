# CLAUDE.md

## Project Overview

<!-- SETUP: This section will be filled in by /setup-profile -->
Private job search project for **{YOUR_NAME}** ({YOUR_GITHUB_USERNAME}). Tracks research, target companies, applications, and action items for finding a remote {YOUR_TARGET_ROLE} role.

## Key Context

- **Target:** {YOUR_TARGET} (e.g., "Remote positions, preferably US-benchmarked salary")
- **Strongest angles:** {YOUR_ANGLES} (e.g., "MCP expertise, Flutter/mobile, AI/LLM tooling")
- **Online presence:** {YOUR_LINKS} (e.g., [GitHub](url) | [LinkedIn](url) | [dev.to](url))

## Structure

```
profile/       # Skills, experience, positioning strategy
profiles/      # One file per platform (dev.to, LinkedIn, etc.) — copy-paste ready
content/       # Published articles, Reddit posts, comment targets
research/      # Job boards, target companies, salary data
applications/  # Individual application tracking (one file per application)
resume/        # Resume versions and company-specific forks
reading/       # Articles, videos, books to read/watch/review for prep
todo.md        # Action items and quick wins
```

### Resume structure

- `resume/v1/`, `resume/v2/`, etc. — base resume versions
- `resume/v{N}-{company}/` — company-specific forks (e.g., `v1-google/`, `v1-stripe/`)
- Each directory contains `resume.md`, `resume-style.css`, and `resume.pdf`
- When forking a resume for a company, create a new directory — never modify the base version

## Tools

<!-- SETUP: Add MCP tools and integrations you use here. Examples: -->
<!-- - **Google Calendar** — can create/modify events and reminders via MCP (email: you@example.com, timezone: Your/Timezone) -->
<!-- - **Slack** — can search and send messages via MCP -->

## Skills

- Check `.claude/skills/` for available skills and **use them** when applicable (e.g., PDF export)

## Reminders

- At the start of each conversation, scan `todo.md` for items with dates (e.g., **Feb 20**) that are due today or overdue — surface them proactively
- Use bold date format in todo items: `— **Mon DD**` (e.g., `— **Feb 20**`)

## Guidelines

- Keep company/role data up to date — job listings expire fast
- When adding a new application, create `applications/{company}-{role}.md`
- All salary figures are annual USD unless noted otherwise
- Don't push this repo to public — contains personal career strategy
- Update todo.md when completing action items or discovering new ones
- When commenting on articles, be genuine — add value first, mention your projects only when naturally relevant

## Data Sync Points

These values appear in multiple files. When **any** value changes, update **all** listed locations.

<!-- SETUP: Add your own sync points here as your data grows. Examples below. -->

### Key project stats
<!-- Example: your main open-source project -->
Current: **{STAR_COUNT}+ stars** — update when crossing next threshold
- `CLAUDE.md` → Key Context section (this file)
- `profile/summary.md` → Open Source section
- `profile/strengths.md` → relevant expertise section
- `profiles/linkedin-about.md` → first paragraph
- `profiles/linkedin-projects.md` → project entry
- All `resume/v*/resume.md` → Summary and/or Open Source sections

### Article count and listings
Current: **{ARTICLE_COUNT} articles** ({BREAKDOWN})
- `content/my-articles.md` — **single source of truth**, add new entries here first
- `profile/summary.md` — article list with links and dates
- All `resume/v*/resume.md` — update article count in Summary or Writing section
- Regenerate PDFs for any updated resumes

### When publishing a new article
1. Add entry to `content/my-articles.md`
2. Add to `profile/summary.md` article list
3. Grep all `resume/v*/resume.md` for the current article count and update
4. Check if any resume version lists individual articles — add the new one there too
5. Update series count in `profile/strengths.md` if it's part of a blog series
6. Regenerate PDFs for all updated resumes

### When key project stats change significantly
1. Update threshold number in all locations listed under "Key project stats"
2. Update `CLAUDE.md` Key Context (this file)
