#!/usr/bin/env bash
set -euo pipefail

warn_exists() {
  printf '🚨 WARNING => %s already exists. Set the required release age policy manually.\n' "$1" >&2
}

echo "Installing package manager release age policies..."

# npm-compatible package managers
if [[ -e "$HOME/.npmrc" ]]; then
  warn_exists "$HOME/.npmrc"
else
  cat > "$HOME/.npmrc" <<'EOF'
min-release-age=7
minimum-release-age=10080
save-exact=true
EOF
  echo "Created $HOME/.npmrc"
fi

# Bun
if [[ -e "$HOME/.bunfig.toml" ]]; then
  warn_exists "$HOME/.bunfig.toml"
else
  cat > "$HOME/.bunfig.toml" <<'EOF'
[install]
minimumReleaseAge = 604800
EOF
  echo "Created $HOME/.bunfig.toml"
fi

# uv
if [[ -e "$HOME/.config/uv/uv.toml" ]]; then
  warn_exists "$HOME/.config/uv/uv.toml"
else
  mkdir -p "$HOME/.config/uv"

  cat > "$HOME/.config/uv/uv.toml" <<'EOF'
[pip]
exclude-newer = "7d"
EOF
  echo "Created $HOME/.config/uv/uv.toml"
fi
