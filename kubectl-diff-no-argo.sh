#!/usr/bin/env bash
set -euo pipefail

# kubectl external diff helper that ignores the Argo CD tracking annotation
# Usage (kubectl invokes): <script> <LIVE_FILE> <MERGED_FILE>

left="${1:-}"
right="${2:-}"

if [[ -z "${left}" || -z "${right}" ]]; then
  echo "Usage: $0 <fileA> <fileB>" >&2
  exit 2
fi

if ! command -v yq >/dev/null 2>&1; then
  echo "yq is required on PATH" >&2
  exit 2
fi

tmpdir="$(mktemp -d)"
cleanup() { rm -rf "${tmpdir}"; }
trap cleanup EXIT

filter_file() {
  local src="$1"
  local dst="$2"
  yq eval 'del(.metadata.annotations."argocd.argoproj.io/tracking-id")' "${src}" > "${dst}"
}

filter_path() {
  local src_path="$1"
  local dst_path="$2"
  if [[ -d "${src_path}" ]]; then
    mkdir -p "${dst_path}"
    # Recreate directory tree and filter all files within
    while IFS= read -r -d '' src_file; do
      local rel
      rel="${src_file#"${src_path}"/}"
      local out_file
      out_file="${dst_path}/${rel}"
      mkdir -p "$(dirname "${out_file}")"
      filter_file "${src_file}" "${out_file}"
    done < <(find "${src_path}" -type f -print0)
  else
    # Single file
    filter_file "${src_path}" "${dst_path}"
  fi
}

left_f="${tmpdir}/left"
right_f="${tmpdir}/right"

filter_path "${left}"  "${left_f}"
filter_path "${right}" "${right_f}"

# Use recursive diff to handle both files and directories
exec diff -ruN "${left_f}" "${right_f}"
