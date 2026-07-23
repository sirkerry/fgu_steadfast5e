# Steadfast5e - Location System

Part of the Steadfast5e suite for grittier, OSR-style 5E play.

Adds tier-based location tagging (Urban/Rural/Wilderness/Dungeon) and exposes per-tier rest and recovery overrides to other Steadfast5e extensions. This extension has no mechanical effect on its own — it's a settings provider that Steadfast5e - Gritty Realism Rest reads from when deciding how rest recovery should behave.

## The Four Tiers

Each tier has its own configurable overrides:

| Tier | HD Recovery Save DC | Save: Pass | Save: Fail | Long Rest HP Recovery |
|------|---------------------|------------|------------|------------------------|
| Urban | DC 10 | Half HD | Quarter HD | Full (RAW) |
| Rural | DC 12 | Half HD | Quarter HD | Three-Quarters |
| Wilderness | DC 15 | Quarter HD | No HD | Half |
| Dungeon | DC 20 | Quarter HD | No HD | Quarter |

Every value is independently configurable in Options → Steadfast5e - Location System. Any setting can also be set to "Defer," which falls back to Gritty Realism Rest's own global setting instead of a tier override.

## How to Use

1. Enable the extension and load a 5E campaign.
2. Set the party's current tier on the **Location** tab of the Party Sheet (host-only) — type `urban`, `rural`, `wilderness`, or `dungeon`. Leaving it blank deactivates tier overrides entirely.
3. Optionally, tag individual Location records with a **Steadfast5e Tier** field for reference (this doesn't set the active tier automatically — it's just a label to look up).
4. With Gritty Realism Rest also installed, its rest recovery settings automatically use the active tier's values instead of its own global settings.

## Compatibility

- D&D 5E 2014 (Legacy) and 2024
- Works standalone — the tier settings only take effect once a dependent extension (like Gritty Realism Rest) is also installed
- Part of the Steadfast5e suite
