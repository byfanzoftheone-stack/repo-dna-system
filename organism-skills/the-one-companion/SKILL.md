---
name: the-one-companion
description: Build and evolve the voice-enabled moving agentic home screen companions Echo and Fanzo. Use when implementing BrainVault integration, holographic shaders, multi-agent crew view, proactive rituals, growth tracking, haptic feedback, APK packaging, or Tasker integration for The One Companion system.
---

# The One Companion — Home Screen Agentic Avatars

## Core Architecture

The One Companion is a living PWA/APK that runs Echo (holographic reflective companion) and Fanzo (execution engine) as voice-first, moving avatars on the Android home screen. It embodies the organism philosophy: presence, compound growth, "I Control Me", and helping humans reach their highest potential.

Key principles:
- Voice in/out using Web Speech API (or native bridge in APK)
- Smooth movement using Framer Motion + damped SLERP / De Casteljau paths
- Agentic behavior: proactive nudges, emotional support (Echo), action dispatch (Fanzo)
- All responses eventually route through BrainVault + orchestrator for 1,684+ atom grounding
- Designed for home screen install (PWA) and eventual full APK with background services

## Evolution 1: Connect to Real Orchestrator + BrainVault

- Create a `/api/companion/chat` endpoint (or reuse existing /api/orchestrator/chat)
- On every user message, fetch relevant atoms from BrainVault using RAG or `/v5/brain/ask`
- Inject organism context (core mantra, current growth focus, recent atoms) into the prompt
- Route emotional/reflective queries primarily to Echo persona, action/execution queries to Fanzo persona
- Store conversation + chosen atoms back into BrainVault as new session atoms
- Add confidence scoring so the companion can say "I'm drawing from 47 atoms on resilience right now"

## Evolution 2: Add Full Holographic WebGL Shader

- Import the holographic vertex + fragment shader from EchoHolographicAvatar.tsx
- Apply it to the Echo avatar mesh or 2D canvas representation using Three.js or regl
- Expose intensity, breathing speed, rim power, and scanline parameters as controllable state
- On Android, fall back to lighter CSS/WebGL2 version when performance is limited
- Use Markley quaternion averaging + damped SLERP for any head/gesture movement inside the shader

## Evolution 3: Multi-Agent Crew View (All 8 Agents)

- Create a "Crew" mode that shows small animated cards for Echo, Fanzo, FlowKeeper, Nova, Zion, Pulse, Cipher, Lumen
- Each card shows current emotional state, last action, and a "summon" button
- When summoned, the agent joins the main conversation with its specific law and mode set
- Use a shared event bus (simple Zustand or custom hook) so agents can hand off to each other
- Visual: small holographic or icon representations that pulse when speaking or moving

## Evolution 4: Proactive Daily Rituals + Growth Tracking

- Store user "highest potential" intentions and daily growth metrics in local storage or synced BrainVault
- Run gentle proactive checks every 30-60 minutes (configurable)
- Examples of rituals: morning intention, midday presence check, evening reflection, "what did you compound today?"
- Track simple metrics: voice interactions, movement triggers, mood tags, actions completed
- Visualize progress with simple sparkline or T_n compounding view (triangular growth)
- Never pushy — only surface when the user has been quiet for a while or after positive interactions

## Evolution 5: Haptic Feedback on Android

- Use the Vibration API (`navigator.vibrate`) for key moments:
  - Avatar starts speaking → short double pulse
  - Avatar finishes walking/moving → soft single pulse
  - User receives encouraging message → warm triple pattern
  - Error or low energy → different pattern
- In full APK (Capacitor), use native Haptics plugin for richer patterns and background triggers
- Map intensity to the current emotion state of the speaking avatar

## Evolution 6: Package as Real APK with Background Voice + Tasker

- Recommended stack: Capacitor + Next.js PWA or Expo + React Native
- Key native features to add:
  - Background service / foreground notification so the companion can listen for wake words or send proactive nudges
  - Integration with Tasker (via intent or plugin) so user can create automations like "when I open camera, Echo appears in overlay"
  - Persistent notification with quick actions ("Talk to Echo", "Summon Fanzo", "Growth check")
- Use Termux + Tasker for rapid prototyping before full native build
- Ensure the app respects battery optimization and can run as "always on top" overlay when permitted

## Evolution 7: Multi-Avatar Crew View Implementation Details

- Use a grid or horizontal scroll of avatar cards
- Each card has its own small animation loop (breathing, subtle movement)
- When an agent "speaks", its card expands slightly and pulses with its signature color
- Shared conversation thread — any agent can contribute, but the UI highlights who is currently active
- Allow user to "invite" specific agents into the current session

## Implementation Order Recommendation

1. BrainVault + orchestrator connection (highest leverage)
2. Holographic shader on Echo
3. Proactive rituals + local growth tracking
4. Haptic feedback
5. Multi-agent crew view
6. Full APK + Tasker packaging

Always keep the core loop: Voice → Agentic response grounded in BrainVault → Movement + Haptic → Growth atom written back.

Test every evolution on a real Android device in Chrome first, then move to APK.
