#!/bin/bash
set -e

if [[ -z "${GITHUB_REPOSITORY}" ]]; then
  echo "The env variable GITHUB_REPOSITORY is required."
  exit 1
fi

if [[ -z "$GITHUB_EVENT_PATH" ]]; then
  echo "The env variable GITHUB_EVENT_PATH is required."
  exit 1
fi

GITHUB_TOKEN="$1"

URI="https://api.github.com"
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

get_run_url() {
  number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")

  body=$(curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" "${URI}/repos/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}/jobs")

  echo "${body}"

  url=$(echo "$body" | jq .jobs | jq .[-1] | jq .html_url)
  id=$(echo "$body" | jq .jobs | jq .[-1] | jq .id)
  start=$(echo "$body" | jq .jobs | jq .[-1] | jq .started_at)

  echo ::set-output name=url::${url}
  echo ::set-output name=id::${id}
  echo ::set-output name=pr::${number}
  echo ::set-output name=started_at::$start
}

get_run_url

exit $?
