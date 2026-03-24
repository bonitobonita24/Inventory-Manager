# Phase 4 Part 6 — apps/[mobile app] Expo full scaffold
# ⚠️ SKIP THIS PART ENTIRELY if no mobile app is declared in inputs.yml.
TASK: Generate the Expo mobile application if declared (Part 6 of 8).
- Read STATE.md first. Confirm LAST_DONE shows Part 5 complete.
- Read inputs.yml — check if a mobile app is declared in the apps list.
  IF NO MOBILE APP DECLARED: rewrite STATE.md with PHASE="Phase 4 Part 6 skipped (no mobile)", NEXT="Start Part 7 in new session". Output "✅ Part 6 skipped — no mobile app declared. Open phase4-part7.md in a NEW Cline session." STOP HERE.
- Create scaffold/part-6 branch.
- Generate if mobile app declared:
  app.json / app.config.ts — Expo config
  eas.json — EAS Build config for App Store + Play Store
  src/env.ts — typed env vars for mobile
  src/components/ui/ — React Native Reusables + NativeWind setup
  src/app/ — Expo Router screens for every mobile workflow in spec
  src/api/ — uses packages/api-client/ ONLY (NEVER packages/db — Rule 13)
  src/storage/ — WatermelonDB / AsyncStorage / MMKV for local persistence
  src/sync/ — offline queue + sync logic (only if offline-first declared)
  src/notifications/ — Expo Push / FCM+APNs notification setup (only if declared)
- Run: pnpm typecheck for this Part. Fix all errors.
- Rewrite STATE.md. Commit. Squash-merge. Delete branch.
- Output: "✅ Part 6 complete. Open phase4-part7.md in a NEW Cline session."
STOP HERE.
