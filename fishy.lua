local FONT = select(1, GameFontNormalSmall:GetFont())
local fb = CreateFrame"Frame"
local db

local name = string.format("%s - %s", UnitName"player", GetRealmName())

fb:RegisterEvent"ADDON_LOADED"
fb:RegisterEvent"CHAT_MSG_SPELL_ITEM_ENCHANTMENTS"
fb:RegisterEvent"SKILL_LINES_CHANGED"
fb:RegisterEvent"LOOT_OPENED"
fb:RegisterEvent"ZONE_CHANGED_NEW_AREA"
fb:RegisterEvent"ZONE_CHANGED"
fb:RegisterEvent"UNIT_INVENTORY_CHANGED"

local function Print(text)
	ChatFrame1:AddMessage(string.format("|cff33ff99Fishbringer|r: %s", text))
end

local zones = {
	["Dun Morogh"] = -70, 
	["Durotar"] = -70, 
	["Elwynn Forest"] = -70, 
	["Mulgore"] = -70,
	["Eversong Forest"] = -70, 
	["Azuremyst Isle"] = -70, 
	["Teldrassil"]  = -70, 
	["Tirisfal Glades"] = -70, 
	["Orgrimmar"] = -20, 
	["Ironforge"] = -20, 
	["Stormwind City"] = -20, 
	["Thunder Bluff"] = -20, 
	["Silvermoon City"] = -20, 
	["The Exodar"] = -20, 
	["Darnassus"] = -20, 
	["Undercity"] = -20, 
	["The Barrens"] = -20, 
	["Blackfathom Deeps"] = -20, 
	["Bloodmyst Isle"] = -20, 
	["Darkshore"] = -20, 
	["The Deadmines"] = -20, 
	["Ghostlands"] = -20, 
	["Loch Modan"] = -20, 
	["Silverpine Forest"] = -20, 
	["The Wailing Caverns"] = -20, 
	["Westfall"] = -20, 
	["Ashenvale"] = 55, 
	["Duskwood"] = 55, 
	["Hillsbrad Foothills"] = 55, 
	["Redridge Mountains"] = 55, 
	["Stonetalon Mountains"] = 55, 
	["Wetlands"] = 55, 
	["Alterac Mountains"] = 130, 
	["Arathi Highlands"] = 130, 
	["Desolace"] = 130, 
	["Dustwallow Marsh"] = 130, 
	["Scarlet Monastery"] = 130, 
	["Stranglethorn Vale"] = 130, 
	["Swamp of Sorrows"] = 130, 
	["Thousand Needles"] = 130, 
	["Azshara"] = 205, 
	["Felwood"] = 205,
	["Feralas"] = 205, 
	["The Hinterlands"] = 205, 
	["Maraudon"] = 205, 
	["Moonglade"] = 205,
	["Tanaris"] = 205, 
	["The Temple of Atal'Hakkar"] = 205, 
	["Un'Goro Crater"] = 205, 
	["Western Plaguelands"] = 205, 
	["Shadowmoon Valley"] = 280,
	["Zangarmarsh"] = 305, 
	["Burning Steppes"] = 330, 
	["Deadwind Pass"] = 330, 
	["Eastern Plaguelands"] = 330, 
	["Scholomance"] = 330, 
	["Silithus"] = 330, 
	["Stratholme"] = 330, 
	["Winterspring"] = 330, 
	["Zul'Gurub"] = 330, 
	["Terokkar Forest"] = 355,
	["Nagrand"] = 380, 
	["Netherstorm"] = 380,
	["Borean Tundra"] = 380, 
	["Dragonblight"] = 380, 
	["Howling Fjord"] = 380, 
	["Crystalsong Forest"] = 405,
	["Dalaran"] = 430, 
	["Sholazar Basin"] = 430, 
	["The Frozen Sea"] = 480,
}
local subzones = {
	["Jaguero Isle"] = 205, 
	["Bay of Storms"] = 330, 
	["Hetaera's Clutch"] = 330, 
	["Scalebeard's Cave"] = 330, 
	["Jademir Lake"] = 330, 
	["Marshlight Lake"] = 355, 
	["Sporewind Lake"] = 355,
	["Serpent Lake"] = 355, 
	["Lake Sunspring"] = 395,
	["Skysong Lake"] = 395, 
	["Blackwind Lake"] = 405,
	["Lake Ere'Noru"] = 405, 
	["Lake Jorune"] = 405,
}

