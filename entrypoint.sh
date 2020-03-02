#!/bin/bash
set -e

if [[ -z "${GITHUB_REPOSITORY}" ]]; then
  echo "The env variable GITHUB_REPOSITORY is required."
  exit 1
fi

GITHUB_TOKEN="$1"

URI="https://api.github.com"
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

get_run_url() {
  body=$(curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" "${URI}/repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/jobs")

  echo "${body}"

  url=$(echo "$body" | jq .jobs | jq .[] | jq .html_url)

  echo "${url}"
}

get_run_url

exit $?
