FishbringerDB = {}
local FONT = select(1, GameFontNormalSmall:GetFont())
local fb = CreateFrame"Frame"
local db
local char = string.format("%s - %s", UnitName"player", GetRealmName())

fb:RegisterEvent"PLAYER_ENTERING_WORLD"
fb:RegisterEvent"COMBAT_LOG_EVENT"
fb:RegisterEvent"SKILL_LINES_CHANGED"
fb:RegisterEvent"LOOT_OPENED"
fb:RegisterEvent"ZONE_CHANGED_NEW_AREA"
fb:RegisterEvent"ZONE_CHANGED"
fb:RegisterEvent"UNIT_INVENTORY_CHANGED"

local function Print(text)
	ChatFrame1:AddMessage(string.format("|cffff8000Fishbringer|r: %s", text))
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

local fishingpoles = { 
	[6256] = true,
	[6365] = true,
	[6366] = true,
	[6367] = true,
	[12225] = true,
	[19022] = true,
	[19970] = true,
	[25978] = true,
	[44050] = true,
}

local function GetNumFishToLevel(skillRank)
	if skillRank <= 75 then
		return 1
	else
		return math.ceil((skillRank - 75) / 25)
	end
end	

local function UpdateFishCount(shouldIncrement)
	if shouldIncrement and IsFishingLoot() then
		db[char].fishCaught = db[char].fishCaught + 1
	end

	Fishbringer.fishCount:SetFormattedText(
		"%d fish caught at this level",
		db[char].fishCaught
	)
end

local function IncrementFishCount()
	UpdateFishCount(true)
end

local function ResetFishCounter(numFish)
	db[char].fishToCatch = numFish
	db[char].fishCaught = 0
 	UpdateFishCount(false)
end

local function UpdateCatchInfo()
	local zoneText = GetSubZoneText()
	local zoneSkill = subzones[zoneText]

	if not zoneSkill then 
		zoneText = GetRealZoneText()
		zoneSkill = zones[zoneText]
	end

	-- Sometimes we can trigger this before the player is in any zone
	if not zoneText then
		return
	end

	local maxZoneSkill
	if not zoneSkill then
		zoneSkill = 0
		maxZoneSkill = 0
	else
		maxZoneSkill = zoneSkill + 95
	end

	local chance = (
		(
			db[char].fishingSkill + db[char].fishingBuff
		) - zoneSkill
	) * 0.01 + 0.05
	
	if zoneSkill < 0 then 
		zoneSkill = 1
	end
	
	if chance > 1 then 
		chance = 1
	elseif chance < 0 then 
		chance = 0
	end

	local color
	if chance == 0 then
		color = "ffff2020"
	elseif chance <= 0.5 then 
		color = "ffff8040"
	elseif chance < 1 then 
		color = "ffffff00"
	else
		color = "ff40bf40"
	end
	Fishbringer.zoneInfo:SetFormattedText(
		"\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)",
		color, zoneText, zoneSkill, maxZoneSkill, chance * 100
	)
	Fishbringer.catchRate:SetFormattedText("%d%% catch rate", chance * 100)
end

local function GetFishingSkill()
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillRank, _, skillModifier, skillMaxRank, _, _, _, _, _, _= GetSkillLineInfo(i)
		if skillName == "Fishing" then 
			return skillRank, skillModifier, skillMaxRank
		end
	end
	return
end

local function UpdateSkill(forceResetFishCounter)
	if not db then 
		return
	end
	local skillRank, skillModifier, skillMaxRank = GetFishingSkill()

	if not skillRank then
		return
	end

	db[char].maxFishingSkill = skillMaxRank

	local fishNeededText = ""
	local skillRankText = skillRank

	local fishNeeded = GetNumFishToLevel(skillRank)
	if skillRank ~= skillMaxRank then 
		skillRankText = string.format("%d/%d", skillRank, skillMaxRank)
		fishNeededText = string.format("\n%d fish needed to skill up", fishNeeded)
	end

	local skillModifierText = ""
	if skillModifier > 0 then
		skillModifierText = string.format(" (+%d)", skillModifier)
	end
		
	Fishbringer.content:SetFormattedText(
		"%s%s fishing skill%s",
		skillRankText,
		skillModifierText,
		fishNeededText
	)

	if forceResetFishCounter or db[char].fishingSkill ~= skillRank then
		db[char].fishingSkill = skillRank
		ResetFishCounter(fishNeeded)
	end
	
	if db[char].fishingBuff ~= skillModifier then
		db[char].fishingBuff = skillModifier
		UpdateCatchInfo()
	end
