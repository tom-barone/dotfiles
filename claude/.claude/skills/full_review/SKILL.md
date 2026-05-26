Do a thorough code review of this codebase. I want a real review, not a summary.

Scope: Review all source code.

Look specifically for:

- Correctness bugs and logic errors
- Security issues (injection, auth gaps, secrets in code, unsafe deserialization)
- Race conditions and unsafe concurrency
- Error handling: swallowed errors, missing edge cases, bad failure modes
- Resource leaks (connections, file handles, goroutines/promises)
- Performance problems: N+1 queries, unnecessary allocations, hot-path issues
- API/contract issues: breaking changes, inconsistent interfaces
- Dead code, duplication, and unclear abstractions
- Test coverage gaps — especially untested edge cases and error paths

For each finding report:

1. Severity (Critical / High / Medium / Low)
2. File and line reference
3. What's wrong and why it matters
4. A concrete suggested fix

Rules:

- Don't fix anything yet — review only.
- Be specific and cite actual code. No generic advice.
- If something is fine, don't pad the report with it.
- If you're unsure whether something is a bug, flag it as a question.
- Group findings by severity, Critical first.

Start by mapping the architecture so you have context, then go file by file.

Write your review in a markdown file `REVIEW.md`
