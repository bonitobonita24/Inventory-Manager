# Lessons Memory — Spec-Driven Platform V14
# Entry format: ## YYYY-MM-DD — [ICON] [Title]
# Types: 🔴 gotcha | 🟡 fix | 🟤 decision | ⚖️ trade-off | 🟢 change
# READ ORDER: 🔴 first → 🟤 second → rest by relevance
# ---

## BOOTSTRAP — 🔴 devcontainer (MODE B) WSL2 + Docker Desktop pitfalls
- Type:      🔴 gotcha
- Phase:     Phase 0 Bootstrap / Phase 1 devcontainer open
- Files:     .devcontainer/devcontainer.json, .devcontainer/Dockerfile
- Concepts:  devcontainer, wsl2, docker-desktop, pnpm, corepack, permissions, sudo, shell-server
- Narrative: Multiple real failures on WSL2 + Docker Desktop. All fixes baked into Bootstrap template.
  (1) EACCES symlink: `corepack enable` fails — use `npm install -g pnpm` in onCreateCommand instead.
  (2) Shell server terminated (code 4294967295): single postCreateCommand crashing kills the shell.
      Split into onCreateCommand (pnpm install) + postStartCommand (chmod || true).
  (3) sudo missing: node:20 base image has no sudo — apt-get install -y sudo + sudoers entry required.
  (4) /home/node missing: add RUN mkdir -p /home/node && chown -R node:node /home/node to Dockerfile.
  (5) Docker CLI: use docker.io via apt — curl tar method risks network timeouts during image build.
  (6) docker-outside-of-docker feature: incompatible with WSL2 + Docker Desktop — use socket bind-mount.
  Base image: node:20-bullseye-slim (not alpine, not fat node:20).
# ---
