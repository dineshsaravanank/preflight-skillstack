# preflight

Pre-flight checks for ideas. Nine skills that force deep thinking before any code gets written.

## The Cycle

```
/pf-assumption → /pf-ideate → /pf-premortem → /pf-compare → /pf-personas → /pf-scope
                                                                 ↓
                         (if the idea dies) → /pf-pivot → restart cycle
```

Run `/preflight` for the full guided cycle, or use any skill standalone.

## Skills

| Skill | What it does |
|-------|-------------|
| `/preflight` | Full cycle orchestrator — tracks progress across all phases |
| `/pf-assumption` | Surfaces hidden assumptions, ranks by criticality × uncertainty |
| `/pf-ideate` | Core idea validation — understand, challenge, sharpen, validate |
| `/pf-premortem` | Imagines the failure and works backward to prevent it |
| `/pf-compare` | Competitive research — finds what exists, assesses real differentiation |
| `/pf-personas` | Builds one deep user persona — their day, their problem moment, their workflow |
| `/pf-scope` | Strips the idea to the absolute minimum buildable in days |
| `/pf-pivot` | Extracts learnings from dead ideas and rotates into new directions |
| `/pf-discover` | Mines repo docs, TODOs, and issues to surface latent ideas |

## Install

```bash
git clone <this-repo> ~/Code/preflight
cd ~/Code/preflight
./setup
```

## Usage

**Full cycle** (recommended for new ideas):
```
/preflight
```

**Standalone** (for specific needs):
```
/pf-assumption     # "What am I assuming?"
/pf-ideate         # "Is this idea worth building?"
/pf-premortem      # "How could this fail?"
/pf-compare        # "Who else does this?"
/pf-personas       # "Who exactly is this for?"
/pf-scope          # "What's the smallest v1?"
/pf-pivot          # "The idea died — now what?"
/pf-discover       # "What ideas are hiding in this repo?"
```

All skills save their output to `.preflight/` in your project root (or `~/.preflight/sessions/` if no git repo). Each skill reads context from prior skills, so they build on each other.

## Uninstall

```bash
# Remove all skills
for s in pf-ideate pf-assumption pf-premortem pf-compare pf-personas pf-scope pf-pivot preflight pf-discover; do
  rm -rf ~/.claude/skills/$s
done
```