end

local function Update()
	UpdateSkill(false)
	UpdateCatchInfo()
end

local function CycleAlignment()
	if db[char].alignment == "RIGHT" then
		db[char].alignment = "LEFT"
	elseif db[char].alignment == "LEFT" then
		db[char].alignment = "CENTER"
	else
		db[char].alignment = "RIGHT"
	end

	-- Update all
	Fishbringer.title:SetJustifyH(db[char].alignment)
	Fishbringer.zoneInfo:SetJustifyH(db[char].alignment)
	Fishbringer.catchRate:SetJustifyH(db[char].alignment)
	Fishbringer.content:SetJustifyH(db[char].alignment)
	Fishbringer.fishCount:SetJustifyH(db[char].alignment)
end

local function Toggle()
	if db[char].isShown then 
		Fishbringer:Hide()
		db[char].isShown = false
	else
		Update()
		Fishbringer:Show()
		db[char].isShown = true
	end
end

local function ToggleFishCount()
	if db[char].isFishCountShown then
		Fishbringer.fishCount:Hide()
		db[char].isFishCountShown = false
	else
		Fishbringer.fishCount:Show()
		db[char].isFishCountShown = true
	end
end

local function CheckForFishingPole() 

	local _, _, itemid = string.find(GetInventoryItemLink("player", GetInventorySlotInfo("MainHandSlot")) or "", "item:(%d+):(.+)")
	if db[char].isShown or fishingpoles[tonumber(itemid)] then
		Update()
		Fishbringer:Show()
		db[char].isShown = true
	else
		Fishbringer:Hide()
		db[char].isShown = false
	end
end

local function InitializeDB(resetDatabase)
	db = FishbringerDB
	if not db then 
		db = {}
		FishbringerDB = db
	end

	if resetDatabase or not db[char] then 
		db[char] = {
			fishingSkill = 0, 
			fishingBuff = 0,
			fishCaught = 0,
			fishToCatch = 0,
			maxFishingSkill = 0,
			isShown = false,
			isFishCountShown = true,
			alignment = "RIGHT"
		}
	end
end

