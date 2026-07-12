--
-- "Award Treasure XP" tool: the classic OSR "XP for gold" house rule for
-- 5E. There's no numeric treasure value anywhere in stock 5E to hook into
-- (an NPC's "treasure" field and an item's "cost" field are both free
-- text, e.g. "2d6 gp, treasure type A" -- not usable in math), so this is
-- a standalone GP-to-XP converter rather than an extension of the
-- existing Battle/Quest XP calculation.
--
-- Reuses CoreRPG_2024's own PartyXPManager.awardXP(nXP), the same
-- function the stock Battle/Quest "Award" buttons call -- it already
-- splits the total evenly across the party (remainder to the last
-- member) and writes each PC's exp field, so this tool only needs to
-- compute a number, not reimplement party-splitting.
--
function onInit()
    Comm.registerSlashHandler("goldxp", processSlash);
end

function processSlash(sCommand, sParams)
    Interface.openWindow("goldxp", "");
end

-- Ratio cycler value is the divisor ("N GP = 1 XP"); blank/unset (the
-- cycler's default label state) means the default 1:1 ratio.
function computeXP(nGP, sRatio)
    local nRatio = tonumber(sRatio) or 1;
    if nRatio < 1 then
        nRatio = 1;
    end
    return math.floor((nGP or 0) / nRatio);
end

-- Called by the window's Award button.
function awardFromWindow(nodeWindow)
    local nGP = tonumber(DB.getValue(nodeWindow, "gpamount", 0)) or 0;
    local sRatio = DB.getValue(nodeWindow, "ratio", "");
    local nRatioDisplay = tonumber(sRatio) or 1;
    local nXP = computeXP(nGP, sRatio);

    if nXP <= 0 then
        ChatManager.SystemMessage("Enter a GP amount greater than 0 to award treasure XP.");
        return;
    end

    PartyXPManager.awardXP(nXP);

    local rMessage = ChatManager.createBaseMessage(nil, nil);
    rMessage.text = rMessage.text .. string.format(
        "Awarded %d XP for treasure (%d GP @ %d:1), split across the party.",
        nXP, nGP, nRatioDisplay
    );
    Comm.deliverChatMessage(rMessage);
end
