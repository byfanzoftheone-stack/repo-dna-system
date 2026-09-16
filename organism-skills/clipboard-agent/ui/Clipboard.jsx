/**
 * Clipboard.jsx
 * Visual surface for the Clipboard Agent skill.
 * Bound by organism-constitution.
 * Never auto-promotes. Human is the final gate.
 */

import { useState, useEffect } from "react";
import {
  GATES,
  SOURCES,
  CATEGORIES,
  makeHandoff,
  toMarkdown,
  fromMarkdown,
} from "./schema.js";

const STORE_KEY = "the-one-clipboard-handoffs";

async function loadHandoffs() {
  try {
    const r = await window.storage?.get(STORE_KEY, false);
    return r ? JSON.parse(r.value) : [];
  } catch {
    return [];
  }
}

async function saveHandoffs(hs) {
  try {
    await window.storage?.set(STORE_KEY, JSON.stringify(hs), false);
  } catch {}
}

export default function Clipboard() {
  const [handoffs, setHandoffs]         = useState([]);
  const [content, setContent]           = useState("");
  const [source, setSource]             = useState("clipboard");
  const [category, setCategory]         = useState("insight");
  const [phrasing, setPhrasing]         = useState("");
  const [showPhrase, setShowPhrase]     = useState(false);
  const [processing, setProcessing]     = useState(null);
  const [view, setView]                 = useState("intake");
  const [loaded, setLoaded]             = useState(false);
  const [expandedId, setExpandedId]     = useState(null);
  const [posting, setPosting]           = useState(null);
  const [apiKey, setApiKey]             = useState(null);
  const [showApiKeyPrompt, setShowApiKeyPrompt] = useState(false);
  const [apiKeyInput, setApiKeyInput]   = useState("");
  const [pendingApprovalId, setPendingApprovalId] = useState(null);

  useEffect(() => {
    loadHandoffs().then((hs) => {
      setHandoffs(hs);
      setLoaded(true);
    });
  }, []);

  const persist = (next) => {
    setHandoffs(next);
    saveHandoffs(next);
  };

  const submit = () => {
    if (!content.trim()) return;
    const h = makeHandoff(content.trim(), source, category, phrasing.trim());
    const next = [h, ...handoffs];
    persist(next);
    setContent("");
    setPhrasing("");
    setShowPhrase(false);
    runGates(h.id, next);
    setView("pending");
  };

  const runGates = async (hid, initial) => {
    setProcessing(hid);
    const delay = (ms) => new Promise((r) => setTimeout(r, ms));
    let current = initial;

    // Gates 1–4 auto-pass for now (placeholder for real lint/security)
    for (let i = 0; i < 4; i++) {
      await delay(500);
      current = current.map((h) => {
        if (h.id !== hid) return h;
        return {
          ...h,
          gateIndex: i + 1,
          gateResults: [
            ...h.gateResults,
            { gate: GATES[i].id, result: "pass", ts: new Date().toISOString() },
          ],
        };
      });
      setHandoffs([...current]);
    }

    // Arrive at human review (gate 5)
    await delay(500);
    current = current.map((h) => {
      if (h.id !== hid) return h;
      return { ...h, gateIndex: 5, status: "pending" };
    });
    persist([...current]);
    setProcessing(null);
  };

  const approve = async (hid) => {
    const handoff = handoffs.find((h) => h.id === hid);
    if (!handoff) return;

    if (!apiKey) {
      setPendingApprovalId(hid);
      setShowApiKeyPrompt(true);
      return;
    }

    await approveWithKey(hid, apiKey);
  };

  const reject = (hid) => {
    const next = handoffs.map((h) => {
      if (h.id !== hid) return h;
      return {
        ...h,
        status: "rejected",
        gateResults: [
          ...h.gateResults,
          { gate: "iof", result: "human-rejected", ts: new Date().toISOString() },
        ],
      };
    });
    persist(next);
  };

  const remove = (hid) => persist(handoffs.filter((h) => h.id !== hid));

  const importFromMarkdown = (mdText) => {
    try {
      const h = fromMarkdown(mdText);
      if (handoffs.some((existing) => existing.id === h.id)) {
        alert("Hand-off already exists in store");
        return;
      }
      const next = [h, ...handoffs];
      persist(next);
      setView("pending");
    } catch (err) {
      console.error("Import failed:", err);
      alert("Could not parse Hand-off MD");
    }
  };

  const handleApiKeySubmit = async () => {
    if (apiKeyInput.trim()) {
      const key = apiKeyInput.trim();
      setApiKey(key);
      setShowApiKeyPrompt(false);
      setApiKeyInput("");

      if (pendingApprovalId) {
        setTimeout(() => {
          approveWithKey(pendingApprovalId, key);
          setPendingApprovalId(null);
        }, 0);
      }
    }
  };

  const approveWithKey = async (hid, key) => {
    const handoff = handoffs.find((h) => h.id === hid);
    if (!handoff) return;

    setPosting(hid);

    try {
      const atom = {
        core: handoff.content,
        category: handoff.category,
        source: handoff.source,
        ts: handoff.timestamp,
        phrasing_note: handoff.phrasing_note || undefined,
      };

      const payload = { atoms: [atom] };

      const response = await fetch(
        "https://fanz-github-mcp-production.up.railway.app/v5/brain/ingest",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "x-api-key": key,
          },
          body: JSON.stringify(payload),
        }
      );

      if (!response.ok) {
        throw new Error(`Brain ingest failed: ${response.status} ${response.statusText}`);
      }

      const result = await response.json();
      console.log("✓ Atom released to brain:", result);

      const next = handoffs.map((h) => {
        if (h.id !== hid) return h;
        return {
          ...h,
          status: "released",
          gateIndex: 6,
          gateResults: [
            ...h.gateResults,
            { gate: "iof", result: "human-approved", ts: new Date().toISOString() },
            { gate: "release", result: "promoted-to-brain", ts: new Date().toISOString() },
          ],
        };
      });
      persist(next);
    } catch (error) {
      console.error("❌ Failed to release to brain:", error);
      const next = handoffs.map((h) => {
        if (h.id !== hid) return h;
        return {
          ...h,
          status: "released",
          gateIndex: 6,
          gateResults: [
            ...h.gateResults,
            { gate: "iof", result: "human-approved", ts: new Date().toISOString() },
            { gate: "release", result: `failed-ingest: ${error.message}`, ts: new Date().toISOString() },
          ],
        };
      });
      persist(next);
    } finally {
      setPosting(null);
    }
  };

  const awaitingReview = handoffs.filter((h) => h.status === "pending" && h.gateIndex === 5);
  const released = handoffs.filter((h) => h.status === "released");

  const tabs = [
    { id: "intake", label: "Intake", count: null },
    { id: "pending", label: "Review", count: awaitingReview.length || null },
    { id: "released", label: "Released", count: released.length || null },
    { id: "log", label: "Log", count: handoffs.length || null },
  ];

  return (
    <div
      style={{
        minHeight: "100vh",
        background: "#070710",
        color: "#ccc",
        fontFamily: "monospace",
        fontSize: 12,
      }}
    >
      {/* API Key Prompt Modal */}
      {showApiKeyPrompt && (
        <div
          style={{
            position: "fixed",
            inset: 0,
            background: "rgba(0,0,0,0.8)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            zIndex: 1000,
          }}
        >
          <div
            style={{
              background: "#0d0d18",
              border: "1px solid #1a1a2e",
              borderRadius: 12,
              padding: 24,
              maxWidth: 400,
              display: "flex",
              flexDirection: "column",
              gap: 12,
            }}
          >
            <div style={{ fontSize: 12, color: "#eee", letterSpacing: "0.05em" }}>
              MCP API Key Required
            </div>
            <div style={{ fontSize: 10, color: "#666", lineHeight: 1.6 }}>
              To release atoms to the brain, paste your MCP_API_KEY:
              <br />
              <code style={{ fontSize: 9, color: "#888" }}>echo $MCP_API_KEY</code>
            </div>
            <input
              type="password"
              value={apiKeyInput}
              onChange={(e) => setApiKeyInput(e.target.value)}
              placeholder="Paste your MCP_API_KEY…"
              onKeyDown={(e) => {
                if (e.key === "Enter") handleApiKeySubmit();
              }}
              autoFocus
              style={{
                background: "#0a0a0a",
                border: "1px solid #1a1a2e",
                color: "#bbb",
                padding: "8px 10px",
                borderRadius: 6,
                fontSize: 11,
                fontFamily: "monospace",
              }}
            />
            <div style={{ display: "flex", gap: 8 }}>
              <button
                onClick={handleApiKeySubmit}
                style={{
                  flex: 1,
                  padding: "8px",
                  borderRadius: 6,
                  border: "1px solid #00ff88",
                  background: "#0d1a12",
                  color: "#00ff88",
                  fontSize: 10,
                  cursor: "pointer",
                }}
              >
                Set Key
              </button>
              <button
                onClick={() => {
                  setShowApiKeyPrompt(false);
                  setApiKeyInput("");
                }}
                style={{
                  padding: "8px 16px",
                  borderRadius: 6,
                  border: "1px solid #1a1a2e",
                  background: "transparent",
                  color: "#333",
                  fontSize: 10,
                  cursor: "pointer",
                }}
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Header */}
      <div style={{ padding: "16px 16px 0", borderBottom: "1px solid #111" }}>
        <div style={{ fontSize: 10, color: "#333", letterSpacing: "0.15em", marginBottom: 4 }}>
          THE ONE ORGANISM
        </div>
        <div style={{ fontSize: 15, color: "#eee", letterSpacing: "0.05em", marginBottom: 12 }}>
          📋 CLIPBOARD AGENT
        </div>
        <div style={{ display: "flex", gap: 0 }}>
          {tabs.map((t) => (
            <button
              key={t.id}
              onClick={() => setView(t.id)}
              style={{
                padding: "6px 12px",
                background: "transparent",
                border: "none",
                borderBottom: view === t.id ? "2px solid #00ff88" : "2px solid transparent",
                color: view === t.id ? "#00ff88" : "#444",
                fontSize: 10,
                cursor: "pointer",
                letterSpacing: "0.08em",
                display: "flex",
                alignItems: "center",
                gap: 5,
              }}
            >
              {t.label}
              {t.count ? (
                <span
                  style={{
                    fontSize: 8,
                    padding: "1px 5px",
                    borderRadius: 10,
                    background: "#00ff8822",
                    color: "#00ff88",
                  }}
                >
                  {t.count}
                </span>
              ) : null}
            </button>
          ))}
        </div>
      </div>

      <div style={{ padding: 16, maxWidth: 600, margin: "0 auto" }}>
        {/* INTAKE */}
        {view === "intake" && (
          <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
            <div style={{ fontSize: 9, color: "#333", letterSpacing: "0.1em", marginTop: 4 }}>
              CAPTURE → CONTAIN → INSPECT → RELEASE
            </div>

            <div style={{ display: "flex", gap: 8 }}>
              <select
                value={source}
                onChange={(e) => setSource(e.target.value)}
                style={{
                  flex: 1,
                  background: "#0d0d18",
                  border: "1px solid #1a1a2e",
                  color: "#888",
                  padding: "7px 10px",
                  borderRadius: 6,
                  fontSize: 11,
                }}
              >
                {SOURCES.map((s) => (
                  <option key={s.id} value={s.id}>
                    {s.label}
                  </option>
                ))}
              </select>
              <select
                value={category}
                onChange={(e) => setCategory(e.target.value)}
                style={{
                  flex: 1,
                  background: "#0d0d18",
                  border: "1px solid #1a1a2e",
                  color: "#888",
                  padding: "7px 10px",
                  borderRadius: 6,
                  fontSize: 11,
                }}
              >
                {CATEGORIES.map((c) => (
                  <option key={c} value={c}>
                    {c}
                  </option>
                ))}
              </select>
            </div>

            <textarea
              value={content}
              onChange={(e) => setContent(e.target.value)}
              placeholder="Paste session content, insight, code, or knowledge fragment…"
              rows={6}
              style={{
                background: "#0d0d18",
                border: "1px solid #1a1a2e",
                color: "#bbb",
                padding: "10px 12px",
                borderRadius: 8,
                fontSize: 11,
                lineHeight: 1.6,
                resize: "vertical",
                maxHeight: 200,
                overflowY: "auto",
              }}
            />

            <div>
              <button
                onClick={() => setShowPhrase(!showPhrase)}
                style={{
                  background: "transparent",
                  border: "none",
                  color: "#333",
                  fontSize: 10,
                  cursor: "pointer",
                  padding: 0,
                }}
              >
                {showPhrase ? "▾" : "▸"} phrasing note (optional)
              </button>
              {showPhrase && (
                <input
                  value={phrasing}
                  onChange={(e) => setPhrasing(e.target.value)}
                  placeholder="Note any tone / talk-to-text concerns…"
                  style={{
                    display: "block",
                    width: "100%",
                    marginTop: 6,
                    background: "#0d0d18",
                    border: "1px solid #1a1200",
                    color: "#888",
                    padding: "7px 10px",
                    borderRadius: 6,
                    fontSize: 10,
                  }}
                />
              )}
            </div>

            <button
              onClick={submit}
              style={{
                padding: "11px",
                borderRadius: 8,
                border: `1px solid ${content.trim() ? "#00ff88" : "#1a1a2e"}`,
                background: content.trim() ? "#0d1a12" : "transparent",
                color: content.trim() ? "#00ff88" : "#333",
                fontSize: 11,
                cursor: content.trim() ? "pointer" : "default",
                letterSpacing: "0.1em",
                transition: "all 0.15s",
              }}
            >
              SUBMIT TO GATE STACK →
            </button>

            {/* Import button */}
            <button
              onClick={() => {
                const md = prompt("Paste full Hand-off MD:");
                if (md && md.trim()) importFromMarkdown(md);
              }}
              style={{
                padding: "8px",
                borderRadius: 6,
                border: "1px solid #1a1a2e",
                background: "transparent",
                color: "#555",
                fontSize: 10,
                cursor: "pointer",
              }}
            >
              Import Hand-off MD
            </button>

            {/* Gate stack visual */}
            <div
              style={{
                background: "#0d0d18",
                border: "1px solid #111",
                borderRadius: 8,
                padding: "12px 14px",
              }}
            >
              <div
                style={{
                  fontSize: 9,
                  color: "#333",
                  letterSpacing: "0.1em",
                  marginBottom: 10,
                }}
              >
                GATE STACK — NON-SKIPPABLE
              </div>
              <div style={{ display: "flex", flexWrap: "wrap", gap: 4, alignItems: "center" }}>
                {GATES.map((g, i) => (
                  <div key={g.id} style={{ display: "flex", alignItems: "center", gap: 4 }}>
                    <div
                      style={{
                        fontSize: 9,
                        padding: "3px 7px",
                        borderRadius: 4,
                        background: g.id === "release" ? "#0d1a12" : "#111",
                        border: `1px solid ${g.id === "release" ? "#00ff8844" : "#1a1a2e"}`,
                        color: g.id === "release" ? "#00ff88" : "#555",
                      }}
                    >
                      G{g.num} {g.name}
                    </div>
                    {i < GATES.length - 1 && (
                      <span style={{ color: "#222", fontSize: 9 }}>→</span>
                    )}
                  </div>
                ))}
              </div>
              <div style={{ marginTop: 8, fontSize: 9, color: "#222" }}>
                Capture → Contain → Inspect → Release only when cleared
              </div>
            </div>
          </div>
        )}

        {/* PENDING REVIEW */}
        {view === "pending" && (
          <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
            {awaitingReview.length === 0 &&
              handoffs.filter((h) => processing === h.id).length === 0 && (
                <div style={{ textAlign: "center", color: "#333", padding: 40, fontSize: 12 }}>
                  No handoffs awaiting review.
                  <br />
                  <span style={{ fontSize: 10 }}>Submit content via Intake to begin.</span>
                </div>
              )}
            {awaitingReview.map((h) => (
              <HandoffCard
                key={h.id}
                h={h}
                expanded={expandedId === h.id}
                onToggle={() => setExpandedId(expandedId === h.id ? null : h.id)}
                onApprove={() => approve(h.id)}
                onReject={() => reject(h.id)}
                onRemove={() => remove(h.id)}
                showActions
                posting={posting === h.id}
              />
            ))}
            {handoffs
              .filter((h) => processing === h.id)
              .map((h) => (
                <HandoffCard
                  key={h.id}
                  h={h}
                  expanded={false}
                  onToggle={() => {}}
                  processing
                  posting={posting === h.id}
                />
              ))}
          </div>
        )}

        {/* RELEASED */}
        {view === "released" && (
          <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
            {released.length === 0 && (
              <div style={{ textAlign: "center", color: "#333", padding: 40, fontSize: 12 }}>
                No released atoms yet.
              </div>
            )}
            {released.map((h) => (
              <HandoffCard
                key={h.id}
                h={h}
                expanded={expandedId === h.id}
                onToggle={() => setExpandedId(expandedId === h.id ? null : h.id)}
                onRemove={() => remove(h.id)}
                posting={posting === h.id}
              />
            ))}
          </div>
        )}

        {/* FULL LOG */}
        {view === "log" && (
          <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
            {handoffs.length === 0 && (
              <div style={{ textAlign: "center", color: "#333", padding: 40, fontSize: 12 }}>
                No handoffs yet.
              </div>
            )}
            {handoffs.map((h) => (
              <HandoffCard
                key={h.id}
                h={h}
                expanded={expandedId === h.id}
                onToggle={() => setExpandedId(expandedId === h.id ? null : h.id)}
                onApprove={
                  h.status === "pending" && h.gateIndex === 5 ? () => approve(h.id) : null
                }
                onReject={
                  h.status === "pending" && h.gateIndex === 5 ? () => reject(h.id) : null
                }
                onRemove={() => remove(h.id)}
                showActions={h.status === "pending" && h.gateIndex === 5}
                processing={processing === h.id}
                posting={posting === h.id}
              />
            ))}
          </div>
        )}
      </div>

      <style>{`
        @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.3} }
        * { box-sizing: border-box; }
        ::-webkit-scrollbar { width: 3px; }
        ::-webkit-scrollbar-thumb { background: #1a1a2e; border-radius: 2px; }
        textarea { scrollbar-width: thin; }
        select option { background: #0d0d18; }
      `}</style>
    </div>
  );
}

