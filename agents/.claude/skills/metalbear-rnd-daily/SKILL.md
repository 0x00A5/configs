---
name: metalbear-rnd-daily
description: Summarize the MetalBear R&D team's daily work from GitHub PRs, Linear issues and Slack threads.
argument-hint: "yyyy-mm-dd for a single day; yyyy-mm-dd yyyy-mm-dd for a date range; nothing for today."
allowed-tools: Bash(date:*), Bash(gh auth status:*), Bash(gh pr list:*), Bash(gh search prs:*), Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh pr checks:*), Bash(gh api:*), mcp__linear-server__get_issue, mcp__linear-server__list_comments, mcp__linear-server__get_attachment, mcp__linear-server__list_customer_needs, mcp__plugin_slack_slack__slack_read_thread, mcp__plugin_slack_slack__slack_read_channel, mcp__plugin_slack_slack__slack_search_public_and_private, Read, Glob, Write
disable-model-invocation: true
---

# MetalBear R&D Daily

Start by listing the pull requests (PRs) opened in the given date range (UTC). Group the PRs by
their associated Linear issues. For each group, summarize what is being developed and why in at
most 5 sentences. After the summary, link the PRs (with their author and reviewers, if any), the
Linear issues and the recent Slack threads relevant to the work. Describe the current state of the
PRs in one sentence, e.g. ready to merge, blocked by a merge queue CI failure, changes requested by
a reviewer, or work in progress.

Order the groups by team: COR, INT, then MBE.

## Inputs

`$ARGUMENTS` is one of the following:
* A single date, covering that whole day. For example: "1992-03-23".
* Two dates, describing a range. For example: "1992-03-23 1994-01-23".
* Nothing, meaning today.

## Step 1 — Read pull requests

**Check for the GitHub CLI.** If `gh` is not installed or not authenticated, stop and ask the user
to set it up.

List the PRs created in the given date range in the following repositories:
* metalbear-co/mirrord
* metalbear-co/operator
* metalbear-co/rfcs
* metalbear-co/mirrord-vscode
* metalbear-co/mirrord-intellij
* metalbear-co/mirrord-browser
* metalbear-co/infra
* metalbear-co/docs

**Ignore PRs created by bots**, such as cubby-mb's automated release PRs and Dependabot dependency
bumps.

**Read each PR's description and comments.** Note the related Linear issue.

## Step 2 — Read Linear issues

**Check for the Linear MCP server.** If no Linear tools are available, stop and ask the user to
install it.

**Read the Linear issues found in step 1.** Note the related Slack messages or threads. Understand
each issue's motivation and requirements. Identify whether the issue comes from a customer request
or is an internal R&D initiative.

## Step 3 — Group

**Group the PRs associated with the same Linear issue.** Each group represents a task.

## Step 4 — Summarize

**Understand each task.** You should then be able to answer the following questions:
- What is the motivation for the task?
- What is the solution?
- Who is working on the task?
- Who is reviewing it, if anyone?
- Who should be notified when the task is completed, if anyone?
- What is the current status of the task?

## Output

### Format

Separate tasks with a line of 80 `━` characters. Start each task with `## <n>. <ISSUE-ID> — <short, specific title>`,
the only heading in the task. Then show, in order:
- Linear issue link
- PR links
- Slack message and/or thread links
- Task summary

### Language style

In addition to the global language style guidelines, make the output easy for people to read.

### Save to file

**Save the output to a Markdown file** under `$HOME/metalbear-rnd-daily/`.

For a single day, name the file `yyyy-mm-dd.md`. For a date range, name it
`yyyy-mm-dd-to-yyyy-mm-dd.md`.

If the date range overlaps with existing files, stop and ask the user what to do.

### Display in terminal

**Display the output in the terminal.** Links must be clickable.

### Missing permissions

At the very end, list any tools or permissions you needed but weren't allowed to use, and what
you needed each one for.

## Boundaries

Don't post anything to GitHub, Slack, Linear or anywhere else. Keep all output local.
