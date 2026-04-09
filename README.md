# ideate

Idea validation toolkit for Claude Code. Eight skills that force deep thinking before any code gets written.

## The Cycle

```
/assumption → /ideate → /premortem → /compare → /personas → /scope
                                                                 ↓
                         (if the idea dies) → /pivot → restart cycle
```

Run `/ideate-start` for the full guided cycle, or use any skill standalone.

## Skills

| Skill | What it does |
|-------|-------------|
| `/ideate-start` | Full cycle orchestrator — tracks progress across all phases |
| `/assumption` | Surfaces hidden assumptions, ranks by criticality × uncertainty |
| `/ideate` | Core idea validation — understand, challenge, sharpen, validate |
| `/premortem` | Imagines the failure and works backward to prevent it |
| `/compare` | Competitive research — finds what exists, assesses real differentiation |
| `/personas` | Builds one deep user persona — their day, their problem moment, their workflow |
| `/scope` | Strips the idea to the absolute minimum buildable in days |
| `/pivot` | Extracts learnings from dead ideas and rotates into new directions |

## Install

```bash
git clone <this-repo> ~/Code/ideate
cd ~/Code/ideate
./setup
```

## Usage

**Full cycle** (recommended for new ideas):
```
/ideate-start
```

**Standalone** (for specific needs):
```
/assumption     # "What am I assuming?"
/ideate         # "Is this idea worth building?"
/premortem      # "How could this fail?"
/compare        # "Who else does this?"
/personas       # "Who exactly is this for?"
/scope          # "What's the smallest v1?"
/pivot          # "The idea died — now what?"
```

All skills save their output to `.ideate/` in your project root (or `~/.ideate/sessions/` if no git repo). Each skill reads context from prior skills, so they build on each other.

## Uninstall

```bash
# Remove all skills
for s in ideate assumption premortem compare personas scope pivot ideate-start; do
  rm -rf ~/.claude/skills/$s
done
```