local fishingpoles = { [6256] = true, [6365] = true, [6366] = true, [6367] = true, [12225] = true, [19022] = true, [19970] = true, [25978] = true, [44050] = true, }

local fishingSkill, fishingBuff, fishCaught, fishToCatch = 0
local function UpdateDatabase()
	db[name].fishingSkill = fishingSkill
	db[name].fishingBuff = fishingBuff
	db[name].fishCaught = fishCaught
	db[name].fishToCatch = fishToCatch
end

local function FishyFormula(r)
	if r <= 75 then
		return 1
	else
		return math.ceil((r - 75) / 25)
	end
end	

Fishbringer = CreateFrame("Frame", "Fishbringer", UIParent)
Fishbringer:EnableMouse(true)
Fishbringer:SetMovable(true)
Fishbringer:SetUserPlaced(true)
Fishbringer:SetHeight(150)
Fishbringer:SetWidth(185)
Fishbringer:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16, insets = {left = 4, right = 4, top = 4, bottom = 4},})
Fishbringer:SetBackdropColor(0, 0, 0, 0)
Fishbringer:SetScript("OnMouseDown", function(self) if(IsAltKeyDown()) then self:SetBackdropColor(0, 0, 0, .6) self:StartMoving() end end)
Fishbringer:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() self:SetBackdropColor(0, 0, 0, 0) end)
Fishbringer:SetPoint("CENTER")
Fishbringer:Hide()

local title = Fishbringer:CreateFontString(nil, "OVERLAY")
title:SetHeight(15)
title:SetWidth(Fishbringer:GetWidth()-10)
title:SetPoint("TOPLEFT", Fishbringer, "TOPLEFT", 3, -10)
title:SetJustifyH("CENTER")
title:SetFont(FONT, 16)
title:SetShadowOffset(1, -1)
local name
if random(100) < 10 then 
	name = "Corrupted Fishbringer"
else
	name = "Fishbringer"
end
title:SetText(name)
Fishbringer.title = title

local zone = Fishbringer:CreateFontString(nil, "OVERLAY")
zone:SetHeight(50)
zone:SetWidth(Fishbringer:GetWidth()-10)
zone:SetPoint("TOP", Fishbringer.title, "BOTTOM", 0, 0)
zone:SetJustifyH("CENTER")
zone:SetFont(FONT, 12)
zone:SetShadowOffset(1, -1)
Fishbringer.zone = zone

local catch = Fishbringer:CreateFontString(nil, "OVERLAY")
catch:SetHeight(15)
catch:SetWidth(Fishbringer:GetWidth()-10)
catch:SetPoint("TOP", Fishbringer.zone, "BOTTOM", 0, 0)
catch:SetJustifyH("CENTER")
catch:SetFont(FONT, 14)
catch:SetShadowOffset(1, -1)
Fishbringer.catch = catch

local content = Fishbringer:CreateFontString(nil, "OVERLAY")
content:SetHeight(30)
content:SetWidth(Fishbringer:GetWidth()-10)
content:SetFont(FONT, 12)
content:SetShadowOffset(1, -1)
content:SetJustifyH("CENTER")
content:SetPoint("TOP", Fishbringer.catch, "BOTTOM", 0, 0)
Fishbringer.content = content

local fish = Fishbringer:CreateFontString(nil, "OVERLAY")
fish:SetHeight(15)
fish:SetWidth(Fishbringer:GetWidth()-10)
fish:SetFont(FONT, 12)
fish:SetShadowOffset(1, -1)
fish:SetJustifyH("CENTER")
fish:SetPoint("TOP", Fishbringer.content, "BOTTOM", 0, -7)
Fishbringer.fish = fish

local function UpdateFishes(skipLoot)
	if( IsFishingLoot() and not skipLoot) then
		fishCaught = fishCaught + 1
	end
	Fishbringer.fish:SetFormattedText("%d of %d fish caught", fishCaught, fishToCatch)
	UpdateDatabase()
end

