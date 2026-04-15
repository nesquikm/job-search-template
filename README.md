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

### 2. Install fetch and search MCP servers (required)

Claude Code's built-in `WebFetch` respects `robots.txt`, so it gets blocked by most job boards (Greenhouse, Lever, LinkedIn, Reddit, etc.). You need `mcp-server-fetch` with `--ignore-robots-txt` plus a web search tool — without these, `/scout` and `/apply` can't read listings from the majority of sources.

Add these to your Claude Code MCP config (`~/.claude.json` → `mcpServers`):

```json
"fetch": {
  "type": "stdio",
  "command": "uvx",
  "args": ["mcp-server-fetch", "--ignore-robots-txt"]
},
"ddgsearch": {
  "type": "stdio",
  "command": "uvx",
  "args": ["duckduckgo-mcp-server"]
}
```

**Notes:**
- **fetch** — retrieves URLs that Claude's built-in `WebFetch` refuses (the `--ignore-robots-txt` flag is the critical bit)
- **ddgsearch** — web search via DuckDuckGo (no API key required)
- For JS-heavy pages (some careers portals), also install `chrome-devtools-mcp@latest` as an additional MCP server, or reach it via Rubber Duck below

<details>
<summary><strong>Included: Himalayas MCP for direct job search</strong></summary>

