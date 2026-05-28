Bump the `ansible-common` git submodule in this repo to the latest upstream `main`, understand what changed, and update this repo to accommodate those changes.

Work through the steps below in order. Do not skip ahead. Report what you find at each step before moving on.

## 1. Locate the submodule and capture the current state

- Run `git submodule status` to find the `ansible-common` submodule. Note its path and current pinned SHA (call it `OLD_SHA`).
- If the submodule is missing or not initialized, run `git submodule update --init --recursive` first.
- `cd` into the submodule directory.

## 2. Fetch upstream and inspect the incoming changes

- `git fetch origin` inside the submodule.
- Capture the new tip: `NEW_SHA = git rev-parse origin/main`.
- If `OLD_SHA == NEW_SHA`, there is nothing to bump — stop and report that.
- List every incoming commit with `git log --no-merges --oneline OLD_SHA..NEW_SHA`.
- For each commit, read it properly with `git show --stat <sha>` and, for anything non-trivial, `git show <sha>` to see the diff. Do not rely on the commit subject alone — commit messages lie or omit detail.
- Produce a per-commit summary grouped by the role(s) it touches (the top-level directory under `roles/`). Note any commits that touch shared/global files.

## 3. Map current usage in the parent repo

- `cd` back to the parent repo root.
- Find every place the parent repo consumes `ansible-common`. Search for:
  - `import_role`, `include_role`, `roles:` entries, and `ansible.builtin.import_role` / `include_role` references whose `name:` points at an `ansible-common` role (e.g. `name: ansible-common/roles/<role>` or any role under the submodule path).
  - Direct `include_tasks` / `import_tasks` paths that point inside the submodule.
  - `requirements.yml` / `collections/requirements.yml` references.
  - Anything in `group_vars` / `host_vars` / inventories that sets variables consumed by an `ansible-common` role (match against the `defaults/main.yml` keys of the roles in use).
- Build a table: parent-repo file → which `ansible-common` role(s) it uses → which variables it passes.

## 4. Identify breaking changes and required updates

Cross-reference step 2 against step 3. For each incoming change, classify it:

- **Breaking — must update**: removed role, renamed role, renamed/removed variable that the parent repo passes, changed default that flips behavior, new required variable with no safe default, changed task name that a parent handler/notify references.
- **Behavioral — likely safe but verify**: changed default value, new tasks added to an existing role, tightened validation.
- **Irrelevant**: changes to roles or files the parent repo does not consume.

For each Breaking and Behavioral item, cite:

- The upstream commit SHA and one-line summary.
- The exact parent-repo file(s) and line(s) that need to change (or be verified).
- What the change should look like.

## 5. Make the update

- Update the submodule pointer: from the parent repo root, `git -C <submodule-path> checkout <NEW_SHA>` and `git add <submodule-path>`.
- Apply every Breaking and Behavioral edit identified in step 4.
- Follow the parent repo's own conventions for verification.
- Fix anything that breaks; do not paper over failures.

## Rules

- Do not bump the submodule pointer before you have read the incoming commits. Blind bumps are how breakage gets in.
- Do not edit anything inside the submodule directory itself — it is a pinned dependency, not your code to change.
- If you discover an upstream change is actively broken or a bad fit for this repo, stop and ask the user before working around it.
- Keep the changes scoped to the bump. No drive-by refactors.
