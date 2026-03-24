# Phase 4 Part 4 — packages/ui + packages/jobs + packages/storage
TASK: Generate UI package, jobs queue, and storage wrapper (Part 4 of 8).
- Read STATE.md first. Confirm LAST_DONE shows Part 3 complete.
- Read inputs.yml (jobs.enabled, storage.enabled flags). Read .cline/memory/lessons.md.
- Read DECISIONS_LOG.md for any locked UI/jobs/storage decisions.
- Create scaffold/part-4 branch.
- Generate:
  packages/ui/ — shadcn/ui + Tailwind + Radix UI setup; React Native Reusables + NativeWind if mobile declared.
  packages/jobs/ — ONLY if jobs.enabled: Valkey + BullMQ typed queues, workers, DLQ.
  packages/storage/ — ONLY if storage.enabled: typed MinIO/S3/R2 wrapper.
- Run: pnpm typecheck for this Part. Fix all errors.
- Rewrite STATE.md. Commit. Squash-merge. Delete branch.
- Output: "✅ Part 4 complete. Open phase4-part5.md in a NEW Cline session."
STOP HERE.
