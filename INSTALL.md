# Installing mstack

mstack has two parts:

| Part | What | Where it goes |
|---|---|---|
| **The pack** | `skills/`, `agents/`, `core/` | a Claude Code plugin, or a folder in your project |
| **`AGENTS.md`** | the rules every agent session reads | your project's root |

mstack writes its own project files into `.mstack/` in your project. Commit that folder, except `.mstack/.cache/`, which mstack ignores automatically.

---

## Claude Code (plugin)

```text
/plugin install mstack --marketplace mahirhacks/Spec-Driven-Agents
```

Or add the marketplace first, then install:

```text
/plugin marketplace add mahirhacks/Spec-Driven-Agents
/plugin install mstack@mstack
```

To try a local checkout without installing:

```bash
claude --plugin-dir /path/to/Spec-Driven-Agents
```

Then copy `AGENTS.md` into your project root (merge it if you already have one) and run `/mstack:goal`.

---

## Cursor, Codex, Windsurf, Antigravity and others

These tools read `AGENTS.md` (or their own rules file) each session, so mstack runs from a folder in your project.

**macOS / Linux**

```bash
mkdir -p .agent/mstack
cp -R /path/to/Spec-Driven-Agents/{skills,agents,core} .agent/mstack/
cp /path/to/Spec-Driven-Agents/AGENTS.md ./AGENTS.md
```

**Windows (PowerShell)**

```powershell
New-Item -ItemType Directory -Force .agent\mstack | Out-Null
Copy-Item -Recurse -Force C:\path\to\Spec-Driven-Agents\skills, C:\path\to\Spec-Driven-Agents\agents, C:\path\to\Spec-Driven-Agents\core .agent\mstack\
Copy-Item C:\path\to\Spec-Driven-Agents\AGENTS.md .\AGENTS.md
```

If your tool uses a different rules file (`.windsurfrules`, `.cursor/rules`…), paste the contents of `AGENTS.md` into it.

Then say: **"mstack goal"** to start, or **"mstack feature: <what>"** if your project files already exist.

Without subagents, mstack runs each role (writer, reviewer…) one after another in the same session, and the reviewer passes stay read-only.

---

## Check that it works

1. Claude Code: `/mstack:status`. Other tools: say "mstack status".
2. A new project should report "Project files: missing" and suggest `mstack goal`.

---

## Upgrading from `mvp-spec-driven-delivery`

- Remove the old pack (`.agent/mvp-spec-driven-delivery/`, `.cursor/skills/mvp-spec-driven-delivery/`, or the old plugin) and replace `AGENTS.md`.
- Existing `.agent/specs/` folders keep working as history. New work goes in `.mstack/`.
- To create the 4 project files from an existing codebase, run `/mstack:product` ("mstack product").
