<!--
SYNC IMPACT REPORT
==================
Version change: (unratified scaffold) -> 1.0.0
Change type: Initial ratification (all template placeholders resolved; no
prior ratified version existed).

Modified principles: (none - initial adoption)
Added sections:
  - Core Principle I: Specification-First
  - Core Principle II: English as the Project Language (from user mandate)
  - Core Principle III: Test-First (NON-NEGOTIABLE)
  - Core Principle IV: Workflow Compliance and Artifact Traceability
  - Core Principle V: Simplicity
  - Language and Artifact Policy
  - Development Workflow and Quality Gates
  - Governance
Removed sections: (none)

Deferred items:
  - None. No bracketed placeholders remain; TODO tokens are not required.

Notes:
  - English was adopted as the mandatory project language for all persistent
    repository artifacts. Agent-session conversation language remains
    unrestricted, but session dialogue MUST NOT be copied untranslated into
    repository artifacts.
  - This report is temporary review scratch material and MUST be removed
    before the amended constitution file is committed.
-->

# sdd-agentic-factory Constitution

Spec-driven, agent-executable delivery depends on artifacts that every
contributor — human or agent — can read, review, and verify identically. This
constitution defines the non-negotiable rules for how work in
`sdd-agentic-factory` is specified, implemented, and governed.

## Core Principles

### I. Specification-First

Every feature MUST begin as a written, reviewed specification produced through
the registered Spec Kit workflow before any implementation work starts.
Implementation MUST NOT proceed without an approved specification. Open
questions MUST be resolved through clarification before planning begins. Plans
and task lists MUST be derived from — and traceable to — the specification.

**Rationale**: The factory's purpose is predictable, agent-executable
delivery. The specification is the executable contract between human intent
and machine work; without it, agent output cannot be verified.

### II. English as the Project Language (NON-NEGOTIABLE)

All persistent repository artifacts MUST be written in English. This includes,
at minimum: specifications, plans, task lists, checklists, this constitution,
README and all documentation, source code and code comments, test names and
fixtures, commit messages, pull-request titles and descriptions, and branch
names. Conversation with the agent MAY occur in any language; however,
agent-session dialogue MUST NOT be copied untranslated into repository
artifacts. Non-English user input MUST be translated into English when
captured in specifications or other artifacts, with the original meaning
preserved. Proper names, established technical terms, and quoted identifiers
MAY remain non-English, but surrounding prose MUST be English.

**Rationale**: A single artifact language guarantees that specs, reviews, and
runtime development guidance are interpretable identically regardless of the
chat locale, and prevents language-mixing drift across a predominantly
agent-executed workflow.

### III. Test-First (NON-NEGOTIABLE)

Test-Driven Development MUST be followed: tests are written first and approved
as a specification of expected behavior, demonstrated to fail, and only then
is implementation written. The Red-Green-Refactor cycle MUST be adhered to.
Integration tests MUST cover: new component or library contract tests,
contract changes, inter-service communication, and shared schemas.

**Rationale**: Specs alone do not prove behavior; failing-first tests anchor
every implementation to observable, verifiable outcomes and guard regressions.

### IV. Workflow Compliance and Artifact Traceability

All development work MUST flow through the workflows registered under
`.specify/workflows/`. The specified sequence of phases MUST be followed in
order. Each generated artifact (specification, plan, task list, checklist)
MUST be stored at its designated location and remain referenced by later
phases. Implementation MUST NOT begin until all prerequisite artifacts exist
and their gates have passed.

**Rationale**: Skip-ahead execution breaks traceability between intent and
implementation and makes agent output unauditable; the workflow registry is
the single source of truth for the delivery path.

### V. Simplicity

Implementations MUST be minimal and satisfy the specification without
additional speculative capability (YAGNI). Complexity MAY be introduced only
when the plan justifies it against a concrete requirement. Prefer composition
of small, independently verifiable units over monolithic structures.

**Rationale**: Agent-built systems grow quickly when unbounded; minimizing
speculative work keeps review cost low and failure surfaces small.

## Language and Artifact Policy

The following operational rules implement Principle II:

- **In scope (English REQUIRED)**: everything persisted in the repository —
  `specs/` contents, plans, tasks, checklists, source code, comments, tests,
  documentation, commit messages, and branch names.
- **Out of scope (language FREE)**: interactive agent-session dialogue,
  transient shell interaction, and local scratch notes that are never
  committed.
- **Translation duty**: when a user request arrives in another language, the
  capturing agent MUST translate requirements into English before they are
  written into `specs/` or any other artifact; the translation MUST preserve
  the original meaning and MUST record any ambiguities resolved during
  translation as clarification entries.
- **Named entities**: project names, file names, APIs, and product identifiers
  follow their canonical spelling; they are exempt from translation but MUST
  be surrounded by English prose.
- **Compliance defect**: any persistent artifact found outside the repository
  language policy MUST be corrected before it is committed or merged.

## Development Workflow and Quality Gates

Delivery MUST pass through the following gates in order:

1. **Specify gate**: a specification exists via `/speckit.specify`, is written
   in English, and is complete against the spec template.
2. **Clarify gate**: open ambiguities are resolved and recorded via
   `/speckit.clarify` before planning may start.
3. **Plan gate**: an implementation plan exists via `/speckit.plan` and is
   traceable to the specification.
4. **Task gate**: a task list exists via `/speckit.tasks`; each task is
   individually verifiable and maps to plan elements.
5. **Checklist gate**: where produced, checklist markers are consumed by later
   phases as-is; implementation MUST NOT modify checklist states.
6. **Implement gate**: `/speckit.implement` executes tasks only when all
   prior gates pass; tests MUST be authored before implementation per
   Principle III.

Review of every change MUST verify: specification coverage, test-first
adherence, workflow compliance, and project-language compliance.

## Governance

This constitution supersedes all other working practices, conventions, and
informal agreements within the repository.

- **Amendments** MUST document the motivation, be acknowledged by the project
  owner, and include a migration plan when they invalidate existing artifacts
  or workflows.
- **Versioning policy**: constitution versions follow semantic versioning.
  MAJOR: removal or redefinition of a principle or backward-incompatible
  governance change. MINOR: addition of a new principle or section, or
  material expansion of existing guidance. PATCH: clarifications, wording, and
  non-semantic refinements.
- **Compliance review**: every pull request and review MUST check adherence
  to this constitution; violations MUST be resolved before merge, and
  complexity MUST be justified in the plan.
- **Runtime guidance**: operational development guidance belongs in
  `README.md` and spec documents; this constitution governs only rules that
  apply to all work.

**Version**: 1.0.0 | **Ratified**: 2026-10-23 | **Last Amended**: 2026-10-23
