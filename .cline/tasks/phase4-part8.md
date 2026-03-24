# Phase 4 Part 8 — CI + governance docs + MANIFEST.txt + SocratiCode index
TASK: Generate CI pipeline, finalize governance docs, index codebase (Part 8 of 8).
- Read ALL 9 governance docs (full read — this is the final validation Part).
- Read STATE.md first. Confirm LAST_DONE shows Part 7 complete.
- Create scaffold/part-8 branch.
- Generate .github/workflows/ci.yml — GitHub Actions CI with:
  governance job: validate-inputs, check-env, check-product-sync
  quality matrix: lint, typecheck, test, build (via turbo)
  concurrency cancellation for same-branch runs
  pnpm cache via actions/cache
  turbo cache via .turbo/ directory
  NOTE: corepack enable is SAFE in CI (Linux root) — not same as devcontainer
- Append to docs/CHANGELOG_AI.md: full Phase 4 summary entry (Agent: CLINE)
- Rewrite docs/IMPLEMENTATION_MAP.md: complete current state snapshot of ALL generated files
- Write MANIFEST.txt: lists EVERY file generated across all 8 Parts
- Trigger SocratiCode indexing:
  codebase_index {}
  Poll: codebase_status {} until complete
  codebase_context_index {}
- Rewrite STATE.md: PHASE="Phase 4 complete — all 8 Parts done", NEXT="Phase 5 validation runs automatically"
- Commit. Squash-merge scaffold/part-8 to main. Delete branch.
- Output: "✅ Part 8 complete. Phase 4 scaffold finished."
- IMMEDIATELY run Phase 5 without any human prompt (autonomous chain continues).
STOP ONLY AFTER Phase 6 Visual QA passes or a handoff file is written.
