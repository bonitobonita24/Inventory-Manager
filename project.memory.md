# Project Memory — Spec-Driven Platform V14

> This file is agent-owned. Never edit manually.
> Updated by agents after significant phase transitions.

---

## Active Rules
- V14 — 25 rules total
- Rule 4: Read 9 governance docs before any action (lessons.md first)
- Rule 8: .devcontainer frozen after Phase 3 — MODE B only. MODE A: no devcontainer.
- Rule 9: Bidirectional governance — PRODUCT.md ↔ inputs.yml always in sync
- Rule 12: TypeScript strict everywhere — no any types
- Rule 13: Mobile apps never access packages/db — API only
- Rule 15: Every CHANGELOG_AI.md entry includes agent attribution
- Rule 16: Visual QA after Phase 6 + major Phase 7 updates
- Rule 17: Search before reading — codebase_search first
- Rule 18: Typed lessons.md — 🔴 gotchas + 🟤 decisions read first
- Rule 19: SpecStory is passive memory layer — powers Governance Sync
- Rule 20: <private> tags never stored or propagated
- Rule 21: design-system/MASTER.md read before any UI generation (skip if absent)
- Rule 22: Unique random dev ports + COMPOSE_PROJECT_NAME container naming per project
- Rule 23: Git branch-per-feature — feat/{slug}, squash-merge, never commit to main
- Rule 24: Fresh context per Phase 4 Part — STATE.md read first every session
- Rule 25: Two-stage code review — spec compliance then quality, TDD enforced

## Agent Stack
| Agent | Role | Auto-loads config |
|-------|------|-------------------|
| Claude Code | Planning (Phase 2) | CLAUDE.md auto-loaded |
| Cline | Building (Phase 3-8) | .clinerules auto-loaded |
| Copilot | Inline autocomplete + Chat edits | SpecStory captures diffs |
| SpecStory | Passive change capture | .specstory/config.json |
| SocratiCode | Codebase semantic search | .vscode/mcp.json |
| code-review-graph | Structural blast-radius | Claude plugin (per machine) |

## Dev Environment Mode
MODE A — WSL2 native (locked in DECISIONS_LOG.md)

## Phase 4 Model Routing
- Planning:   claude-code
- Execution:  minimax-m1 (free tier, via OpenRouter)
- Governance: gemini-2.5-flash-lite (cheapest)
- Escalation: claude-sonnet-4-6 (complex bugs only)
