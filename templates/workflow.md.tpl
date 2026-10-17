---
description: "@SDD_NAME@ driven development via @AGENT_NAME@"
on:
  issues:
    types: [labeled]
  workflow_dispatch:
engine: @AGENT_ENGINE@
permissions:
  contents: read
  issues: read
  pull-requests: read
safe-outputs:
  create-pull-request:
    title-prefix: "[sdd] "
    labels: [agentic, sdd]
---

# @SDD_NAME@ agentic development

Triggered when an issue is labeled `sdd`. Take the issue as the feature request and
drive it through the @SDD_NAME@ workflow, working in `@SDD_SPEC_DIR@/`:

1. Follow @SDD_STEPS@.
2. Write specification artifacts first, then implement them.
3. Run the project's tests and linters before finishing.
4. Open a pull request with the specs and implementation.

Read `@AGENT_INSTRUCTIONS_FILE@` for project conventions.
