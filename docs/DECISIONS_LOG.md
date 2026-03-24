# Decisions Log — Locked Architectural Decisions

> Entries here are LOCKED. Never re-ask questions that are already answered here.
> Add an entry whenever an architectural or tech-stack decision is made.
> Format: ## Decision Title → Decision Made → Rationale → Date Locked

---

## Dev environment mode
- Decision:   MODE A — WSL2 native (default for solo Windows development)
- Rationale:  Eliminates devcontainer permission layers and shell server crashes.
              Node + pnpm run natively in WSL2. Only Docker backing services run in containers.
              .devcontainer/ scaffolded for future MODE B compatibility — never opened in MODE A.
- Date locked: 2026-03-24 (Bootstrap)
- Agent:       CLAUDE_CODE

## Git branching strategy
- Decision:   Branch-per-feature with squash-merge (Rule 23)
- Rationale:  Keeps main clean. Every feature and Phase 4 Part gets its own branch.
              Branch naming: feat/{slug} | scaffold/part-{N} | fix/{slug}
              Commit style: conventional (feat:, fix:, chore:, docs:)
              Squash-merge only. Delete branches after merge.
- Date locked: 2026-03-24 (Bootstrap)
- Agent:       CLAUDE_CODE

## Model routing
- Decision:   planning: claude-code | execution: minimax-m1 | governance: gemini-2.5-flash-lite
- Rationale:  Claude Code for Phase 2 interview (best structured reasoning).
              MiniMax M1 via OpenRouter for Cline execution phases (free tier, strong SWE-Bench score).
              Gemini Flash-Lite for non-critical governance writes (cheapest available).
              Escalation: claude-sonnet-4-6 for complex multi-file reasoning or hard bugs.
- Date locked: 2026-03-24 (Bootstrap)
- Agent:       CLAUDE_CODE
