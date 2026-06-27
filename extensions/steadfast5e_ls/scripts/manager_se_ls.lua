--
-- Steadfast5e - Location System
-- Registered as global "S5E_LocationSystem" via loader.xml.
--
-- Exposes a tier-based override API for other Steadfast5e extensions.
-- Dependent extensions call isActive() before using getTierValue().
--

-- ── Constants ─────────────────────────────────────────────────────────────────

local VALID_TIERS = { urban = true, rural = true, wilderness = true, dungeon = true };

local TIER_CODES = { urban = "URB", rural = "RUR", wilderness = "WILD", dungeon = "DNG" };

-- Maps the public API key names to option key suffixes
local KEY_SUFFIX = {
	hd_check_dc   = "DC",
	hd_check_pass = "PASS",
	hd_check_fail = "FAIL",
	hp_recovery   = "HP",
};

local DC_VALUES = { dc10 = 10, dc12 = 12, dc15 = 15, dc20 = 20 };

-- ── Init ──────────────────────────────────────────────────────────────────────

function onInit()
	registerOptions();
	if Session.IsHost and WindowTabManager then
		WindowTabManager.registerTab("partysheet_host", {
			sName   = "s5e_ls",
			sTabRes = "tab_s5e_ls",
			sClass  = "ps_s5e_ls",
		});
	end
end

-- ── Public API ────────────────────────────────────────────────────────────────

function isActive()
	return (getActiveTier() ~= nil);
end

function getActiveTier()
	local sRaw = DB.getValue("partysheet.s5e_tier", "");
	local sTier = sRaw:lower():match("^%s*(.-)%s*$");
	return VALID_TIERS[sTier] and sTier or nil;
end

-- Returns the tier-configured value for sKey, or nil to defer to caller's own setting.
-- sKey: "hd_check_dc" (returns number) | "hd_check_pass" | "hd_check_fail" | "hp_recovery"
function getTierValue(sKey)
	local sTier = getActiveTier();
	if not sTier then return nil; end

	local sTierCode = TIER_CODES[sTier];
	local sSuffix   = KEY_SUFFIX[sKey];
	if not sTierCode or not sSuffix then return nil; end

	local sOptKey = "LS_" .. sTierCode .. "_" .. sSuffix;
	local sVal    = OptionsManager.getOption(sOptKey) or "";

	if sVal == "" or sVal == "none" then return nil; end

	if sKey == "hd_check_dc" then
		return DC_VALUES[sVal];
	end

	return sVal;
end

-- ── Option registration ───────────────────────────────────────────────────────

function registerOptions()
	local sGrp = "option_header_ls";

	local function buildOpt(sDefault, tAllVals, sResPrefix)
		local tOther, sLabels, sVals = {}, "", "";
		for _, v in ipairs(tAllVals) do
			if v ~= sDefault then tOther[#tOther + 1] = v; end
		end
		for i, v in ipairs(tOther) do
			local sep = i > 1 and "|" or "";
			sLabels = sLabels .. sep .. sResPrefix .. v;
			sVals   = sVals   .. sep .. v;
		end
		return {
			baselabelres = sResPrefix .. sDefault,
			baseval      = sDefault,
			labelsres    = sLabels,
			values       = sVals,
			default      = sDefault,
		};
	end

	local DC   = {"dc10", "dc12", "dc15", "dc20", "none"};
	local PASS = {"full", "half", "quarter", "none"};
	local FAIL = {"half", "quarter", "zero", "none"};
	local HP   = {"full", "threequarters", "half", "quarter", "none"};

	local function reg(sKey, tOpt)
		OptionsManager.registerOptionData({ sKey = sKey, sGroupRes = sGrp, tCustom = tOpt });
	end

	-- Urban: DC 10, Pass Half, Fail Quarter, HP Full
	reg("LS_URB_DC",   buildOpt("dc10",    DC,   "option_val_LS_DC_"));
	reg("LS_URB_PASS", buildOpt("half",    PASS, "option_val_LS_HD_"));
	reg("LS_URB_FAIL", buildOpt("quarter", FAIL, "option_val_LS_HD_"));
	reg("LS_URB_HP",   buildOpt("full",    HP,   "option_val_LS_HP_"));

	-- Rural: DC 12, Pass Half, Fail Quarter, HP Three-Quarters
	reg("LS_RUR_DC",   buildOpt("dc12",         DC,   "option_val_LS_DC_"));
	reg("LS_RUR_PASS", buildOpt("half",          PASS, "option_val_LS_HD_"));
	reg("LS_RUR_FAIL", buildOpt("quarter",       FAIL, "option_val_LS_HD_"));
	reg("LS_RUR_HP",   buildOpt("threequarters", HP,   "option_val_LS_HP_"));

	-- Wilderness: DC 15, Pass Quarter, Fail Zero, HP Half
	reg("LS_WILD_DC",   buildOpt("dc15",    DC,   "option_val_LS_DC_"));
	reg("LS_WILD_PASS", buildOpt("quarter", PASS, "option_val_LS_HD_"));
	reg("LS_WILD_FAIL", buildOpt("zero",    FAIL, "option_val_LS_HD_"));
	reg("LS_WILD_HP",   buildOpt("half",    HP,   "option_val_LS_HP_"));

	-- Dungeon: DC 20, Pass Quarter, Fail Zero, HP Quarter
	reg("LS_DNG_DC",   buildOpt("dc20",    DC,   "option_val_LS_DC_"));
	reg("LS_DNG_PASS", buildOpt("quarter", PASS, "option_val_LS_HD_"));
	reg("LS_DNG_FAIL", buildOpt("zero",    FAIL, "option_val_LS_HD_"));
	reg("LS_DNG_HP",   buildOpt("quarter", HP,   "option_val_LS_HP_"));
end