local function Fishes(f)
	fishToCatch = f
	fishCaught = 0
 	UpdateFishes(true)
end

local function UpdateZone()
	local t
	local z
	t = GetSubZoneText()
	z = subzones[t]
	if not z then 
		t = GetRealZoneText()
		z = zones[t]
	end
	if not z then
		z = 0
	end


	local max, chance
	max = z + 95
	if max == 95 then max = 0 end
	chance = ((fishingSkill + fishingBuff) - z)*0.01 + 0.05
	if z < 0 then z = 1 end
	if chance > 1 then 
		chance = 1
	elseif chance < 0 then 
		chance = 0
	end
	local colour
	if chance == 0 then
		colour = "ffff2020"
	elseif chance <= 0.5 then 
		colour = "ffff8040"
	elseif chance < 1 then 
		colour = "ffffff00"
	else
		colour = "ff40bf40"
	end
	Fishbringer.zone:SetFormattedText("\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)", colour, t, z, max, chance*100)
	Fishbringer.catch:SetFormattedText("%d%% catch rate", chance*100)
end

local function GetSkill()
	local _, _, _, fishing, _, _ = GetProfessions()
	if (fishing) then
		local name, _, rank, max, _, _, mod = GetProfessionInfo(fishing)
		return name, rank, max, mod
	end
	return 0, 0, 0, 0
end

local function UpdateSkill()
	local skillName, skillRank, skillModifier, skillMaxRank

	skillName, skillRank, skillMaxRank, skillModifier = GetSkill()

	if skillName then
		local fishNeeded = FishyFormula(skillRank)
		if skillRank ~= skillMaxRank then 
			Fishbringer.content:SetFormattedText("%d(+%d)/%d fishing skill\n%d fish needed at this level", skillRank, skillModifier, skillMaxRank, fishNeeded)
		else
			Fishbringer.content:SetFormattedText("%d(+%d) fishing skill", skillRank, skillModifier)
		end
		if fishingSkill ~= skillRank then
			fishingSkill = skillRank
			Fishes(fishNeeded)
		end
		if fishingBuff ~= skillModifier then
			fishingBuff = skillModifier
			UpdateZone()
		end
		UpdateDatabase()
	end
end

local function Toggle()
	if Fishbringer:IsShown() == 1 then 
		Fishbringer:Hide()
	else
		UpdateSkill()
		UpdateZone()
		Fishbringer:Show()
	end
end 

local function CheckPole() 
	local _,_,itemid = string.find(GetInventoryItemLink("player", GetInventorySlotInfo("MainHandSlot")) or "", "item:(%d+):(.+)")
	if fishingpoles[tonumber(itemid)] then
		UpdateSkill()
		UpdateZone()
		Fishbringer:Show()
	else
		Fishbringer:Hide()
	end
end

fb:SetScript("OnEvent", function(self, event, ...) 
	self[event](self, event, ...)
end)

fb.ADDON_LOADED = function(self, event, addon) 
	if addon == 'Fishbringer' then
		db = FishbringerDB
		if not db then 
			db = {}
			FishbringerDB = db
		end

		if not db[name] then 
			db[name] = {
				fishingSkill = 0, 
				fishingBuff = 0,
				fishCaught = 0,
				fishToCatch = 0
			}
		end
	
		fishingSkill = db[name].fishingSkill
		fishingBuff = db[name].fishingBuff
		fishCaught = db[name].fishCaught
		fishToCatch = db[name].fishToCatch

		CheckPole()
	end
end

fb.CHAT_MSG_SPELL_ITEM_ENCHANTMENTS = UpdateSkill
fb.SKILL_LINES_CHANGED = UpdateSkill
fb.LOOT_OPENED = UpdateFishes
fb.ZONE_CHANGED_NEW_AREA = UpdateZone
fb.ZONE_CHANGED = UpdateZone
fb.UNIT_INVENTORY_CHANGED = CheckPole

SlashCmdList["FISHBRINGER"] = function(arg1)
	Toggle()
end
SLASH_FISHBRINGER1 = "/fishbringer"
SLASH_FISHBRINGER2 = "/fbr"
SLASH_FISHBRINGER3 = "/fb"

Print("Pack yer bags, we be leavin' fer fishin'!")