This template ships with [Himalayas](https://himalayas.app/) MCP pre-configured in `.mcp.json`. Claude Code will prompt you to approve the server on first use. Once approved, `/scout` and `/apply` can query Himalayas directly via `mcp__himalayas__search_jobs` and `mcp__himalayas__search_companies` instead of scraping the website.

To auto-approve without prompts, add to `.claude/settings.local.json`:

```json
{
  "enabledMcpjsonServers": ["himalayas"]
}
```

</details>

### 3. Install MCP Rubber Duck (recommended, optional)

[MCP Rubber Duck](https://github.com/nesquikm/mcp-rubber-duck) lets Claude Code query other LLMs as a second opinion — used by `/apply` to verify resumes and cover letters, and by `/scout` as a fallback when a page needs a different model to parse. With the MCP Bridge enabled, ducks can also reach external MCP servers themselves (useful for delegating long-running fetches or browser sessions).

Add this alongside the `fetch` and `ddgsearch` entries in `~/.claude.json` → `mcpServers`:

```json
"rubber-duck": {
  "type": "stdio",
  "command": "npx",
  "args": ["-y", "mcp-rubber-duck@latest"],
  "env": {
    "OPENAI_API_KEY": "your-openai-api-key",
    "OPENAI_DEFAULT_MODEL": "gpt-4.1",
    "DEFAULT_PROVIDER": "openai",

    "MCP_BRIDGE_ENABLED": "true",
    "MCP_APPROVAL_MODE": "trusted",

    "MCP_SERVER_FETCH_TYPE": "stdio",
    "MCP_SERVER_FETCH_COMMAND": "uvx",
    "MCP_SERVER_FETCH_ARGS": "mcp-server-fetch,--ignore-robots-txt",
    "MCP_SERVER_FETCH_ENABLED": "true",
    "MCP_TRUSTED_TOOLS_FETCH": "*",

    "MCP_SERVER_DDGSEARCH_TYPE": "stdio",
    "MCP_SERVER_DDGSEARCH_COMMAND": "uvx",
    "MCP_SERVER_DDGSEARCH_ARGS": "duckduckgo-mcp-server",
    "MCP_SERVER_DDGSEARCH_ENABLED": "true",
    "MCP_TRUSTED_TOOLS_DDGSEARCH": "*",

    "MCP_SERVER_CHROME_TYPE": "stdio",
    "MCP_SERVER_CHROME_COMMAND": "npx",
    "MCP_SERVER_CHROME_ARGS": "chrome-devtools-mcp@latest",
    "MCP_SERVER_CHROME_ENABLED": "true",
    "MCP_TRUSTED_TOOLS_CHROME": "*"
  }
}
```

**Notes:**
- Replace `your-openai-api-key` with your actual key. Swap providers — see [MCP Rubber Duck docs](https://github.com/nesquikm/mcp-rubber-duck#configuration) for Gemini, Ollama, and others.
- The bridged `fetch` / `ddgsearch` / `chrome` entries are for the duck's own use. Claude Code still uses the direct `fetch` / `ddgsearch` servers from step 2.
- Without Rubber Duck, `/apply` skips the second-LLM verification pass but otherwise works fine.

### 4. Set up your repo

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

### 5. Run the setup wizard

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

### 6. Start your search

Once set up, just talk to Claude naturally:

- *"Scout remote AI engineer roles on We Work Remotely"* (or `/scout https://weworkremotely.com`)
- *"What's open at Sourcegraph?"* (or `/scout Sourcegraph`)
- *"Apply to this role"* (or `/apply https://jobs.lever.co/company/role-id`)
- *"Update my resume for this NLP-focused role"*
- *"What's on my todo list for this week?"*
- *"Export my resume to PDF"* (or `/resume-pdf resume/v1`)

## Structure

```
profile/       # Your consolidated profile and positioning strategy
profiles/      # Platform-specific content (LinkedIn, etc.) — copy-paste ready
content/       # Published articles, comment targets, engagement tracking
research/      # Job boards, target companies, salary data, search strategies
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

### PDF engine

The `/setup-profile` wizard asks which PDF engine you prefer:

- **WeasyPrint** (recommended) — produces ATS-friendly PDFs with proper text extraction (bullet markers preserved, smaller files). Requires `brew install weasyprint`.
- **md-to-pdf** — Chrome/Puppeteer-based, simpler setup if you already have Node.js. Install with `npx md-to-pdf`.

The `/resume-pdf` skill auto-detects which engine to use based on your resume format.

## Day-to-Day Usage

| What you want to do | How to do it |
|---|---|
| Scout job openings | `/scout https://weworkremotely.com` or `/scout Sourcegraph` — search and filter |
| Scout multiple boards at once | *"Search WWR, Remotive, and Himalayas for AI roles"* — Claude spawns parallel scout agents |
| Apply to a job | `/apply https://...` or `/apply [paste job description]` — full workflow |
| Add a new application | Ask Claude — it creates `applications/{company}-{role}.md` and updates `todo.md` |
| Tailor resume for a company | Ask Claude to fork your latest base resume for the company |
| Export resume to PDF | `/resume-pdf resume/v1` (or any resume path) |
| Research a company | `/scout CompanyName` — finds careers page, lists roles, assesses fit |
| Find hiring managers | Use X-ray searches from `research/x-ray-searches.md` |
| Update your profile | Edit files in `profile/` and `profiles/` — Claude keeps them in sync |
| Track a deadline | Add it to `todo.md` with date format `— **Mon DD**` |

## Skills & Agents

This template includes two types of automation:

**Skills** (`.claude/skills/`) — interactive workflows you invoke with slash commands:
- `/scout <url or company>` — search a job board or company, filter and assess openings
- `/apply <url or text>` — full application workflow (research → resume → cover letter → PDFs)
- `/resume-pdf <path>` — export a resume to PDF
- `/setup-profile` — initial profile setup wizard

**Agents** (`.claude/agents/`) — autonomous workers Claude delegates to:
- **scout** — background/parallel version of `/scout` (see design note below)
- **research-assistant** — general-purpose research (company deep-dives, salary benchmarking, market analysis)

### Why both a skill and an agent for scouting?

The `/scout` skill and the `scout` agent share the same core logic (the agent injects the skill via `skills: [scout]`), but serve different use cases:

| | `/scout` skill | `scout` agent |
|---|---|---|
| **Invocation** | Explicit: `/scout https://...` | Auto-delegated or explicit |
| **Context** | Runs in your conversation | Runs in isolated context |
| **Interaction** | Asks before updating `todo.md` | Read-only — returns a report |
| **Parallelism** | One source at a time | Multiple agents in parallel |
| **Best for** | Exploring one board/company interactively | *"Search 5 boards for AI roles while I write a cover letter"* |

The agent is a lightweight read-only wrapper — it follows the skill's Steps 0–4 (fetch, filter, assess, present) and skips Step 5 (file updates). The main conversation reviews the agent's report and decides what to add to `todo.md`.

## Important

**Keep this repo private** — it contains your personal career strategy, salary expectations, and application details.
