# Steadfast5e - Award Treasure XP

Part of the [Steadfast5e](https://forge.fantasygrounds.com/) suite for grittier, OSR-style 5E play.

Adds the classic OSR "XP for gold" house rule: bonus party XP derived from the GP value of treasure recovered, on top of normal monster-kill XP.

---

## Why

5E has no numeric treasure tracking to build this on top of — an NPC's `treasure` field and an item's `cost` field are both free text (e.g. "2d6 gp, treasure type A"), and CoreRPG's Parcel record type exists but 5E never uses it. So rather than trying to hook into an XP calculation that doesn't have any treasure data flowing through it, this is a small standalone tool: type in a GP amount, pick a ratio, award the XP.

## How It Works

Run `/goldxp` to open the tool. Enter the GP value of treasure recovered, choose a ratio (1/2/5/10 GP per XP — 1:1 matches classic OSR pacing; the coarser ratios are there for 5E's much larger DMG treasure hoards), and click **Award to Party**.

The XP total (`floor(GP / ratio)`) is handed straight to `PartyXPManager.awardXP()` — the same function CoreRPG's own Battle/Quest "Award" buttons call — so it inherits the exact same behavior: split evenly across the current party, remainder to the last member, written to each PC's `exp` field. A confirmation is posted to chat, e.g.:

```
Awarded 1500 XP for treasure (1500 GP @ 1:1), split across the party.
```

## Compatibility

- D&D 5E 2014 (Legacy) and 2024
- No stock ruleset file is touched — `goldxp` is a brand-new, non-record-backed tool window (modeled on CoreRPG's own Manual Rolls tool), reusing the existing `PartyXPManager.awardXP()` function rather than reimplementing party-XP-splitting

## Installation

Drop the `steadfast5e_goldxp` folder into your Fantasy Grounds Unity `extensions/` directory and enable it when loading a 5E campaign.
