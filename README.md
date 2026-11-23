# The 17-agent SDR team

17 AI agents that run a full sales funnel: find the accounts, find the people, write the outreach, run the pipeline.
Each agent does one part of the process end to end, the way a good SDR would.

All 17 run on one connection: the [ColdIQ MCP](https://coldiq.com). One account reaches 11 data providers: PredictLeads, TheirStack, Sumble, Openmart, AI Ark, Prospeo, Findymail, FullEnrich, LeadMagic, Limadata and Exa. No 11 subscriptions, no 11 API keys. Apollo.io plugs in with your own Apollo key, and the same MCP pushes leads to lemlist and Instantly.

Works in Grok Bot, Grok Build, Claude Code, Cursor, Codex, ChatGPT and Claude.

## The 17 agents

### Step 1: Find the accounts

1. [ICP Finder](skills/01-icp-finder/SKILL.md) (ColdIQ x Apollo.io): turns one sentence into a target account list. *ColdIQ MCP*
2. [Funding Radar](skills/02-funding-radar/SKILL.md) (PredictLeads): companies that just raised. *ColdIQ MCP*
3. [Hiring Radar](skills/03-hiring-radar/SKILL.md) (TheirStack): companies hiring SDRs or AEs. *ColdIQ MCP*
4. [Tech Stack Spy](skills/04-tech-stack-spy/SKILL.md) (Sumble): who uses the tool you replace. *ColdIQ MCP*
5. [Local Finder](skills/05-local-finder/SKILL.md) (Openmart): shops, clinics and agencies by city. *ColdIQ MCP*
6. [Lookalike Finder](skills/06-lookalike-finder/SKILL.md) (AI Ark): 50 companies like your best customer. *ColdIQ MCP*

### Step 2: Find the people

7. [Decision Maker Finder](skills/07-decision-maker-finder/SKILL.md) (ColdIQ): the right title at every account. *ColdIQ MCP*
8. [Email Finder](skills/08-email-finder/SKILL.md) (Prospeo x Findymail): verified work emails only. *ColdIQ MCP*
9. [Phone Finder](skills/09-phone-finder/SKILL.md) (FullEnrich x LeadMagic): mobile numbers through the ColdIQ waterfall. *ColdIQ MCP*
10. [LinkedIn Profiler](skills/10-linkedin-profiler/SKILL.md) (Limadata): role, tenure and what they posted lately. *ColdIQ MCP*
11. [Account Researcher](skills/11-account-researcher/SKILL.md) (Exa): a one-paragraph brief on each company. *ColdIQ MCP*

### Step 3: Write the outreach

12. [Cold Email Writer](skills/12-cold-email-writer/SKILL.md) (Wispr Flow): dictate the campaign, get a 3-step sequence. *ColdIQ MCP + Slack MCP*
13. [LinkedIn DM Writer](skills/13-linkedin-dm-writer/SKILL.md) (lemlist): the connection note and the follow-up. *ColdIQ MCP*
14. [Reply Handler](skills/14-reply-handler/SKILL.md) (Slack): drafts every answer and books the call. *ColdIQ MCP + Slack MCP*

### Step 4: Run the pipeline

15. [Campaign Launcher](skills/15-campaign-launcher/SKILL.md) (Instantly): pushes every lead into the right sequence. *ColdIQ MCP*
16. [Follow-up Chaser](skills/16-follow-up-chaser/SKILL.md) (Customer.io x PostHog): nudges everyone who went quiet. *ColdIQ MCP + Slack MCP*
17. [CRM Logger](skills/17-crm-logger/SKILL.md) (Twenty or folk): every contact and reply lands in your CRM. *ColdIQ MCP + Slack MCP*

## Install in 2 steps

### 1. Connect the ColdIQ MCP

Server URL: `https://mcp.coldiq.com/mcp`

It signs in with your ColdIQ account (OAuth). There is no API key to paste and nothing secret in this repo. New accounts get up to 1,450 credits as they get started.

- **Grok Bot**: in a chat, ask: `Add this MCP server: https://mcp.coldiq.com/mcp` and sign in when asked.
- **Claude Code**: `claude mcp add --transport http coldiq https://mcp.coldiq.com/mcp` (or keep the `.mcp.json` of this repo and open Claude Code in this folder).
- **Cursor**: Settings > MCP > Add server, URL `https://mcp.coldiq.com/mcp` (or copy `install/cursor-mcp.json` to `.cursor/mcp.json`).
- **Codex**: add the block of `install/codex-config.toml` to `~/.codex/config.toml`.
- **ChatGPT / Claude (web and mobile)**: Settings > Connectors > Add custom connector, URL `https://mcp.coldiq.com/mcp`.

### 2. Load the agents

- **Grok Bot**: create one Bot per agent. Paste the content of its `SKILL.md` as the Bot instructions. Start with 01, 07, 08 and 12: that is a working funnel already.
- **Grok Build**: `grok plugin install https://github.com/julescoldiq/sdr-17-agents`. The plugin bundles the 17 skills and the ColdIQ MCP. Then open `/mcps`, select `coldiq`, press `i` to sign in.
- **Claude Code**: `./install.sh claude` copies the 17 skills to `~/.claude/skills/`. Then: `/01-icp-finder B2B SaaS in France, 20 to 200 employees`.
- **Cursor**: `./install.sh cursor` writes them to `.cursor/rules/` of the current project.
- **Codex**: `./install.sh codex` writes one `AGENTS.md` with the 17 agents.
- **ChatGPT / Claude projects**: one project per agent, paste its `SKILL.md` as the project instructions.

## Always up to date

Each agent starts by asking the ColdIQ MCP how ColdIQ runs that job today (`search_knowledge` and `load_skill`), so the method follows ColdIQ's playbooks as they improve. The files here fix the scope, the output and the hand-off.

## Agents 12, 14, 16 and 17

They use ColdIQ for the method and your own tools for the rest:
- **12 Cold Email Writer**: you dictate with [Wispr Flow](https://wisprflow.ai) (any voice-to-text works), it writes from the columns the data agents filled.
- **14 Reply Handler**: reads replies through the ColdIQ MCP, posts drafts in Slack through the Slack MCP.
- **16 Follow-up Chaser**: PostHog MCP and Customer.io MCP.
- **17 CRM Logger**: Twenty MCP or the folk API.

## Guardrails built into every agent

- A paid pull over 10 rows shows its row count and estimated credits, then waits for your yes.
- No agent sends, posts, starts or activates anything. They prepare, you click.
- No invented facts: missing data is reported as missing.

## Run the full funnel

`01 ICP Finder` (or 02 to 06 for a signal) > `07 Decision Maker Finder` > `08 Email Finder` + `09 Phone Finder` > `10 LinkedIn Profiler` + `11 Account Researcher` > `12 Cold Email Writer` + `13 LinkedIn DM Writer` > `15 Campaign Launcher` > `14 Reply Handler` > `16 Follow-up Chaser` > `17 CRM Logger`

Built by [ColdIQ](https://coldiq.com).
