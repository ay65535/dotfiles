#!/bin/bash
set -euo pipefail

rye --version

SCRIPT_PATH=${BASH_SOURCE[0]:-$HOME/local/share/installers/linux/k3s/init-project.sh}
SCRIPT_DIR=$(cd -- "$(dirname -- "$SCRIPT_PATH")" &>/dev/null && pwd)

# BASE_PATH=$SCRIPT_DIR
# REPO_ROOT=$(git rootgit rev-parse --show-toplevel)
PROJ_ROOT=$SCRIPT_DIR
# PROJ_NAME=${PROJ_ROOT##*/}

cd "$PROJ_ROOT"

# rm -r "${PROJ_ROOT:?}"/.venv || true
# rm "$PROJ_ROOT"/pyproject.toml

rye config --set-bool behavior.use-uv=true
rye init
rye sync
rye add notebook
rye add bash_kernel
rye add nbconvert

rye run python --version
rye run python -m bash_kernel.install
