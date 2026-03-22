# Phase 4 Autorun Task

## Trigger
This file triggers Phase 4 to run automatically after Bootstrap completes.

## Instructions
When Cline reads this task file, it should:
1. Read all 9 context documents (lessons.md first per Rule 4)
2. Run Phase 4 full monorepo scaffold without stopping
3. Parts 1-8 run sequentially
4. Auto-run Phase 5 validation after Part 8
5. Auto-run Phase 6 Docker + Visual QA after Phase 5

## Context Documents (in order)
1. `.cline/memory/lessons.md` — READ FIRST, Rule 18 priority: 🔴 → 🟤 → rest
2. `docs/PRODUCT.md`
3. `inputs.yml`
4. `inputs.schema.json`
5. `docs/CHANGELOG_AI.md`
6. `docs/DECISIONS_LOG.md`
7. `docs/IMPLEMENTATION_MAP.md`
8. `project.memory.md`
9. `.cline/memory/agent-log.md`

## SocratiCode (Rule 17)
Use `codebase_search` before opening any files during implementation.
Run `codebase_index` after Phase 4 completes.

## Skip Conditions
- If docs/PRODUCT.md does not exist: Skip to Phase 2
- If inputs.yml does not exist: Skip Phase 4, prompt user to complete Phase 2-3 first
