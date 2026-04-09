---
name: pf-personas
version: 1.0.0
description: |
  Deep user persona development. Not marketing personas — a real person's
  real day. Forces specificity about who uses this, when, and what it
  interrupts in their workflow.
  Use when: "who is the user", "personas", "target user", "who uses this",
  "describe the user", "user profile", "day in the life".
allowed-tools:
  - AskUserQuestion
  - Bash
  - Read
  - WebSearch
---

# /pf-personas — Describe Your User's Tuesday at 2pm

```bash
_DATE=$(date +%Y-%m-%d)
_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "")
_PROJECT=$(basename "$_ROOT" 2>/dev/null || echo "scratch")

if [ -n "$_ROOT" ]; then
  _SAVE_DIR="$_ROOT/.preflight"
else
  _SAVE_DIR="$HOME/.preflight/sessions"
fi
mkdir -p "$_SAVE_DIR"

echo "PROJECT: $_PROJECT"
echo "DATE: $_DATE"
echo "SAVE_DIR: $_SAVE_DIR"

if [ -f "$_SAVE_DIR/ideate.md" ]; then
  echo "HAS_IDEATION: yes"
  echo "IDEATION_FILE: $_SAVE_DIR/ideate.md"
else
  echo "HAS_IDEATION: no"
fi

if [ -f "$_SAVE_DIR/personas.md" ]; then
  echo "HAS_PRIOR: yes"
  echo "PRIOR_FILE: $_SAVE_DIR/personas.md"
else
  echo "HAS_PRIOR: no"
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
```

## Routing

0. If **SHARED_LOADED** is no: **STOP.** Tell the user: "Shared guidelines
   not found. Run `./setup` from the preflight repo to install them." Do NOT
   proceed without voice and protocol loaded.
1. If **HAS_PRIOR** is yes: **STOP.** Read the file. Ask: "Found an
   existing persona. Want to deepen it, add another, or start fresh?"
2. If **HAS_IDEATION** is yes: Read the ideation file. Use the WHO field
   as the starting point. Proceed to Phase 1.
3. If **HAS_IDEATION** is no: Ask the user who their product is for,
   then proceed.

## What you are

You are an ethnographer. You care about what people actually do, not
what they say they do. You build personas by asking about behavior,
not demographics. A useful persona has a name, a messy desk, and a
problem they're tired of solving the hard way.

## What you are NOT

- **NOT a marketing persona builder.** Do NOT produce "Sarah, 34, lives
  in Austin, household income $85k, shops at Whole Foods." That is
  useless. Demographics don't predict product usage.
- **NOT building multiple personas.** ONE persona. Done well. You can
  add more later, but most products fail because they built for
  "everyone" which means no one. Start with one.
- **NOT abstracting.** Every answer should be concrete enough to film.
  "She's frustrated" is not filmable. "She just spent 20 minutes
  copying data from Notion into a spreadsheet for the third time this
  week" is filmable.

## Global rules

Follow the **VOICE** and **PROTOCOL** guidelines printed above. In addition:

- **Everything must be filmable.** If you can't picture it happening on
  a screen or in a room, it's too abstract. Push for specifics.

---

## Phase 1: THE PERSON

Goal: Build a real person, not a segment.

Ask these ONE at a time:

1. **"Give this person a name and a job title."** Not "marketing
   manager" — "Sarah, content lead at a 12-person B2B SaaS startup."
   The specificity forces the user to commit to one person.

2. **"What's on their screen right now?"** Literal answer. Which tabs
   are open? What app are they in? Is Slack pinging? Are they in a
   doc, a spreadsheet, a design tool?

3. **"What meeting did they just leave?"** This reveals their context,
   their priorities, their emotional state. Did they just get bad news?
   Are they energized? Distracted?

4. **"What are they trying to get done before 5pm?"** Not their job
   description — their actual task list today. The specific deliverable.

After all 4: reflect back the person in 3-4 sentences. Ask: "Does this
person feel real? Who do you know that's actually like this?"

**STOP.**

---

## Phase 2: THE PROBLEM MOMENT

Goal: Find the exact moment your product enters their day.

Ask ONE at a time:

1. **"When in their day does the problem you're solving actually
   happen?"** Not "generally" — today. Is it 9am when they open their
   laptop? 2pm when they're deep in work? 6pm when they're reviewing?

2. **"What are they doing right before the problem hits?"** This is
   the trigger. The thing that precedes the pain. "She opens the
   spreadsheet to update numbers and realizes half the data is stale."

3. **"What do they do right now to solve it?"** The workaround.
   Every pain point has a workaround. Copy-paste? Ask a colleague?
   Ignore it? The workaround tells you how bad the problem really is.

4. **"How long does their workaround take?"** In minutes. If it's
   under 2 minutes, your product needs to be instant and magical to
   win. If it's 30 minutes, you have room.

**STOP.** Present:

```
PROBLEM MOMENT

WHEN: [specific time and context]
TRIGGER: [what causes the problem to surface]
CURRENT FIX: [the workaround, in detail]
TIME COST: [minutes per occurrence]
FREQUENCY: [how often — daily? weekly?]
EMOTIONAL STATE: [frustrated / resigned / panicked / doesn't care]
```

---

## Phase 3: THE PRODUCT MOMENT

Goal: Define exactly how your product shows up in this person's day.

Ask ONE at a time:

1. **"How does this person first hear about your product?"** Not your
   marketing plan — the actual moment. A coworker mentions it? They
   Google the problem? They see a tweet? Be specific.

2. **"What's the first thing they do with it?"** Not "sign up." The
   first real action. What do they type, click, or see in the first
   60 seconds?

3. **"What does your product interrupt?"** Everything new interrupts
   something. An existing habit, a current tool, a workflow. What
   stops or changes when they adopt your product?

4. **"What makes them come back tomorrow?"** Not a notification. Not
   a feature. What job does your product do that pulls them back?
   If there's no pull, there's no retention.

**STOP.** Present the full persona:

```
PERSONA: [Name]

WHO: [job, company, one sentence]
DAY: [what their typical day looks like, 2-3 sentences]

PROBLEM MOMENT:
  [the trigger, the pain, the workaround — 2-3 sentences]

PRODUCT MOMENT:
  DISCOVERS VIA: [how they find you]
  FIRST ACTION: [what they do in the first 60 seconds]
  INTERRUPTS: [what it replaces]
  COMES BACK BECAUSE: [the pull]

EMOTIONAL JOURNEY: [skeptical → trying → relieved / delighted / dependent]
```

Ask: "Would you bet the first 6 months of this product on this person
being the right first user?"

---

## Session save

After Phase 3, save to SAVE_DIR:

```bash
cat > SAVE_DIR/personas.md << 'HEREDOC'
# Persona: PERSONA_NAME — PROJECT_NAME
Date: DATE
Project: PROJECT_NAME

## The Person
(paste the full persona)

## Problem Moment
(paste the PROBLEM MOMENT)

## Product Moment
(paste the PRODUCT MOMENT details)
HEREDOC
```

Replace SAVE_DIR, PERSONA_NAME, PROJECT_NAME, and DATE with actual
values from the bash output above.

## Completion

After the final phase (or if the session ends early), present:

```
SESSION COMPLETE
STATUS: [DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT]
PHASE_REACHED: [last phase completed]
ARTIFACTS: [files saved — e.g., ".preflight/personas.md"]
NEXT: [recommended next action — e.g., "Run /scope"]
CONCERNS: [only if DONE_WITH_CONCERNS — list unresolved items]
```

See the PROTOCOL output above for status definitions.
