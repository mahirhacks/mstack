# cursor-spec-driven

> Stop vibe coding. Start shipping structured, predictable, token-efficient code with Cursor IDE.

A `CURSOR.md` file that transforms Cursor into a **spec-driven development machine** — inspired by Kiro IDE's agent workflow, adapted natively for Cursor. Paired with a battle-tested **5-phase development methodology** that takes you from raw idea to production code with maximum efficiency and minimum wasted tokens.

---

## Real Numbers From Production Use

- Composer 2.5 wrote **9,000 lines of code** consuming barely **1% of token budget**
- Planning phase (requirements + design + tasks) with Claude Opus used **~4%**
- Zero back-and-forth correction loops
- **~50% productivity increase** compared to standard vibe coding

---

## Part 1 — The Full Development Methodology

This is a cost-efficient, research-validated, AI-assisted method for building any application from scratch. Each phase uses the best free or affordable tool for that job.

```
Idea → Research → Validation → Prototype → Architecture → Development
```

---

### Phase 1 — Research & Brainstorm (Gemini Deep Research)

If you're a student, you likely have free access to Gemini Pro. Take your raw idea and let it do the heavy lifting before you write a single line of code.

**Steps:**
1. Explain your idea in as much detail as possible, then add:
   > *"Align my idea with a real world problem people are facing. Break down the problem in detail. Find existing apps or companies solving a similar problem, identify their weaknesses based on customer feedback, and explain how those weaknesses can be overcome."*
2. Enable **Deep Research Mode** and let it run.
3. Save the output as your research document.

**Why this works:** You're not just validating your idea — you're discovering the gap in the market before you invest a single dollar.

---

### Phase 2 — Research Validation (Perplexity)

Cross-validate Gemini's research using Perplexity to make sure the findings are grounded in real sources.

**Steps:**
1. Feed Perplexity the key claims from your Gemini research document.
2. Ask it to verify whether the problems, market gaps, and competitor weaknesses are real and cited.
3. Save the output as `idea_validation.md` — you'll use this in every phase after.

**Why this works:** Gemini deep research is powerful but can hallucinate citations. Perplexity grounds the findings in verifiable sources.

---

### Phase 2.5 — UI/UX Inspiration (Optional but Recommended)

Browse Pinterest, Dribbble, or Mobbin for UI/UX designs similar to your app's domain. Save screenshots you like. These will feed directly into your prototype phase and help Claude understand your visual direction without lengthy descriptions.

---

### Phase 3 — Prototype Interface Design (Claude)

Doable on Claude's free tier if you're strategic about it.

**Steps:**
1. Provide Claude with:
   - Your research document
   - `idea_validation.md`
   - Saved UI/UX inspiration images
2. Ask it to design an MVP front-end prototype using only HTML, CSS, and JavaScript.
3. Claude produces a `prototype.html` — a fully visual, clickable front-end prototype.
4. Iterate and tune it until it matches your vision.

**Why this works:** A visual prototype is worth a thousand words when you later describe your app to an architect or a coding agent. It also forces you to make UX decisions early, before they become expensive to change.

---

### Phase 4 — Architecture & Stack Selection (ChatGPT or Claude)

Doable on ChatGPT's free tier.

**Steps:**
1. Provide:
   - Your research document
   - `idea_validation.md`
   - `prototype.html`
2. Ask for a detailed full-stack technical architecture breakdown, saved as `architecture.md`.
3. Optional: validate `architecture.md` with Claude for a second opinion.

**Prompt:**
> *"Act as a senior software architect. Based on this research, validated idea, and prototype, produce a detailed full-stack architecture document including: tech stack recommendation with justification, folder structure, data models, API design, authentication strategy, and deployment plan."*

**Why this works:** ChatGPT in architecture mode is excellent at opinionated, structured technical output. You get a senior architect's decision-making for free.

---

### Phase 5 — App Development (Cursor + This Repo)

Now you have everything. Open your project folder in Cursor and follow the spec-driven workflow.

**Folder setup:**

```
your-project/
  References & Resources/
    research-document.md
    idea_validation.md
    architecture.md
    prototype.html
    ui-inspiration/        ← optional screenshots
  .cursor/
    steering/              ← auto-generated in this phase
    specs/                 ← auto-generated in this phase
  CURSOR.md                ← from this repo
  src/
```

**Development flow:**

1. **Select a higher model** (Claude Sonnet 4.6+ or Opus recommended)
2. Prompt:
   > *"Read CURSOR.md and everything in References & Resources. Create the specs inside `.cursor/specs/<feature-name>/` — generate `requirements.md`, then `design.md`, then `tasks.md`. Revise `tasks.md` based on both documents. DO NOT execute any tasks yet."*
3. Review and approve the spec files.
4. **Switch to an affordable model** (Composer 2.5 recommended)
5. Prompt:
   > *"Execute all tasks in `.cursor/specs/<feature-name>/tasks.md`."*
6. Wait for implementation to complete.
7. **Switch back to the higher model**
8. Prompt:
   > *"Review the code and sync it with `requirements.md`, `design.md`, and `tasks.md`. Then generate steering files for this project."*

Cursor will auto-generate `product.md`, `tech.md`, `structure.md`, and `security.md` in `.cursor/steering/`.

**Why the model switching matters:**

