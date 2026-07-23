# Steadfast5e - HP Debloat

Part of the Steadfast5e suite for grittier, OSR-style 5E play.

Compresses hit point totals for player characters and NPCs, making combat more lethal and resource management more meaningful at all levels.

## Formula

**Level 1:** Hit die maximum + CON modifier (same as standard 5E)

**Each level beyond 1st:** Hit die maximum ÷ 2, no additional CON modifier

| Class | Hit Die | Level 1 HP (CON +0) | Per Level Beyond 1st |
|-------|---------|---------------------|----------------------|
| Barbarian | d12 | 12 | +6 |
| Fighter, Paladin, Ranger | d10 | 10 | +5 |
| Cleric, Druid, Monk, Rogue, Warlock, Bard | d8 | 8 | +4 |
| Sorcerer, Wizard | d6 | 6 | +3 |

Multiclass characters use whichever class produces the highest total HP as the level 1 class. Feats and racial features that grant HP per level (Tough, Dwarven Toughness, Draconic Resilience) stack on top automatically.

## How to Use

1. Enable the extension and load a 5E campaign — max HP recalculates automatically for all affected characters, with current HP adjusted proportionally.
2. Adjust which creature types are affected (PCs, NPCs, Monsters) and whether level-up HP is applied automatically or requires a chat prompt, in Options → House Rules.

## Compatibility

- D&D 5E 2014 (Legacy) and 2024
- Compatible with other Steadfast5e extensions
