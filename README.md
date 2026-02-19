# Job Search Command Center

Your private, AI-powered job search headquarters. Everything lives in Markdown files — version-controlled, portable, and fully accessible to Claude Code.

## Why Markdown?

- **Version control** — track every change with git, never lose progress
- **AI-native** — Claude Code can read, edit, and cross-reference all your files
- **Portable** — no vendor lock-in, works with any editor or tool
- **Consistency** — Claude enforces data sync rules across all documents automatically

## Getting Started

### 1. Install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

### 2. Set up your repo

**Option A — Clone this template:**
```bash
git clone <this-repo-url> my-job-search
cd my-job-search
```

**Option B — Start fresh:**
```bash
mkdir my-job-search && cd my-job-search
git init
# Copy the template files into this directory
```

### 3. Run the setup wizard

```bash
claude
```

Once inside Claude Code, run the interactive setup:

```
/setup-profile
```

This will walk you through filling in your information step by step:
- Your name, location, contact info, and online profiles
- Target roles and salary expectations
- Work experience (newest to oldest)
- Key projects and open source work
- Published articles or technical writing
- Skills and tech stack

Claude will populate all your profile files, create your first resume version, and configure the data sync points in `CLAUDE.md`.

### 4. Start your search

Once set up, just talk to Claude naturally:

- *"Research senior AI engineer roles at Anthropic"*
- *"Add an application for Company X — Backend Engineer"*
- *"Update my resume for this NLP-focused role"*
- *"What's on my todo list for this week?"*
- *"Export my resume to PDF"* (or `/resume-pdf resume/v1`)

## Structure

```
profile/       # Your consolidated profile and positioning strategy
profiles/      # Platform-specific content (LinkedIn, etc.) — copy-paste ready
content/       # Published articles, comment targets, engagement tracking
research/      # Job boards, target companies, salary data
applications/  # One file per application — status, notes, follow-ups
resume/        # Resume versions and company-specific forks
reading/       # Interview prep resources — articles, books, videos
todo.md        # Action items, deadlines, and quick wins
```

### Resume versioning

- `resume/v1/`, `resume/v2/`, etc. — base resume versions (iterate as your positioning evolves)
- `resume/v1-{company}/` — company-specific forks (tailored for a specific application)
- Each directory contains `resume.md`, `resume-style.css`, and `resume.pdf`
- Never modify a base version when tailoring — always create a new fork

## Day-to-Day Usage

| What you want to do | How to do it |
|---|---|
| Add a new application | Ask Claude — it creates `applications/{company}-{role}.md` and updates `todo.md` |
| Tailor resume for a company | Ask Claude to fork your latest base resume for the company |
| Export resume to PDF | `/resume-pdf resume/v1` (or any resume path) |
| Research a company | Ask Claude — it can search the web and save findings |
| Update your profile | Edit files in `profile/` and `profiles/` — Claude keeps them in sync |
| Track a deadline | Add it to `todo.md` with date format `— **Mon DD**` |

## Important

**Keep this repo private** — it contains your personal career strategy, salary expectations, and application details.
