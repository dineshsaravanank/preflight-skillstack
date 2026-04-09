# Shared Protocols — All Ideate Skills

These protocols are referenced by every skill. Do not deviate.

---

## Completion Protocol

Every skill session MUST end with a completion block. No exceptions.
Present this after the final STOP point of the skill, once the user
has responded and the session is wrapping up.

```
SESSION COMPLETE
STATUS: [DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT]
PHASE_REACHED: [last phase completed — e.g., "Phase 3: SHARPEN"]
ARTIFACTS: [files saved — e.g., ".ideate/ideate.md"]
NEXT: [recommended next action — e.g., "Run /premortem"]
CONCERNS: [only if STATUS is DONE_WITH_CONCERNS — list unresolved items]
```

**Status definitions:**

- **DONE** — All phases completed, outputs saved. Clean exit.
- **DONE_WITH_CONCERNS** — Completed but with unresolved weak spots,
  kill signals, or risks the user acknowledged but didn't resolve.
  List each concern.
- **BLOCKED** — Cannot continue. Missing information, contradictory
  answers, or the user needs to do something outside this tool
  (e.g., talk to users, run an experiment).
- **NEEDS_CONTEXT** — The skill needs input from another skill that
  hasn't been run yet (e.g., /scope needs /ideate output).

This block lets `/ideate-start` detect what happened and route correctly.

---

## Question Protocol

Every question you ask MUST follow this format. This applies to phase
questions, STOP-point questions, and any clarifying question.

**Format:**

1. **Re-ground** (one sentence) — Where are we? What's the idea? What
   phase are we in? Assume the user hasn't looked at this in 20 minutes.
2. **The question** (one question only) — Plain language. No jargon.
   Specific enough that the user knows exactly what you're asking.
3. **Options** (only if applicable) — Label with A, B, C. Include what
   each option means concretely. If one option is clearly better, say so.

**Example — mid-phase question:**

> We're stress-testing your idea for an AI meeting summarizer (Phase 2:
> Challenge).
>
> Who else has tried to solve this? I can think of Otter.ai and
> Fireflies — what do you think you'd do differently that would make
> someone switch?

**Example — STOP-point question with options:**

> Your idea snapshot for the AI meeting summarizer is ready (Phase 1
> complete).
>
> Does this capture it, or is something off?
>
> A) Looks right — move to challenges
> B) Something's wrong — let me correct it
> C) I want to rethink the whole thing

**When to use AskUserQuestion vs. inline questions:**

- **Use AskUserQuestion** when the answer determines which path the skill
  takes next — branching decisions like "continue or pivot?", "which phase
  to revisit?", mode selection. These are structural choices.
- **Use inline questions** for everything else — phase questions, follow-ups,
  clarifications, confirmations. Most questions in a session are inline.

**Anti-patterns — never do these:**

- Asking 2+ questions in one response
- Asking without re-grounding first
- Offering options without a recommendation when you have one
- Using AskUserQuestion for simple yes/no — just ask inline
- Using inline questions for branching decisions — use AskUserQuestion
