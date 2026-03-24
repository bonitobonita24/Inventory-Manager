# Phase 4 Part 7 — tools/ + deploy/compose/ + K8s scaffold + SocratiCode artifacts
TASK: Generate infrastructure, tooling, and deployment config (Part 7 of 8).
- Read STATE.md first. Confirm LAST_DONE shows Part 6 complete (or skipped).
- Read inputs.yml (all ports, all service toggles, tenancy mode). Read DECISIONS_LOG.md.
- Read .cline/memory/lessons.md (ALL 🔴 gotchas first).
- Create scaffold/part-7 branch.
- Generate tools/:
  tools/validate-inputs.mjs — validates inputs.yml against inputs.schema.json
  tools/check-env.mjs — checks all required env vars are present
  tools/check-product-sync.mjs — validates no private-tag content leaked into governance docs
  tools/hydration-lint.mjs — Next.js hydration issue detection
- Generate deploy/compose/{dev,stage,prod}/:
  docker-compose.db.yml — PostgreSQL + PgBouncer + shared network creation
  docker-compose.cache.yml — Valkey (references external network)
  docker-compose.storage.yml — MinIO (references external network)
  docker-compose.infra.yml — MailHog (dev only)
  docker-compose.app.yml — Next.js app + worker
  All services use container_name: ${COMPOSE_PROJECT_NAME}_[service]
  All stateful services declare named volumes: ${APP_SLUG}_${ENV}_[service]_data
  Dev uses non-standard ports from inputs.yml; staging/prod use standard ports.
- Generate deploy/compose/start.sh — one-command startup script
- Generate deploy/k8s-scaffold/ — inactive placeholder with README (K8s disabled by default)
- Write .socraticodecontextartifacts.json — MERGE if file exists (preserve design-system entry if present):
  Add entries: database-schema, implementation-map, decisions-log, product-definition
- Run: pnpm lint + pnpm typecheck for tools/ files. Fix all errors.
- Rewrite STATE.md. Commit. Squash-merge. Delete branch.
- Output: "✅ Part 7 complete. Open phase4-part8.md in a NEW Cline session."
STOP HERE.
