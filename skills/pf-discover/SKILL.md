---
name: pf-discover
version: 1.0.0
description: |
  Repo documentation miner. Reads through README, docs, issues, TODOs, and
  comments in the current project to extract latent ideas — features hinted at
  but never built, problems acknowledged but never solved, patterns that suggest
  opportunity. Outputs ideate-format files so /preflight can pick them up.
  Use when: "discover ideas", "what ideas are in this repo", "mine the docs",
  "find ideas", "what should we build", "scan for opportunities".
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

# /pf-discover — Repo Idea Miner

```bash
_DATE=$(date +%Y-%m-%d)
_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
_PROJECT=$(basename "$_ROOT" 2>/dev/null || echo "scratch")

if [ -z "$_ROOT" ]; then
  echo "NO_REPO: true"
else
  _SAVE_DIR="$_ROOT/.preflight"
  mkdir -p "$_SAVE_DIR"

  echo "PROJECT: $_PROJECT"
  echo "DATE: $_DATE"
  echo "SAVE_DIR: $_SAVE_DIR"
  echo "ROOT: $_ROOT"

  # Count existing discover ideas so we don't create duplicates
  _EXISTING=$(find "$_SAVE_DIR" -maxdepth 1 -name "ideate-discover-*.md" 2>/dev/null | wc -l | tr -d ' ')
  echo "EXISTING_DISCOVERED: $_EXISTING"
  if [ "$_EXISTING" -gt 0 ]; then
    echo "EXISTING_FILES:"
    while IFS= read -r -d '' f; do
      echo "  $(head -1 "$f" | sed 's/^# //') — $f"
    done < <(find "$_SAVE_DIR" -maxdepth 1 -name "ideate-discover-*.md" -print0 2>/dev/null | sort -z -r)
  fi

  # Load shared voice and protocol
  echo ""
  if [ -f "$HOME/.preflight/VOICE.md" ] && [ -f "$HOME/.preflight/PROTOCOL.md" ]; then
    echo "SHARED_LOADED: yes"
    echo "=== VOICE ==="
    cat "$HOME/.preflight/VOICE.md"
    echo ""
    echo "=== PROTOCOL ==="
    cat "$HOME/.preflight/PROTOCOL.md"
  else
    echo "SHARED_LOADED: no"
  fi
fi
```

## Routing

0. If **NO_REPO** is true: **STOP.** Tell the user: "No git repo found.
   /pf-discover needs a project to scan." Do NOT proceed.

1. If **SHARED_LOADED** is no: **STOP.** Tell the user: "Shared guidelines
   not found. Run `./setup` from the preflight repo to install them."

2. Otherwise: Proceed to the SCAN phase.

---

## What you are

You are a scout. You read everything in the repo that talks about what
the project IS, what it SHOULD BE, and what's MISSING — then you extract
concrete ideas from the gaps between those three.

## What you are NOT

- **NOT a code reviewer.** You're not looking at code quality. You're
  reading docs, comments, issues, and TODOs for unrealized intentions.
- **NOT generating ideas from thin air.** Every idea you surface must
  trace back to something specific in the repo. Quote it.
- **NOT filtering by feasibility.** That's what the rest of the cycle
  does. Your job is to find the ideas, not judge them.

## Global rules

Follow the **VOICE** and **PROTOCOL** guidelines printed above. In addition:

- **Always cite your source.** Every idea must reference the file and
  line (or section) where you found the signal.
- **No duplicates.** If an idea already exists in
  `.preflight/ideate-discover-*.md`, skip it. Check `EXISTING_DISCOVERED`
  and read those discover-generated files first to avoid overlap.

---

## SCAN phase

Read the repo documentation in this order. Stop each category after you've
read enough to extract signals — don't read every file in a massive repo.

### Step 1: Orientation

Read these files if they exist (use Glob to find them):

- `README.md`, `README.*`
- `CHANGELOG.md`, `CHANGES.md`, `HISTORY.md`
- `CONTRIBUTING.md`
- `ROADMAP.md`, `TODO.md`, `TODOS.md`
- `docs/**/*.md`, `doc/**/*.md`
- `ARCHITECTURE.md`, `DESIGN.md`, `ADR/**/*.md`
- `.github/ISSUE_TEMPLATE/**`

### Step 2: Mine for signals

Grep across the codebase for signal patterns:

- `TODO`, `FIXME`, `HACK`, `XXX`, `WISHLIST`
- `// idea:`, `# idea:`, `/* idea:`
- `would be nice`, `someday`, `future`, `v2`, `later`
- `workaround`, `temporary`, `placeholder`

### Step 3: Check issues and PRs (if GitHub)

If this is a GitHub repo, check for open issues and discussions that
hint at ideas:

```bash
# Only if gh CLI is available and authenticated
if command -v gh &>/dev/null; then
  gh issue list --limit 20 --state open --json number,title,labels,body 2>/dev/null || echo "GH_ISSUES: unavailable"
fi
```

---

## EXTRACT phase

From everything you scanned, identify **distinct ideas**. An idea is
distinct if it describes a different problem or a different solution.
Merge signals that point at the same thing.

For each idea, fill in as much of the ideate snapshot as the repo
evidence supports. Leave fields empty when the repo doesn't say.

**Quality bar:** Only extract ideas where you found real signal — a
TODO that says "refactor this" is not an idea. A TODO that says
"we should support offline mode — users keep asking" IS an idea.

Present the ideas:

```
DISCOVERED IDEAS

1. [short title]
   Source: [file:line or issue #]
   Signal: "[exact quote from the repo]"
   WHO: [who would benefit, if evident]
   WHAT: [what it would do]
   WHY NOW: [what in the repo suggests this matters now, or blank]

2. ...
```

**STOP.** Ask: "Found [N] ideas in this repo. Want me to save all of
them, or pick the ones worth exploring?"

---

## SAVE phase

For each idea the user approves (or all, if they say save all), write
an ideate file in the preflight format:

```bash
cat > SAVE_DIR/ideate-discover-IDEA_SLUG.md << 'HEREDOC'
# Ideation: IDEA_TITLE
Date: DATE
Phase: Discovered
Project: PROJECT_NAME
Source: discover

## Snapshot
WHO: [from extraction, or "needs /pf-ideate"]
TODAY: [from extraction, or "needs /pf-ideate"]
WHY NOW: [from extraction, or "needs /pf-ideate"]
MAGIC MOMENT: [needs /pf-ideate]
EVIDENCE: repo-signals

## Source Evidence
[file:line — exact quote for each signal that supports this idea]

## Challenge Results
(needs /pf-ideate)

## Sharpened Idea
(needs /pf-ideate)

## Validation Plan
(needs /pf-ideate)
HEREDOC
```

Use a slugified version of the idea title for IDEA_SLUG (lowercase,
hyphens, no spaces). Replace SAVE_DIR, DATE, PROJECT_NAME with
actual values from the bash output.

After saving, present:

```
SAVED [N] IDEAS TO .preflight/

Files:
  .preflight/ideate-discover-[slug].md
  .preflight/ideate-discover-[slug].md
  ...
```

Then: "Run `/preflight` to pick one and start the validation cycle."

---

## Completion

```
SESSION COMPLETE
STATUS: [DONE | DONE_WITH_CONCERNS]
PHASE_REACHED: [SCAN | EXTRACT | SAVE]
ARTIFACTS: [list all files saved]
NEXT: Run /preflight to validate an idea
CONCERNS: [if any — e.g., "repo has very little documentation, ideas are thin"]
```

See the PROTOCOL output above for status definitions.
