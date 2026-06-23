#!/usr/bin/env bash
# Update GitHub stats in resume.tex
set -euo pipefail

GH_USER="abhay-byte"
REPO_DIR="/home/jica98/repos/my-resume"
RESUME="$REPO_DIR/resume.tex"
cd "$REPO_DIR"

# --- Fetch profile data ---
PROFILE=$(curl -sf "https://api.github.com/users/$GH_USER")
FOLLOWERS=$(echo "$PROFILE" | jq -r '.followers')
PUBLIC_REPOS=$(echo "$PROFILE" | jq -r '.public_repos')

# --- Fetch total commits ---
TOTAL_COMMITS=$(curl -sf "https://api.github.com/search/commits?q=author:$GH_USER&per_page=1" \
  -H "Accept: application/vnd.github.cloak-preview" | jq '.total_count')

# --- Fetch total stars (sum across all repos) ---
TOTAL_STARS=$(curl -sf "https://api.github.com/users/$GH_USER/repos?per_page=100" | \
  jq '[.[] | .stargazers_count] | add')

# --- Fetch individual project stars ---
FLUX_STARS=$(curl -sf "https://api.github.com/repos/$GH_USER/fluxlinux" | jq -r '.stargazers_count')
FB_STARS=$(curl -sf "https://api.github.com/repos/$GH_USER/finalbenchmark-platform" | jq -r '.stargazers_count')
MKM_STARS=$(curl -sf "https://api.github.com/repos/$GH_USER/mkm" | jq -r '.stargazers_count')
NEXUS_STARS=$(curl -sf "https://api.github.com/repos/$GH_USER/nexus" | jq -r '.stargazers_count')

# --- Format commit count ---
COMMITS_K=$(awk "BEGIN { printf \"%.1f\", $TOTAL_COMMITS / 1000 }")
COMMITS_DISPLAY="${COMMITS_K}K+"

echo "=== Live Stats ==="
echo "Commits: $TOTAL_COMMITS → $COMMITS_DISPLAY"
echo "Stars: $TOTAL_STARS"
echo "Repos: $PUBLIC_REPOS"
echo "Followers: $FOLLOWERS"
echo "Fluxlinux: $FLUX_STARS"
echo "Finalbenchmark-platform: $FB_STARS"
echo "MKM: $MKM_STARS"
echo "Nexus: $NEXUS_STARS"

# --- Update resume.tex ---

# 1. GitHub Stats line in Achievements
# Match line containing "GitHub Stats:" and replace the entire line
sed -i "/GitHub Stats:/c\  \\\\resumeItem{\\\\textbf{GitHub Stats:} \\\\textbf{${COMMITS_DISPLAY} Commits}, \\\\textbf{${TOTAL_STARS}+ Stars}, \\\\textbf{${PUBLIC_REPOS} Public Repositories}, \\\\textbf{${FOLLOWERS} Followers}. \\\\href{https://github.com/abhay-byte}{GitHub}}" "$RESUME"

# 2. Fluxlinux stars
sed -i "/fluxlinux/{s/Stars~[0-9]\+/Stars~${FLUX_STARS}/;}" "$RESUME"
# 3. Finalbenchmark-platform stars
sed -i "/finalbenchmark-platform/{s/Stars~[0-9]\+/Stars~${FB_STARS}/;}" "$RESUME"
# 4. MKM stars
sed -i "/MKM (Minimal/{s/Stars~[0-9]\+/Stars~${MKM_STARS}/;}" "$RESUME"
# 5. Nexus stars
sed -i "/Nexus}}/{s/Stars~[0-9]\+/Stars~${NEXUS_STARS}/;}" "$RESUME"

echo ""
echo "=== Updated resume.tex ==="
grep -n "GitHub Stats:" "$RESUME"
grep -n "Stars~" "$RESUME"

# --- Commit and push if changed ---
if ! git diff --quiet "$RESUME"; then
  git add "$RESUME"
  git commit -m "chore(resume): refresh GitHub stats and stars

- GitHub: ${COMMITS_DISPLAY} commits, ${TOTAL_STARS}+ stars, ${PUBLIC_REPOS} repos, ${FOLLOWERS} followers
- fluxlinux ${FLUX_STARS}+, finalbenchmark-platform ${FB_STARS}+, mkm ${MKM_STARS}+, nexus ${NEXUS_STARS}+"
  git push origin main
  echo "✅ Pushed update"
else
  echo "✅ No changes needed"
fi
