#!/bin/sh
# Instala no projeto atual as skills do kit e as de terceiros listadas em skills-lock.json.
#
#   curl -fsSL https://raw.githubusercontent.com/ThiagoMarzari/skills/main/install.sh | sh
#   curl -fsSL https://raw.githubusercontent.com/ThiagoMarzari/skills/main/install.sh | sh -s -- -g
#
# Flags são repassadas ao `npx skills add` (ex.: -g para instalar global, -a claude-code).
# SKILLS_LOCK=<arquivo> usa um lock local em vez do publicado na main.
set -eu

REPO="ThiagoMarzari/skills"

if [ -n "${SKILLS_LOCK:-}" ]; then
  lock="$SKILLS_LOCK"
else
  lock=$(mktemp)
  trap 'rm -f "$lock"' EXIT
  curl -fsSL "https://raw.githubusercontent.com/$REPO/main/skills-lock.json" -o "$lock"
fi

echo "==> $REPO (skills do kit)"
npx -y skills add "$REPO" --skill '*' -y "$@"

# Uma linha por origem: "<origem> --skill <a> --skill <b> ..."
node -e '
const lock = JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"));
const bySource = {};
for (const [name, skill] of Object.entries(lock.skills || {})) {
  (bySource[skill.source] ||= []).push(name);
}
for (const [source, names] of Object.entries(bySource)) {
  console.log([source, ...names.flatMap((n) => ["--skill", n])].join(" "));
}
' "$lock" | while read -r line; do
  echo "==> ${line%% *} (terceiros)"
  # shellcheck disable=SC2086 # $line precisa ser dividido em argumentos
  npx -y skills add $line -y "$@" </dev/null
done
