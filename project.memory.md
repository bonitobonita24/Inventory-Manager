# project.memory.md — Spec-Driven Platform V12 Reference

> This file is the quick reference for resuming sessions.
> Full rules in CLAUDE.md.

---

## The 5 Agents
- **Claude Code**: Planning only (Phase 2). Auto-loads CLAUDE.md.
- **Cline**: Building everything (Phase 4-8). Reads .clinerules. Fully automated.
- **Copilot**: Inline autocomplete. Attribution via SpecStory + Governance Sync.
- **SpecStory**: Passive change capture. Auto-captures all sessions + diffs.
- **SocratiCode**: Codebase intelligence MCP. Search before reading (Rule 17).

---

## The 21 Rules (Summary)

1. **PRODUCT.md is sole source of truth** — only file humans edit
2. **Agents own spec files** — inputs.yml + schema regenerated from PRODUCT.md
3. **Log every change with attribution** — CHANGELOG_AI + DECISIONS_LOG + IMPLEMENTATION_MAP
4. **Read 9 context docs before any change** — lessons.md FIRST (Rule 18 order)
5. **Compose-first, AWS-ready by default** — Docker Compose splits per service group
6. **K8s scaffold inactive by default** — only when `deploy.k8s.enabled: true`
7. **Multi-tenant database strategy** — shared schema + tenant_id, L3/L5/L6 always active
8. **Devcontainer frozen after initial setup** — replace {{APP_NAME}} once, never again
9. **Bidirectional governance** — PRODUCT.md ↔ inputs.yml + docs
10. **Never infer missing information** — ask instead of assume
11. **Feature removal requires full cleanup** — delete + down-migration + confirmation
12. **TypeScript everywhere** — strict mode, no `any` types
13. **Multi-app monorepo support** — mobile apps API only, never DB
14. **OSS-first stack** — Valkey, Auth.js, Keycloak, MinIO by default
15. **Agent attribution in every entry** — CLINE/CLAUDE_CODE/COPILOT/HUMAN/UNKNOWN
16. **Visual QA after Phase 6 + major Phase 7** — browser checks via Playwright
17. **Search before reading** — SocratiCode `codebase_search` first, then open files
18. **Typed lessons.md** — 🔴 gotchas + 🟤 decisions read first
19. **SpecStory is passive memory layer** — powers Governance Sync attribution
20. **Private tag support** — `<private>` content never stored or propagated
21. **Design system MASTER.md** — read before UI generation, skip if absent

---

## Phase Flow
```
Phase 0: Bootstrap (Cline)
    ↓
Phase 1: Open devcontainer (YOU)
    ↓
Phase 2: Discovery interview (Claude Code)
    ↓
Phase 2.5: Spec decision summary (Claude Code)
    ↓
Phase 2.6: Design system generation (Cline, optional)
    ↓
Phase 3: Generate spec files (Claude Code)
    ↓
Phase 4: Full monorepo scaffold (Cline — 8 parts, no stops)
    ↓ auto
Phase 5: Validation (Cline)
    ↓ auto
Phase 6: Docker + Visual QA (Cline)
    ↓
Phase 7: Feature Update Loop (Cline)
Phase 8: Iterative buildout (Cline)
```

---

## Quick Commands

```bash
# Start Docker services
bash deploy/compose/start.sh dev up -d

# Development
pnpm dev

# Validation
pnpm tools:validate-inputs
pnpm tools:check-env
pnpm tools:check-product-sync
pnpm typecheck
pnpm test

# Database
pnpm db:migrate
pnpm db:seed
```

---

## Governance Docs
- `docs/PRODUCT.md` — what to build
- `docs/CHANGELOG_AI.md` — what was built
- `docs/DECISIONS_LOG.md` — locked decisions
- `docs/IMPLEMENTATION_MAP.md` — current state
- `.cline/memory/lessons.md` — lessons learned (typed format)
- `.cline/memory/agent-log.md` — agent activity log

