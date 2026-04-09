# /ideate

Interactive idea validation for Claude Code. Stress-tests ideas through 4 phases before any code or design.

**Phases:** Understand → Challenge → Sharpen → Validate

## Install

```bash
git clone <this-repo> ~/Code/ideate
cd ~/Code/ideate
./setup
```

That's it. Start a new Claude Code conversation and type `/ideate`.

## Usage

```
/ideate
```

Then describe your idea. The skill will walk you through structured validation:

1. **Understand** — 5 questions to make the idea concrete
2. **Challenge** — Find the holes, kill it or strengthen it
3. **Sharpen** — One-liner, wedge, anti-vision
4. **Validate** — Experiments to run before writing any code

Sessions are saved to `~/.ideate/sessions/` and can be resumed.

## Uninstall

```bash
rm -rf ~/.claude/skills/ideate
```