/* ─────────────────────────────────────────────────────────────── */
/* HandoffCard                                                      */
/* ─────────────────────────────────────────────────────────────── */

function HandoffCard({
  h,
  expanded,
  onToggle,
  onApprove,
  onReject,
  onRemove,
  showActions = false,
  processing = false,
  posting = false,
}) {
  const statusColor = {
    pending: "#f59e0b",
    released: "#00ff88",
    rejected: "#ff4444",
  }[h.status] ?? "#555";

  const isAwaitingHuman = h.status === "pending" && h.gateIndex === 5;
  const isProcessing = processing || posting;

  return (
    <div
      style={{
        background: isAwaitingHuman ? "#100e00" : "#0d0d18",
        border: `1px solid ${isAwaitingHuman ? "#f59e0b44" : "#1a1a2e"}`,
        borderRadius: 8,
        overflow: "hidden",
        transition: "all 0.15s",
        opacity: isProcessing ? 0.7 : 1,
      }}
    >
      {/* Header row */}
      <div
        onClick={onToggle}
        style={{
          padding: "10px 12px",
          cursor: "pointer",
          display: "flex",
          alignItems: "center",
          gap: 8,
        }}
      >
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontSize: 10, color: "#444", marginBottom: 3 }}>
            {h.source} · {h.category} ·{" "}
            {new Date(h.timestamp).toLocaleTimeString([], {
              hour: "2-digit",
              minute: "2-digit",
            })}
          </div>
          <div
            style={{
              fontSize: 11,
              color: "#888",
              overflow: "hidden",
              whiteSpace: "nowrap",
              textOverflow: "ellipsis",
            }}
          >
            {h.content.slice(0, 80)}
            {h.content.length > 80 ? "…" : ""}
          </div>
        </div>

        <div style={{ flexShrink: 0, display: "flex", alignItems: "center", gap: 6 }}>
          {isProcessing && (
            <span
              style={{
                fontSize: 9,
                color: "#00ff88",
                animation: "pulse 1.2s infinite",
              }}
            >
              {posting ? "RELEASING…" : "GATES…"}
            </span>
          )}
          <div
            style={{
              fontSize: 9,
              padding: "2px 7px",
              borderRadius: 10,
              border: `1px solid ${statusColor}55`,
              color: statusColor,
              background: `${statusColor}11`,
              letterSpacing: "0.04em",
            }}
          >
            {h.status.toUpperCase()}
          </div>
          <span style={{ color: "#333", fontSize: 10 }}>{expanded ? "▾" : "▸"}</span>
        </div>
      </div>

      {/* Expanded body */}
      {expanded && (
        <div style={{ borderTop: "1px solid #111", padding: "12px 14px" }}>
          <div
            style={{
              fontSize: 11,
              color: "#bbb",
              lineHeight: 1.65,
              whiteSpace: "pre-wrap",
              marginBottom: 14,
              maxHeight: 220,
              overflowY: "auto",
            }}
          >
            {h.content}
          </div>

          <div
            style={{
              display: "flex",
              flexWrap: "wrap",
              gap: 10,
              fontSize: 9,
              color: "#444",
              marginBottom: 12,
            }}
          >
            <span>id: {h.id}</span>
            <span>conf: {h.confidence}</span>
            {h.session_id && <span>session: {h.session_id}</span>}
            {h.phrasing_note && (
              <span style={{ color: "#a78bfa" }}>note: {h.phrasing_note}</span>
            )}
          </div>

          {/* Gate progress */}
          <div style={{ marginBottom: 14 }}>
            <div
              style={{
                fontSize: 9,
                color: "#333",
                letterSpacing: "0.08em",
                marginBottom: 6,
              }}
            >
              GATE PROGRESS
            </div>
            <div style={{ display: "flex", flexWrap: "wrap", gap: 4, alignItems: "center" }}>
              {GATES.map((g, i) => {
                const passed = h.gateIndex > i || h.status === "released";
                const current = h.gateIndex === i && h.status === "pending";
                const failed = h.gateResults?.some(
                  (r) => r.gate === g.id && r.result?.includes("reject")
                );

                let color = "#333";
                let border = "#1a1a2e";
                if (passed) {
                  color = "#00ff88";
                  border = "#00ff8844";
                } else if (current) {
                  color = "#f59e0b";
                  border = "#f59e0b66";
                } else if (failed) {
                  color = "#ff4444";
                  border = "#ff444466";
                }

                return (
                  <div key={g.id} style={{ display: "flex", alignItems: "center", gap: 4 }}>
                    <div
                      style={{
                        fontSize: 9,
                        padding: "3px 7px",
                        borderRadius: 4,
                        background: passed || current ? "#0d1a12" : "#111",
                        border: `1px solid ${border}`,
                        color,
                      }}
                    >
                      G{g.num} {g.name}
                    </div>
                    {i < GATES.length - 1 && (
                      <span style={{ color: "#222", fontSize: 9 }}>→</span>
                    )}
                  </div>
                );
              })}
            </div>
          </div>

          {/* Action buttons */}
          {(showActions || onRemove) && (
            <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
              {showActions && onApprove && (
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    onApprove();
                  }}
                  disabled={posting}
                  style={{
                    flex: 1,
                    minWidth: 90,
                    padding: "8px 12px",
                    borderRadius: 6,
                    border: "1px solid #00ff88",
                    background: "#0d1a12",
                    color: "#00ff88",
                    fontSize: 10,
                    cursor: posting ? "wait" : "pointer",
                    letterSpacing: "0.06em",
                    opacity: posting ? 0.6 : 1,
                  }}
                >
                  {posting ? "RELEASING…" : "APPROVE → BRAIN"}
                </button>
              )}

              {showActions && onReject && (
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    onReject();
                  }}
                  style={{
                    padding: "8px 12px",
                    borderRadius: 6,
                    border: "1px solid #ff444466",
                    background: "#1a0a0a",
                    color: "#ff6666",
                    fontSize: 10,
                    cursor: "pointer",
                    letterSpacing: "0.06em",
                  }}
                >
                  REJECT
                </button>
              )}

              {onRemove && (
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    onRemove();
                  }}
                  style={{
                    padding: "8px 12px",
                    borderRadius: 6,
                    border: "1px solid #1a1a2e",
                    background: "transparent",
                    color: "#444",
                    fontSize: 10,
                    cursor: "pointer",
                  }}
                >
                  REMOVE
                </button>
              )}
            </div>
          )}
        </div>
      )}
    </div>
  );
}
