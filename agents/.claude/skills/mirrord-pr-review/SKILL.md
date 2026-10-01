---
name: mirrord-pr-review
description: This skill is for reviewing PRs in mirrord related repositories, such as mirrord, operator, VS Code extension, and IntelliJ extension.
argument-hint: "PR URLs"
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh pr checks:*), Bash(gh api:*), Bash(git log:*), Bash(git diff:*), Bash(git show:*), Bash(git blame:*), Bash(jj git fetch:*), Bash(jj new:*), Bash(jj log:*), Bash(jj diff:*), Bash(jj show:*), Bash(jj status:*), Bash(jj restore:*), mcp__linear-server__get_issue, mcp__linear-server__list_comments, Read, Grep, Glob, Write, Edit
disable-model-invocation: true
---

# mirrord PR Review

Start by understanding why the change exists. Before commenting on individual lines, confirm
that the overall approach is sound and actually solves the problem described in the linked
issue. If it doesn't, raise that first; line-level feedback matters less until it's settled.
Every review comment should be easy to follow and actionable: say what is wrong, why it
matters, and what to change.

## Inputs

`$ARGUMENTS` is one or more GitHub PR URLs.

## Step 1 — Set up

**Check for the Linear MCP server.** If no `mcp__linear-server__*` tools are available, stop and
ask the user to install it (`claude mcp add --scope user --transport http linear-server
https://mcp.linear.app/mcp`, then restart the session). Don't fall back to reviewing
without the issue.

Do the following for each PR:

1. **Locate the repository.** Map the PR's repository to its local clone using the source
   locations in `~/.claude/CLAUDE.md`.
2. **Check out the change.** Check `gh pr view <url> --json isCrossRepository,headRefName`.
   - If `isCrossRepository` is true (the PR is from a fork), stop and ask the user to
     check it out.
   - Otherwise, in the local clone run `jj git fetch --remote origin`, then
     `jj new <headRefName>@origin` so the review starts from an empty change on top of the
     PR head. Never edit the PR's commits themselves.

## Step 2 — Gather context

**Read the issue.** Find the Linear issue linked from the PR (description, title, comments or
branch name) and read it, including its comments. If no Linear issue is linked, stop and
ask the user for the issue description. Don't infer the motivation from the diff alone.

## Step 3 — Understand the change

Before looking for problems, describe what the change does in your own language and 
how it solves the issue, end to end.

**When the change alters existing behavior** (lock scope, ordering, retries, error handling,
defaults), find out why the old behavior was the way it was before judging the new one:

- Use `git log -L` or `git blame` on the old code, and read the PRs that introduced it.
  Decide whether the old behavior was deliberate or a side effect (e.g. the lifetime of a
  temporary in a `match` scrutinee).
- Either way, list what the old behavior guaranteed in practice, and which code relies on
  those guarantees now. Accidental guarantees are the most likely to be broken silently.

When reviewing several PRs together (e.g. a mirrord change with a matching operator change),
treat them as one solution:

- Work out how they fit together: which PR depends on which, which interfaces or protocol
  messages they share, and whether they must be merged or released in a particular order.
- Understand the overall design at a high level before judging any single PR. A choice that
  looks wrong in one PR may be explained by another.

## Step 4 — Review passes

Check the change against each area below, in priority order. Issues in earlier areas
outweigh issues in later ones.

1. **Correctness:** the code does what the issue asks, including edge cases, error paths.
2. **Backward compatibility:** older and newer components still work together (protocol
   versions, CLI ↔ operator, config files, CRDs), and existing user setups don't break.
3. **Platform compatibility:** the change behaves correctly on Linux, macOS, and Windows, or
   is explicitly scoped to the platforms it supports.
4. **Security and user privacy:** no secrets or user data leaked into logs, errors, or
   telemetry; no new permissions beyond what the change needs.
5. **Simplicity:** no unnecessary abstraction, indirection, or code that could be removed.
6. **Consistency with the codebase:** follows established patterns, and reuses or extends
   existing modules for similar purposes instead of duplicating them.
7. **Tests:** every new or changed piece of logic is covered by a test that would fail
   without the change. Flag tests that only exercise existing behavior, duplicate another
   test's coverage, or don't assert anything meaningful. Check that tests run on every
   platform the fix applies to, and that CI actually runs them there.
8. **Comments and documentation:** concise, accurate, human-readable and updated where 
   behavior changed. Flag comments that promise more than the code does.
9. **Efficiency:** no avoidable allocations, copies, blocking calls, busy loops, extra 
   round trips, etc..

Don't report issues that formatters, linters, or CI already catch.

## Step 5 — Verify findings

Try to reproduce each correctness finding before reporting it. Report findings you could not
reproduce as unconfirmed, and say why.

Skip reproduction when the finding is specific to a platform other than the host's (e.g. a
Unix-only code path when running on Windows). Report it as unconfirmed and name the
platform it needs.

### Choose the cheapest reproduction

1. A unit test or a layer integration test, when the issue can be isolated that way.
2. Otherwise, a minikube cluster on this machine.
3. If the issue needs another environment (Kind, a real staging cluster, etc.), stop and
   ask the user to set it up.

### Build mirrord

Build the CLI from the mirrord repository with `cargo xtask`, and run it through the
`mirrord-dev` symlink, which points to the debug build.

### Install the operator (only if the finding needs it)

Use the `cargo xtask` commands in `~/code/github/0x00A5/mirrord-dev-setup`.

First choose the setup, since it decides the install order and the values files:

- **Standalone operator** (default): the operator reads the license directly.
- **Operator with a license server**: only when the change involves the license server.
  The license server must be installed before the operator.

Then:

1. Generate a test license, unless one already exists.
2. Create the license secret: for the operator in the standalone setup, or for the
   license server otherwise.
3. License server setup only: install the license server.
4. Build the operator image and load it into minikube.
5. Install the operator from the charts, using the predefined values file in the repo that
   matches the chosen setup. Standalone and license-server setups use different values
   files.

Use `helm` and `kubectl` directly to adjust the minikube cluster when needed. If the fix
belongs in the mirrord-dev-setup repo itself, stop and ask instead of changing it.

### Reproduce

Create a test workload (deployment, pod, etc.) that triggers the issue, run mirrord
against it, and record the commands and the observed behavior for the report.

## Output

### In the terminal

The review is read by a person, so it should sound like one wrote it.

1. **Summary of the change:** an accurate, plain-language description of what the PRs do
   and how.
2. **Verdict:** at most three sentences on merge readiness and the main reasons for it.
3. **Findings:** ordered by severity, most severe first. For each finding give:
   - `file:line`
   - what is wrong and why it matters
   - origin, trigger, likelihood, and whether it blocks the merge
   - what to change, with a code suggestion when the fix is clear-cut
   - whether it was reproduced, and how

## Boundaries

1. Don't post anything to GitHub (or other). Keep all review comments local.
2. Don't use a real staging cluster without asking first.
3. Don't run e2e tests locally.
4. Build or run tests only to reproduce a specific finding.
