# Phase 4 Part 5 — apps/[web app] Next.js full scaffold
TASK: Generate the primary Next.js web application (Part 5 of 8).
- Read STATE.md first. Confirm LAST_DONE shows Part 4 complete.
- Read inputs.yml (apps list, tenancy mode, auth provider). Read DECISIONS_LOG.md.
- Read .cline/memory/lessons.md (ALL 🔴 gotchas first).
- Read design-system/MASTER.md if it exists (Rule 21) — before generating any UI.
- Create scaffold/part-5 branch.
- Generate for each web app in inputs.yml apps list:
  tsconfig.json extending ../../tsconfig.base.json
  src/env.ts — ALL env vars typed and validated at startup (Zod)
  src/app/ — App Router layout, pages for every module in spec
  src/app/api/trpc/[trpc]/route.ts — tRPC API handler
  src/server/trpc/ — tRPC routers for every entity/module
  src/server/auth/ — Auth.js / Keycloak / chosen auth provider config
  src/middleware.ts — tenant resolution from URL path or subdomain, auth guard
  src/components/ — page-level components per module (follow MASTER.md if present)
  next.config.ts — typed Next.js config
  Always generate: RBAC middleware (L3), tRPC context with roles
  If tenancy.mode=multi: add tenantId to context + tenant guard middleware
- Run: pnpm typecheck for this Part. Fix all errors.
- Rewrite STATE.md. Commit. Squash-merge. Delete branch.
- Output: "✅ Part 5 complete. Open phase4-part6.md in a NEW Cline session."
STOP HERE.
