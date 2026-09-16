# Rebuild Layers & Seed Heritage — May–July 2026

Documented under organism-lineage-preserver.  
These layers are preserved as heritage. They are not erased.

## Layer 1 — Zip Dump Era (May 2026)
- Initial commit of three binary archives into fanz-agent-systems- (and related repos).
- Systems co-located but not yet separated:
  - FanzSpot HQ remnants (Next.js 14, older Anthropic SDK)
  - FanzSpot Labs v2 (Vite + React 19 + Express, identity confusion across 4 names)
  - Fanz Resume Builder (cleanest, self-contained, contains real personal resume data)
- Binary zips remain in git history (history rewrite required for removal).
- Status at capture: historical artifact. Disposition still open.

## Layer 2 — Brain Harvest Attempts (June 2026)
- GitHub Actions workflow + harvest.js added then paused with message "pause: brain harvest - fixing server".
- Parallel pause observed in fanz-refinery on the same message.
- Dual MCP endpoints surfaced (Vercel instance vs Railway production instance).
- Atom count snapshots diverged (642 vs 812 at different points).
- Status: paused / incomplete. Workflow deleted in places; orphaned script remains.

## Layer 3 — FanzAgent Posting System (July 2026)
- New TypeScript src/ on feature branch (claude/... ) for Instagram / Facebook / TikTok scheduled posting.
- 18-point technical audit and full forensic inventory performed.
- High-severity items: no file locking (race conditions), unguarded JSON.parse, 0% tests, no deployment config, token in query params, main branch lagging.
- TECHNICAL_BASELINE.md written with 36 findings and 10 Must-Fix-Before-Production items.
- Status: built, compiles, not yet production-safe. Production Gate Checklist unresolved.

## Layer 4 — Canvas & Warehouse Systems (July 2026)
- warehouse.html — fully functional neumorphic Warehouse with Railway API, tenants, builds, Lock & Execute.
- canvas-template.html — 12-slot blank neon-charcoal canvas engine (drag, lock, expand).
- the-one-title.html — extruded "THE ONE" title with mouse parallax.
- session-breakdown.md — full capture of design techniques and architectural vision.
- Status: design + functional foundation complete. Ready for Command Center integration.

## Layer 5 — Unified HQ (the-one-unified.html)
- Single-file living visual Index of Flow / Command Center.
- Brain queries wired to production Railway MCP.
- Fanzo + Echo + Brain personas, deploy visualization, terminal, map, architecture graphs.
- Gaps remaining: heritage panel, full dynamic repo catalog, non-randomized status, direct lineage link.

## Permanent Open Gaps (to be filled with evidence only)
- Exact names and purposes of the three Refineries.
- Complete categorization of all ~60–63 repos by container type.
- Verified live status for every deploy.
- Brain MCP Stripe wiring status.
- Warehouse as first-class node inside Command Center.
- 12-slot canvas population with real project containers.
- Governance containers instantiated per product type.
- Canonical atom count and phase (Platinum 3x) reconciliation across surfaces.

## Disposition Rules
- Binary archives: Owner decision required (keep in history vs filter-repo rewrite).
- Real resume data: Confirm private vs public intent before any public deployment.
- Dual MCP endpoints: Declare canonical instance.
- Paused harvest: Revive, retire, or move to dedicated infra.
- All changes require Hand-off MD + gate passage.