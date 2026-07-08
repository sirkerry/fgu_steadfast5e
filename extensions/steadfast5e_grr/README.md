# Steadfast5e - Gritty Realism Rest

![Steadfast5e - Gritty Realism Rest](forge/steadfast5e_grr.png)

**FG Forge Listing:** not yet published

Part of the [Steadfast5e](https://forge.fantasygrounds.com/) suite for grittier, OSR-style 5E play.

Overhauls 5E rest and recovery to create meaningful attrition: configurable short/long rest durations, a CON save gating how many Hit Dice you recover after a long rest, fractional HP recovery, and independent scope controls per creature type. Reads per-location overrides from [Steadfast5e - Location System](../steadfast5e_ls/) when it's installed and active.

---

## Why

Standard 5E rest (8-hour long rest = full HP and half your Hit Dice back, every day, anywhere) makes resource attrition nearly meaningless once the party can rest freely. Gritty Realism Rest (GRR) is a self-contained toolkit for dialing that back: stretch rest durations to force real in-fiction cost for resting, and/or gate recovery behind a die roll and a fractional-return table instead of an automatic full refill.

## How It Works

GRR hooks `GameManager.onActorRest` — the same function FGU calls for every rest, for every actor — and wraps it rather than replacing it, so exhaustion, conditions, spell slot recovery, and anything else the base rules (or other extensions) already do on rest still happens normally. GRR only changes two things, and only on a **long** rest:

1. **HP recovery** — if the configured recovery is anything other than Full, GRR overwrites the wounds FGU's own rest logic just set, restoring only the configured fraction of max HP instead.
2. **HD recovery** — if the HD Recovery Save is enabled, GRR undoes the Hit Dice FGU's own rest logic just recovered, rolls a CON save, and recovers a fraction of your *total* Hit Dice based on pass/fail instead of the RAW "recover half."

Short rests are untouched mechanically — only their duration changes.

## Rest Durations

Both are independent 3–4 way options; changing either takes effect immediately (no reload needed):

| Short Rest | Long Rest |
|---|---|
| 1 Hour (RAW) *(default)* | 8 Hours (RAW) *(default)* |
| 4 Hours | 1 Day |
| 8 Hours | 3 Days |
| | 7 Days |

## Hit Dice Recovery Save

On by default (**GRR: Long Rest HD Recovery Save**). When enabled, finishing a long rest rolls a **CON saving throw** (d20 + CON modifier, plus proficiency bonus if the character is proficient in CON saves, plus any custom CON save modifier) against a DC, then recovers a fraction of the character's *total* Hit Dice based on pass or fail — not a fraction of however many were spent.

| Setting | Default | Options |
|---|---|---|
| HD Recovery Save DC | DC 15 | DC 10 / DC 15 / DC 20 / Manual |
| On a Pass | Half HD | Full / Half / Quarter |
| On a Fail | Quarter HD | Half / Quarter / No HD |

Recovered dice are returned largest-die-first, matching FGU's own default behavior. If the character hadn't spent any Hit Dice, the check is skipped entirely and a note is posted to chat instead of a roll. Results are always posted to chat, e.g.:

```
GRR: Aldric CON Save: d20+2 = 14 vs DC 15 [Fail] -> recover 1 of 4 HD
```

**"Manual" DC** reads a numeric value from `campaign.grr_manual_dc` in the campaign database rather than a fixed DC — there's currently no options-panel control for setting it, so this mode is only usable if you (or another extension) set that value directly. Treat it as a hook for future/external tooling rather than a ready-to-use option for now.

Disabling the option entirely (**Enabled** → off) leaves Hit Dice recovery exactly as stock 5E handles it (half, no check).

## Long Rest HP Recovery

Independent of the HD check — a long rest restores this fraction of max HP instead of the RAW full heal:

| Default | Options |
|---|---|
| Full (RAW) | Full / Three-Quarters / Half / Quarter |

## Scope

Each creature type can be turned on or off independently (all default **on**):

- **Apply to Player Characters**
- **Apply to NPCs** — GM-controlled charsheet actors: companions, hirelings, sidekicks
- **Apply to Monsters** — Combat Tracker-only monster/NPC statblocks with no charsheet

Turning a scope off means GRR ignores rest events for that actor type entirely — they get stock FGU rest behavior.

## Location System Integration

If [Steadfast5e - Location System](../steadfast5e_ls/) is also loaded and a tier is currently active on the Party Sheet, GRR checks the active tier's configured value for HD Recovery DC, Pass/Fail fractions, and HP Recovery *before* falling back to its own global options above — letting the GM make rest harsher in a dungeon than in a town without touching GRR's base settings. Any individual tier setting left as **Defer (GRR)** falls through to GRR's own option instead. Location System is entirely optional; without it (or with no tier currently active), GRR just uses its own settings as documented above.

## Compatibility

- D&D 5E 2014 (Legacy) and 2024
- Compatible with other Steadfast5e extensions, including optional [Location System](../steadfast5e_ls/) integration
- Hooks `GameManager.onActorRest` by wrapping the existing function, not replacing it — plays well with other extensions that also hook rest, as long as they follow the same wrap-don't-replace pattern

## Installation

Drop the `steadfast5e_grr` folder into your Fantasy Grounds Unity `extensions/` directory and enable it when loading a 5E campaign.
