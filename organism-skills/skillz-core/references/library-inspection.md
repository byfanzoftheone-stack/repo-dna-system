# Skillz Library Inspection

Keep organism skills current with the code and surfaces they claim to govern.

## Goal

A skill is not current because it exists. It is current when its instructions still match an implementation, endpoint, schema, or file that can be pointed to.

## Inspect order

1. Read the skill `description` and list trigger claims.
2. Read the skill body for named paths, endpoints, schemas, agents, and outputs.
3. Check the live tree:
   - `/home/workdir/.grok/skills/<name>/`
   - claimed repos via GitHub tools when a repo is named
   - claimed endpoints only if the user asked for live status
   - `/home/workdir/artifacts/` for staged implementations
4. Compare claim vs evidence. Do not fill gaps with memory of older sessions.

## Classes

| Class | Meaning | Next action |
|---|---|---|
| current | Instructions match evidence | keep |
| stale | Evidence moved or renamed | patch the skill |
| untested | Claims exist, no test or run recorded | run a bounded test, then reclass |
| missing-impl | Skill describes work with no code/surface | mark missing, do not treat as live |
| over-claimed | Skill asserts production/Brain/live status it does not have | quarantine language, add gate |

## Evidence rules

- File path or endpoint beats recollection.
- "As of DATE" beats "always".
- Constitution and security skills are current only if later skills still declare compliance and do not weaken gates.
- A skill that names a 404 gateway or retired path is stale.

## Test minimum (bounded)

When class is `untested`, run the smallest check that could fail:

- Validate SKILL.md with skill-creator `validate-skill.sh`
- Confirm named files exist
- Confirm named schema fields still exist
- For HTTP surfaces, only probe when the user asked for status

Do not invent load tests. Do not execute untrusted code.

## Batch vs single

Default: inspect only skills in the topic sentence.

Full-library sweep only when the user says inspect the library, Skillz currency, or test-and-current across skills.

## Output shape

```
skill: <name>
class: current | stale | untested | missing-impl | over-claimed
claim: <one line>
evidence: <path, endpoint, or none>
action: keep | patch | quarantine | create
```

After the table, stage patches with skill-creator. Do not silently rewrite constitution.
