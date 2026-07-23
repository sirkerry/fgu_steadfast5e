# Steadfast5e - Gritty Realism Rest

Part of the Steadfast5e suite for grittier, OSR-style 5E play.

Overhauls 5E rest and recovery to create meaningful attrition: configurable short/long rest durations, a CON save gating how many Hit Dice you recover after a long rest, fractional HP recovery, and independent scope controls per creature type.

## Rest Durations

Both are independent options, configurable in Options → House Rules:

| Short Rest | Long Rest |
|---|---|
| 1 Hour (RAW) *(default)* | 8 Hours (RAW) *(default)* |
| 4 Hours | 1 Day |
| 8 Hours | 3 Days |
| | 7 Days |

## Hit Dice Recovery Save

On by default. Finishing a long rest rolls a CON saving throw against a configurable DC, then recovers a fraction of the character's total Hit Dice based on pass or fail — not simply half.

| Setting | Default | Options |
|---|---|---|
| HD Recovery Save DC | DC 15 | DC 10 / DC 15 / DC 20 |
| On a Pass | Half HD | Full / Half / Quarter |
| On a Fail | Quarter HD | Half / Quarter / No HD |

## Long Rest HP Recovery

Independent of the HD check — a long rest restores a configurable fraction of max HP instead of a full heal: Full (RAW, default) / Three-Quarters / Half / Quarter.

## Scope

Each creature type can be turned on or off independently (all default on): Player Characters, NPCs (GM-controlled companions/hirelings), and Monsters (Combat Tracker-only statblocks).

## How to Use

1. Enable the extension and load a 5E campaign.
2. Adjust rest durations, the HD Recovery Save settings, HP Recovery fraction, and scope toggles in Options → House Rules — changes take effect immediately.
3. Rest as normal; a long rest posts the CON save result and recovered Hit Dice to chat.

If Steadfast5e - Location System is also installed and active, this extension automatically uses the current location tier's recovery settings instead of its own global ones.

## Compatibility

- D&D 5E 2014 (Legacy) and 2024
- Compatible with other Steadfast5e extensions, including optional Location System integration
