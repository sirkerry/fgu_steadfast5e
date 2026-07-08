# Steadfast5e - Location System

![Steadfast5e - Location System](forge/steadfast5e_ls.png)

**FG Forge Listing:** not yet published

Part of the [Steadfast5e](https://forge.fantasygrounds.com/) suite for grittier, OSR-style 5E play.

Adds tier-based location tagging (Urban/Rural/Wilderness/Dungeon) and exposes per-tier rest and recovery overrides to other Steadfast5e extensions. **This extension has no mechanical effect on its own** — it's a settings provider that [Steadfast5e - Gritty Realism Rest](../steadfast5e_grr/) (and potentially future Steadfast5e extensions) reads from when deciding how rest recovery should behave.

---

## Why

Gritty Realism Rest applies one global rest-recovery rule to the whole table. In practice, how forgiving rest should be usually depends on *where* the party is — recovering in a warm inn should work differently than recovering in a monster-infested dungeon. Location System lets you configure four difficulty tiers once, then just tell it which tier is currently active; everything else (GRR's HD recovery checks, HP recovery amounts) adjusts automatically without touching GRR's own settings.

## The Four Tiers

Each tier has its own set of overrides, configured independently in the Options panel:

| Tier | HD Recovery Save DC | Save: Pass | Save: Fail | Long Rest HP Recovery |
|------|---------------------|------------|------------|------------------------|
| **Urban** | DC 10 | Half HD | Quarter HD | Full (RAW) |
| **Rural** | DC 12 | Half HD | Quarter HD | Three-Quarters |
| **Wilderness** | DC 15 | Quarter HD | No HD | Half |
| **Dungeon** | DC 20 | Quarter HD | No HD | Quarter |

These are just the shipped defaults — every value above is independently configurable per tier in **Options → Steadfast5e - Location System**. Each setting can also be set to **Defer (GRR)**, which tells Gritty Realism Rest to fall back to its own global option instead of using a tier override for that specific setting — useful if you only want to override, say, HP recovery per-tier but leave HD recovery checks as one global rule everywhere.

## Setting the Active Tier

The GM sets the party's current tier on the **Location** tab of the Party Sheet (host-only — the tab doesn't appear for players). It's a plain text field:

```
urban / rural / wilderness / dungeon   (blank = inactive)
```

Leaving it blank deactivates Location System entirely — Gritty Realism Rest (and anything else built against this API) falls back to its own global settings as if Location System weren't installed. There's no automation moving the party between tiers; the GM types the tier that matches the current scene.

## Tagging Location Records

This extension also adds a **Steadfast5e Tier** field to the ruleset's own Location record sheet, so you can label individual locations in your campaign (e.g. tag "The Rusty Anchor Inn" as `urban`, "The Sunken Crypt" as `dungeon`). This field is reference-only — it's there so you can look up a location and see at a glance which tier it should be, but it does **not** automatically set the active tier on the party sheet. You still set that yourself when the party arrives.

## For Extension Authors

Location System registers a global Lua table, `S5E_LocationSystem`, exposing:

- `isActive()` — `true` if a valid tier is currently set on the party sheet.
- `getActiveTier()` — returns `"urban"`, `"rural"`, `"wilderness"`, `"dungeon"`, or `nil`.
- `getTierValue(sKey)` — returns the current tier's configured value for `sKey`, or `nil` if that setting is deferred (or no tier is active). Valid keys: `"hd_check_dc"` (number), `"hd_check_pass"`, `"hd_check_fail"`, `"hp_recovery"` (strings matching the option values above).

Callers should always check `isActive()`/handle a `nil` return and fall back to their own defaults — this is exactly how Gritty Realism Rest itself uses the API (see `getLocationOverride()` in its `manager_se_grr.lua`).

## Compatibility

- D&D 5E 2014 (Legacy) and 2024
- Works standalone (the party sheet tab and location field appear either way) — the tier settings only do something once a dependent extension (like Gritty Realism Rest) is also loaded
- Part of the Steadfast5e suite

## Installation

Drop the `steadfast5e_ls` folder into your Fantasy Grounds Unity `extensions/` directory and enable it when loading a 5E campaign.
