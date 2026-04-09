#!/usr/bin/env bash
# Smoke test for preflight skills
# Validates structure, required sections, and shared protocol integration
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_DIR/skills"
PASS=0
FAIL=0
ERRORS=""

pass() { PASS=$((PASS + 1)); echo "  ✓ $1"; }
fail() { FAIL=$((FAIL + 1)); ERRORS="$ERRORS\n  ✗ $1"; echo "  ✗ $1"; }

echo "=== Preflight Skill Smoke Tests ==="
echo ""

# --- Test 1: All skill directories exist ---
echo "Skill directories:"
for skill in ideate assumption premortem compare personas scope pivot preflight; do
  if [ -f "$SKILLS_DIR/$skill/SKILL.md" ]; then
    pass "$skill/SKILL.md exists"
  else
    fail "$skill/SKILL.md missing"
  fi
done
echo ""

# --- Test 2: Shared files exist ---
echo "Shared files:"
for shared in VOICE.md PROTOCOL.md; do
  if [ -f "$REPO_DIR/$shared" ]; then
    pass "$shared exists"
  else
    fail "$shared missing"
  fi
done
echo ""

# --- Test 3: Each skill has required sections ---
echo "Required sections:"
for skill in ideate assumption premortem compare personas scope pivot preflight; do
  file="$SKILLS_DIR/$skill/SKILL.md"
  [ ! -f "$file" ] && continue

  # YAML frontmatter
  if head -1 "$file" | grep -q "^---"; then
    pass "$skill: has frontmatter"
  else
    fail "$skill: missing frontmatter"
  fi

  # Bash block
  if grep -q '```bash' "$file"; then
    pass "$skill: has bash block"
  else
    fail "$skill: missing bash block"
  fi

  # Routing section
  if grep -q "Routing" "$file"; then
    pass "$skill: has routing"
  else
    fail "$skill: missing routing section"
  fi

  # What you are NOT (negative constraints)
  if grep -q "What you are NOT\|What you are not" "$file"; then
    pass "$skill: has negative constraints"
  else
    # preflight uses a different pattern
    if grep -q "NOT a replacement\|NOT rigid\|NOT a project manager" "$file"; then
      pass "$skill: has negative constraints"
    else
      fail "$skill: missing negative constraints"
    fi
  fi

  # VOICE/PROTOCOL loading with gate
  if grep -q "VOICE.md" "$file"; then
    pass "$skill: loads VOICE.md"
  else
    fail "$skill: doesn't load VOICE.md"
  fi

  if grep -q "PROTOCOL.md" "$file"; then
    pass "$skill: loads PROTOCOL.md"
  else
    fail "$skill: doesn't load PROTOCOL.md"
  fi

  # SHARED_LOADED gate
  if grep -q "SHARED_LOADED" "$file"; then
    pass "$skill: gates on SHARED_LOADED"
  else
    fail "$skill: missing SHARED_LOADED gate"
  fi

  # Completion protocol
  if grep -q "SESSION COMPLETE" "$file"; then
    pass "$skill: has completion protocol"
  else
    fail "$skill: missing completion protocol"
  fi

  # STOP points
  if grep -q "\\*\\*STOP" "$file"; then
    pass "$skill: has STOP gates"
  else
    fail "$skill: missing STOP gates"
  fi
done
echo ""

# --- Test 4: VOICE.md has required elements ---
echo "VOICE.md quality:"
voice="$REPO_DIR/VOICE.md"
if grep -q "Banned words" "$voice"; then
  pass "has banned words list"
else
  fail "missing banned words"
fi
if grep -q "Banned patterns" "$voice"; then
  pass "has banned patterns"
else
  fail "missing banned patterns"
fi
if grep -q "Energy matching" "$voice"; then
  pass "has energy matching"
else
  fail "missing energy matching"
fi
echo ""

# --- Test 5: PROTOCOL.md has required elements ---
echo "PROTOCOL.md quality:"
proto="$REPO_DIR/PROTOCOL.md"
if grep -q "Completion Protocol" "$proto"; then
  pass "has completion protocol"
else
  fail "missing completion protocol"
fi
if grep -q "Question Protocol" "$proto"; then
  pass "has question protocol"
else
  fail "missing question protocol"
fi
if grep -q "DONE\|BLOCKED\|NEEDS_CONTEXT" "$proto"; then
  pass "has status definitions"
else
  fail "missing status definitions"
fi
if grep -q "Re-ground" "$proto"; then
  pass "has re-grounding rule"
else
  fail "missing re-grounding rule"
fi
if grep -q "AskUserQuestion" "$proto"; then
  pass "has AskUserQuestion guidance"
else
  fail "missing AskUserQuestion guidance"
fi
echo ""

# --- Test 5b: /ideate saves to canonical ideate.md ---
echo "Canonical filename:"
ideate_file="$SKILLS_DIR/ideate/SKILL.md"
if grep -q "SAVE_DIR/ideate.md" "$ideate_file"; then
  pass "/ideate saves to ideate.md (canonical)"
else
  fail "/ideate doesn't save to canonical ideate.md"
fi
echo ""

# --- Test 6: Setup script handles all skills ---
echo "Setup script:"
setup="$REPO_DIR/setup"
for skill in ideate assumption premortem compare personas scope pivot preflight; do
  if grep -q "$skill" "$setup"; then
    pass "setup includes $skill"
  else
    fail "setup missing $skill"
  fi
done
if grep -q "VOICE.md" "$setup"; then
  pass "setup installs VOICE.md"
else
  fail "setup doesn't install VOICE.md"
fi
if grep -q "PROTOCOL.md" "$setup"; then
  pass "setup installs PROTOCOL.md"
else
  fail "setup doesn't install PROTOCOL.md"
fi
echo ""

# --- Test 7: Session save uses SAVE_DIR (not hardcoded paths) ---
echo "State management:"
for skill in ideate assumption premortem compare personas scope pivot preflight; do
  file="$SKILLS_DIR/$skill/SKILL.md"
  [ ! -f "$file" ] && continue

  if grep -q "SAVE_DIR" "$file"; then
    pass "$skill: uses SAVE_DIR"
  else
    fail "$skill: hardcoded save path"
  fi
done
echo ""

# --- Summary ---
echo "=== Results ==="
TOTAL=$((PASS + FAIL))
echo "$PASS / $TOTAL passed"
if [ "$FAIL" -gt 0 ]; then
  echo ""
  echo "Failures:"
  echo -e "$ERRORS"
  exit 1
else
  echo "All tests passed."
  exit 0
fi