local function InitializeFrame()
	-- Frame madness
	if Fishbringer then
		return
	end
	Fishbringer = CreateFrame("Frame", "Fishbringer", UIParent)
	Fishbringer:EnableMouse(true)
	Fishbringer:SetMovable(true)
	Fishbringer:SetUserPlaced(false)
	Fishbringer:SetHeight(150)
	Fishbringer:SetWidth(185)
	Fishbringer:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground", 
		tile = true, 
		tileSize = 16, 
		insets = {
			left = 4, 
			right = 4, 
			top = 4,
			bottom = 4
		},
	})
	Fishbringer:SetBackdropColor(0, 0, 0, 0)
	Fishbringer:SetScript("OnMouseDown", function(self) 
		if IsAltKeyDown() then 
			self:SetBackdropColor(0, 0, 0, .6)
			self:StartMoving() 
		end 
	end)
	Fishbringer:SetScript("OnMouseUp", function(self) 
		self:StopMovingOrSizing()
		self:SetBackdropColor(0, 0, 0, 0)
	end)
	Fishbringer:SetPoint("RIGHT", UIParent, "RIGHT", -10, 0)

	if not db[char].isShown then
		Fishbringer:Hide()
	end

	local title = Fishbringer:CreateFontString(nil, "OVERLAY")
	title:SetHeight(15)
	title:SetWidth(Fishbringer:GetWidth() - 10)
	title:SetPoint("TOPLEFT", Fishbringer, "TOPLEFT", 3, -10)
	title:SetJustifyH(db[char].alignment)
	title:SetFont(FONT, 16)
	title:SetShadowOffset(1, -1)
	local name
	if random(100) < 5 then 
		name = "Corrupted Fishbringer"
	else
		name = "Fishbringer"
	end
	title:SetText(name)
	Fishbringer.title = title

	local zoneInfo = Fishbringer:CreateFontString(nil, "OVERLAY")
	zoneInfo:SetHeight(50)
	zoneInfo:SetWidth(Fishbringer:GetWidth() - 10)
	zoneInfo:SetPoint("TOP", Fishbringer.title, "BOTTOM", 0, 0)
	zoneInfo:SetJustifyH(db[char].alignment)
	zoneInfo:SetFont(FONT, 12)
	zoneInfo:SetShadowOffset(1, -1)
	Fishbringer.zoneInfo = zoneInfo

	local catchRate = Fishbringer:CreateFontString(nil, "OVERLAY")
	catchRate:SetHeight(15)
	catchRate:SetWidth(Fishbringer:GetWidth() - 10)
	catchRate:SetPoint("TOP", Fishbringer.zoneInfo, "BOTTOM", 0, 0)
	catchRate:SetJustifyH(db[char].alignment)
	catchRate:SetFont(FONT, 14)
	catchRate:SetShadowOffset(1, -1)
	Fishbringer.catchRate = catchRate

	local content = Fishbringer:CreateFontString(nil, "OVERLAY")
	content:SetHeight(30)
	content:SetWidth(Fishbringer:GetWidth() - 10)
	content:SetFont(FONT, 12)
	content:SetShadowOffset(1, -1)
	content:SetJustifyH(db[char].alignment)
	content:SetPoint("TOP", Fishbringer.catchRate, "BOTTOM", 0, 0)
	Fishbringer.content = content

	local fishCount = Fishbringer:CreateFontString(nil, "OVERLAY")
	fishCount:SetHeight(15)
	fishCount:SetWidth(Fishbringer:GetWidth() - 10)
	fishCount:SetFont(FONT, 12)
	fishCount:SetShadowOffset(1, -1)
	fishCount:SetJustifyH(db[char].alignment)
	fishCount:SetPoint("TOP", Fishbringer.content, "BOTTOM", 0, -7)
	Fishbringer.fishCount = fishCount

	if not db[char].isFishCountShown then
		Fishbringer.fishCount:Hide()
	end
end

function UpdateFishingSkill()
	return UpdateSkill(false)
end

fb:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

fb.PLAYER_ENTERING_WORLD = function()
	InitializeDB(false)
	InitializeFrame()
	CheckForFishingPole()
	UpdateFishCount(false)
end

fb.COMBAT_LOG_EVENT = UpdateSkill
fb.SKILL_LINES_CHANGED = UpdateSkill
fb.LOOT_OPENED = IncrementFishCount
fb.ZONE_CHANGED_NEW_AREA = UpdateCatchInfo
fb.ZONE_CHANGED = UpdateCatchInfo
fb.UNIT_INVENTORY_CHANGED = CheckForFishingPole

local function ShowHelp()
	Print("Nat Pagle would be proud of you.")
	Print("Local variants:")
	Print("- /fb show - Toggles visibility.")
	Print("- /fb align - Cycles through text alignment.")
	Print("- /fb count - Toggles fish count visibility.")
	Print("- /fb reset - Resets the fish database.")
end

SlashCmdList["FISHBRINGER"] = function(arg)
	if arg == "align" then
		return CycleAlignment()
	elseif arg == "show" or arg == "hide" then
		return Toggle()
	elseif arg == "count" then
		return ToggleFishCount()
	elseif arg == "reset" then
		InitializeDB(true)
		UpdateSkill(true)
		UpdateCatchInfo()
		return
	end
	return ShowHelp()
end
SLASH_FISHBRINGER1 = "/fishbringer"
-- Hail to Fishing Buddy!
if not select(4, GetAddOnInfo"Fishing Buddy") then
	SLASH_FISHBRINGER2 = "/fb"
end
Print("Pack yer bags, we be leavin' fer fishin'!")
