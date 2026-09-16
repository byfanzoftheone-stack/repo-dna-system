/**
 * schema.js
 * Shared Hand-off schema for Clipboard Agent
 * Must stay isomorphic with the skill's Hand-off MD frontmatter
 * and organism-constitution requirements.
 */

export const GATES = [
  { id: "lint",     num: 1, name: "Static Lint",     desc: "No obvious errors or injection risks" },
  { id: "plan",     num: 2, name: "Plan Check",       desc: "Intent matches action — no drift" },
  { id: "sandbox",  num: 3, name: "Sandbox",          desc: "Isolated — output quarantined" },
  { id: "security", num: 4, name: "Security",         desc: "Triple S — no unvetted personal content" },
  { id: "iof",      num: 5, name: "Index of Flow",    desc: "Human review required — hold here" },
  { id: "release",  num: 6, name: "Release",          desc: "Only write path to canonical Brain" },
];

export const SOURCES = [
  { id: "clipboard", label: "📋 Clipboard", platform: "any" },
  { id: "claude",    label: "⚡ Claude",    platform: "platform-a" },
  { id: "grok",      label: "🤖 Grok",      platform: "platform-b" },
  { id: "chatgpt",   label: "💬 ChatGPT",   platform: "platform-c" },
  { id: "terminal",  label: "💻 Terminal",   platform: "terminal" },
  { id: "session",   label: "🗒️ Session",   platform: "session" },
  { id: "manual",    label: "✍️ Manual",    platform: "manual" },
];

export const CATEGORIES = [
  "insight", "architecture", "theory", "pattern",
  "build", "system", "philosophy", "other",
];

/**
 * Create a new Hand-off object.
 * Core fields match the skill MD frontmatter exactly.
 */
export function makeHandoff(content, source, category, phrasingNote = "", sessionId = "") {
  const now  = new Date();
  const ts   = now.toISOString().replace(/[-:.TZ]/g, "").slice(0, 15);
  const slug = Math.random().toString(36).slice(2, 6);

  return {
    // ── Core (matches skill frontmatter exactly) ────────────────────
    id:             `handoff-${ts}-${slug}`,
    timestamp:      now.toISOString(),
    source,
    category,
    confidence:     0.75,
    security_flags: [],
    session_id:     sessionId || "",
    status:         "pending",
    lineage:        ["organism-constitution", "clipboard-agent"],

    // ── Content ─────────────────────────────────────────────────────
    content: content.trim(),

    // ── UI-only extensions ──────────────────────────────────────────
    platform:       SOURCES.find(s => s.id === source)?.platform ?? source,
    phrasing_note:  phrasingNote.trim(),
    cost_notes:     "",
    gateIndex:      0,
    gateResults:    [],
    createdAt:      Date.now(),
  };
}

/**
 * Serialize a Hand-off object to the exact MD format expected by the skill.
 */
export function toMarkdown(h) {
  return `---
id: ${h.id}
timestamp: ${h.timestamp}
source: ${h.source}
category: ${h.category}
confidence: ${h.confidence}
security_flags: ${JSON.stringify(h.security_flags || [])}
session_id: ${h.session_id || ""}
status: ${h.status}
lineage: ${JSON.stringify(h.lineage || [])}
---

# ${h.id}

## Content

${h.content}

## Notes

- Created via Clipboard Agent surface
- Status is pending — must pass gates before any promotion
${h.phrasing_note ? `- Phrasing note: ${h.phrasing_note}` : ""}
`;
}

/**
 * Parse a Hand-off MD string back into a React handoff object.
 */
export function fromMarkdown(md) {
  const match = md.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!match) throw new Error("Invalid Hand-off MD");

  const fm = {};
  match[1].split("\n").forEach(line => {
    const [key, ...rest] = line.split(":");
    if (!key) return;
    let val = rest.join(":").trim();
    try { val = JSON.parse(val); } catch {}
    fm[key.trim()] = val;
  });

  const contentMatch = match[2].match(/## Content\n\n([\s\S]*?)(?=\n## |$)/);
  const content = contentMatch ? contentMatch[1].trim() : match[2].trim();

  return {
    ...fm,
    content,
    platform:       SOURCES.find(s => s.id === fm.source)?.platform ?? fm.source,
    phrasing_note:  "",
    cost_notes:     "",
    gateIndex:      fm.status === "pending" ? 5 : 6,
    gateResults:    [],
    createdAt:      Date.now(),
  };
}
