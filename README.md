# Steadfast5e

A suite of Fantasy Grounds Unity extensions for grittier, more grounded 5E play.

Published on the [FG Forge](https://forge.fantasygrounds.com) by Kerry Harrison (sirkerry).

---

## Extensions

### [Steadfast5e — Expanded Skills](extensions/steadfast5e_expanded_skills/) — [Forge listing](https://forge.fantasygrounds.com/shop/items/3422/view)
Replaces the standard 18 5E skills with 26 flat skills. Every ability score gets a broader role, scope boundaries between adjacent skills are tightened, and passive-feel redundancy is eliminated. Old proficiencies migrate automatically.

Includes a companion reference module (`modules/steadfast5e_expanded_skills/`) with descriptions, scope boundaries, example uses, and GM guidance for all 26 skills — [Forge listing](https://forge.fantasygrounds.com/shop/items/3424/view).

### [Steadfast5e — HP Debloat](extensions/steadfast5e_hp_debloat/) — [Forge listing](https://forge.fantasygrounds.com/shop/items/3421/view)
Compresses PC and NPC hit points for grittier, more lethal play. Level 1: max hit die + CON modifier. Each level beyond 1st: max hit die / 2, no additional CON.

### [Steadfast5e — Proficiency Bonus Cap +4](extensions/steadfast5e_prof_cap/) — [Forge listing](https://forge.fantasygrounds.com/shop/items/3417/view)
Slower proficiency bonus progression: +2 (levels 1–6), +3 (7–12), +4 (13+). Designed for low-fantasy, OSR-style 5E play.

### [Steadfast5e — Gritty Realism Rest](extensions/steadfast5e_grr/) — [Forge listing](https://forge.fantasygrounds.com/shop/items/3440/view)
Overhauls rest and recovery for meaningful attrition: configurable rest durations, limited HD spending, optional CON/Endurance check for HD recovery, fractional HP recovery, per-creature-type scope controls.

### [Steadfast5e — Location System](extensions/steadfast5e_ls/) — [Forge listing](https://forge.fantasygrounds.com/shop/items/3441/view)
Tier-based location tagging (Urban/Rural/Wilderness/Dungeon) that exposes per-tier rest/recovery overrides to other Steadfast5e extensions.

### [Steadfast5e — Exploding Damage](extensions/steadfast5e_expdmg/) — [Forge listing](https://forge.fantasygrounds.com/shop/items/3444/view)
Classic exploding-dice house rule for all damage rolls (weapons and spells): a die that rolls its maximum value rerolls and adds, chaining on further explosions, using FGU's native compound-explode die mode.

### [Steadfast5e — Award Treasure XP](extensions/steadfast5e_goldxp/)
The classic OSR "XP for gold" house rule. Run `/goldxp` to open a small tool, enter the GP value of treasure recovered and a ratio (1/2/5/10 GP per XP), and award the resulting XP evenly across the party — reuses the same `PartyXPManager.awardXP()` the stock Battle/Quest "Award" buttons call.

---

## Compatibility

- Fantasy Grounds Unity 4.x / 5.x
- D&D 5E 2014 (Legacy) and 2024 rulesets
- Extensions are compatible with each other

---

## dist/

Pre-packaged `.ext` and `.mod` files ready for installation. Drop `.ext` files in your FGU `extensions/` directory and the `.mod` file in your `modules/` directory.