| Phase | Model | Why |
|-------|-------|-----|
| Spec creation + review | Claude Opus / Sonnet 4.6+ | Dense reasoning, edge case coverage |
| Implementation | Composer 2.5 | Token-efficient, instruction-following, cheap |
| Code review + steering | Claude Opus / Sonnet 4.6+ | Architectural judgment |

Planning burns ~4% tokens. 9,000 lines of implementation burns ~1%. You're paying for thinking, not typing.

---

## Part 2 — The CURSOR.md Spec Workflow

Once your project is set up, every new feature and bugfix follows this structured flow.

### When to Use Specs vs Direct Implementation

| Use **Specs** when… | Use **direct implementation** when… |
|---------------------|--------------------------------------|
| Building a new feature with multiple moving parts | One-line fix or typo |
| Fixing a bug where regressions would be costly | Pure refactor with no behaviour change |
| The task will touch more than 2–3 files | Exploratory prototype you intend to throw away |
| You want documentation alongside the code | |

---

### The Three-Phase Gate

```
Phase 1 (Requirements or Bugfix Analysis)
    ↓  [approval gate]
Phase 2 (Design)
    ↓  [approval gate]
Phase 3 (Tasks → Implementation)
```

Cursor will not proceed past each gate until you approve. No sneaking into code.

---

### Phase 1A — Requirements (New Features)

Cursor turns your idea into structured user stories using **EARS notation**:

```
WHEN [condition or trigger]
THE SYSTEM SHALL [expected behaviour]
```

Output: `.cursor/specs/<feature-name>/requirements.md`

---

### Phase 1B — Bug Analysis (Bugfixes)

Cursor diagnoses the root cause and defines safe fix boundaries before touching any code. Captures three behaviour categories:
- **Defect** — what it currently does wrong
- **Correct** — what it should do
- **Unchanged** — what must not regress

Output: `.cursor/specs/<bug-name>/bugfix.md`

---

### Phase 2 — Design

Full technical design: architecture, data flow, Mermaid sequence diagrams, error handling, security considerations, testing strategy.

Output: `.cursor/specs/<name>/design.md`

---

### Phase 3 — Tasks

Dependency-ordered task list, each task mapped to specific files with verifiable completion criteria. File-conflict pairs flagged so nothing gets overwritten mid-session.

Output: `.cursor/specs/<name>/tasks.md`

---

### Phase 4 — Implementation

One task at a time. Cursor announces what it's doing, updates `tasks.md` status, and flags any deviation from the design with an explanation.

---

## Approval Gates

| Gate | Phrase to continue |
|------|--------------------|
| After requirements / bugfix analysis | `"requirements approved"` / `"looks good"` / `"continue"` |
| After design | `"design approved"` / `"looks good"` / `"continue"` |
| After tasks | `"tasks approved, start implementation"` / `"do task N"` |
| After each task | Cursor asks before starting the next |

**Quick mode:** `"Quick plan: [feature]"` — generates all three documents back-to-back, only pauses before writing code.

---

## Key Commands

| Goal | What to say |
|------|-------------|
| Start a new feature | `"I want to add [feature]. Start with requirements."` |
| Have a design already | `"I have a design — start with design."` |
| Quick mode | `"Quick plan: [feature description]"` |
| Report a bug | `"Bug: [description]. Steps: [steps]. Expected: [X]. Actual: [Y]."` |
| Skip to tasks | `"I have a design doc — skip to tasks."` |
| Execute a task | `"Do Task 3."` |
| Run everything | `"Execute all tasks."` |
| Check status | `"What's the current spec status?"` |
| Bootstrap steering | `"Bootstrap this project"` |

---

## Final Project Structure

```
your-project/
  .cursor/
    steering/
      product.md        ← what your product is
      tech.md           ← stack and constraints
      structure.md      ← folder layout and naming conventions
      security.md       ← auth, validation, secrets standards
    specs/
      [feature-name]/
        requirements.md
        design.md
        tasks.md
      [bug-name]/
        bugfix.md
        design.md
        tasks.md
  References & Resources/
    research-document.md
    idea_validation.md
    architecture.md
    prototype.html
  CURSOR.md
  src/
```

---

## Templates Included

**Steering files** (`templates/steering/`):
- `product.md` — product overview, target users, objectives, out of scope
- `tech.md` — stack, libraries, preferred patterns, banned alternatives
- `structure.md` — folder layout, naming conventions, architectural decisions
- `security.md` — auth standards, input validation, secrets handling

**Spec files** (`templates/specs/`):
- `requirements.md` — user stories with EARS acceptance criteria
- `design.md` — architecture, sequence diagrams, error handling
- `tasks.md` — dependency-ordered task list with verifiable completion criteria
- `bugfix.md` — root cause analysis with regression prevention

---

## Why Not Just Use Kiro IDE?

Kiro has a great spec-driven workflow but it's a separate IDE. This repo brings the same discipline to **Cursor**, which has better model selection, Composer 2.5, and a more mature extension ecosystem. The spec-driven principle is IDE-agnostic — this repo just makes it work out of the box in Cursor.

---

## Contributing

PRs welcome. Especially interested in:
- Stack-specific steering file examples (Next.js, React Native, Django, Laravel, etc.)
- Phase 1–4 methodology variations for different project types
- Real-world token usage benchmarks from different stacks

---

## License

MIT — use it, fork it, adapt it for your team.

---

*Built out of frustration with vibe coding. Tested on a real production React Native + Supabase project.*
