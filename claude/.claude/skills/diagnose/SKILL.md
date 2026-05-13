---
name: diagnose
description: Use when the user pastes a stack trace, exception, or error log and wants to know the cause. Language-agnostic.
---

# Diagnose Error

Find the **root cause** with evidence. Not a plausible patch.

## Workflow

1. **Parse**: exception class, message, top frame, **first frame inside this repo**, what was running.
2. **Find the boundary**: highest frame *not* in `node_modules/`, `gems/`, `site-packages/`, `vendor/`, etc. Bug usually lives at or above this line. If no user-code frame exists, the trigger is input/config, not logic.
3. **Investigate**: read the boundary file → `git log -p -3 <path>` (recent changes are prime suspects) → grep for the same pattern elsewhere → check lockfile for the library named in the trace → see how this repo already handles similar errors and match that pattern.
4. **Hypothesize**: write 2–3 candidate causes. For each: supporting evidence, refuting evidence, diagnostic test. Don't lock onto the first.
5. **Confirm** the leading one against code + history. If evidence doesn't fit, fall back. Don't stop at "seems likely."
6. **Report** in this shape:
   - **Cause**: file:line and quoted code/frame.
   - **Why now**: what input/state/env triggered it.
   - **Fix**: smallest change that addresses the root cause. Match existing conventions in the repo even if you'd write it differently — consistency beats perfection. Concrete paths.
   - **Ruled out**: other hypotheses, briefly.
   - **Verify**: test or command to confirm. Tests assert one behavior, use Given-When-Then comments, and cover happy path plus the failure case.
   - **Confidence**: high/medium/low + reason.

## Watch for

- **Bot/scanner traffic** — malformed input on public endpoints, weird UA/headers, trace entirely in framework code. Fix is silence/block at the edge, not "fix the controller."
- **Dep version drift** — trace lives entirely in a library; check lockfile for a recent bump and the library's issue tracker.
- **Misleading messages** — when frame and message disagree, trust the frame.
- **Missing migration/config** — code expects a column, env var, or flag absent in this environment.
- **Wrong data shape** — recurring nil/None/undefined where a value should always exist means the type or model is wrong, not the call site. Fix the structure, not every reader.

## Don't

- Wrap the throw site in `rescue`/`try` without knowing why it threw.
- Patch the symptom (default a nil) when the value shouldn't be nil there.
- Add abstractions, wrappers, or new error classes the cause doesn't demand.
- Disable or `# noqa` / `eslint-disable` a lint rule to silence noise. Fix the underlying issue.
- Propose a fix without reading the file.
- State a hypothesis as fact. Say "likely" until verified.

## Ask for more if needed

Full log, repro input, lockfile, recent commits, or "intermittent vs. consistent" — whichever would actually change the diagnosis.
