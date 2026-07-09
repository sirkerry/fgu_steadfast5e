--
-- Steadfast5e - Exploding Damage
--
-- Classic exploding-dice house rule: when a damage die rolls its maximum
-- value, reroll it and add the new result, repeating if it explodes
-- again. Applies to all damage rolls - weapons and spells alike.
--
-- Unlike the 2E version of this extension, 5E's own manager_action_damage.lua
-- does not define its own performRoll/getRoll wrappers at all - every 5E
-- damage roll (PC/NPC weapon attacks via char_weapon.lua/ct_power.lua,
-- and spell/power damage via manager_power.lua) calls CoreRPG's
-- ActionDamageD20.performRoll/getRoll directly. And ActionDamageD20's own
-- performRoll body calls "ActionDamageD20.getRoll(rActor, rAction)" fully
-- qualified through the same alias table (CoreRPG/scripts/manager_action_damage_d20.lua),
-- not a bare local call - so patching ActionDamageD20.getRoll alone
-- covers every damage path in one place, with no risk of missing a
-- second call site the way the 2E version initially did.
--
-- We flag every clause in rAction.clauses with bExplodeCompound = true
-- before delegating to the original getRoll. CoreRPG's own dice builder
-- (DiceRollManager.addDamageDice, called from within getRoll) reads that
-- flag per clause and sets each die's native "e!" (compound explode)
-- mode - the same ruleset-agnostic mechanism 4E's "Vorpal" weapon
-- property and Shadowdark's "Momentum" feature use. No custom
-- reroll/recursion logic needed - FGU's dice engine handles it.
--
-- Known limitation: 5E's default critical-hit dice-doubling
-- (ActionDamageD20.applyModCriticalDoubleDice) does not thread
-- bExplodeCompound through to the doubled dice, so on a critical hit the
-- extra doubled dice won't themselves explode - only the original dice
-- will. This is a gap in that stock CoreRPG function, not something
-- fixable here without editing a shared CoreRPG file.
--

local Original_ActionDamageD20_getRoll = nil;

local function getRoll(rActor, rAction)
	for _, tClause in ipairs(rAction.clauses or {}) do
		tClause.bExplodeCompound = true;
	end
	return Original_ActionDamageD20_getRoll(rActor, rAction);
end

function onInit()
	Original_ActionDamageD20_getRoll = ActionDamageD20.getRoll;
	ActionDamageD20.getRoll = getRoll;
end
