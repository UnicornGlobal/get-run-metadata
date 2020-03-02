## Get Run Metadata

Retrieves metadata from `GET /repos/:owner/:repo/actions/runs/:run_id/jobs` and makes it available to your steps

- The run 'checks' ID (id)
- The run 'checks' URL (url)
- The PR number (pr)
- The time the run started (started_at)
- The HEAD SHA (head_sha)
- Short versions of the HEAD SHA (head_sha7 and head_sha8)

We use these details in other actions and workflows, so made this step to
collect what we need.

The direct check URL and ID is not related to the `GITHUB_RUN_ID` value.

You need to retreive the specific URL for the check suite from the API.

See: https://developer.github.com/v3/actions/workflow_jobs
