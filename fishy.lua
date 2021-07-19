FishbringerDB = {}
local FONT = select(1, GameFontNormalSmall:GetFont())
local fb = CreateFrame"Frame"
local db
local char = string.format("%s - %s", UnitName"player", GetRealmName())
local ADDON_NAME, namespace = ... 	--localization
local L = namespace.L 				--localization
local version = GetAddOnMetadata(ADDON_NAME, "Version")
local addoninfo = 'v'..version
local _,_,_,interface = GetBuildInfo()
local classicEra = (interface==11307)
local classicTBC = (interface==20501)
local areaTable = {}


fb:RegisterEvent"PLAYER_ENTERING_WORLD"
fb:RegisterEvent"ADDON_LOADED"
fb:RegisterEvent"COMBAT_LOG_EVENT"
fb:RegisterEvent"SKILL_LINES_CHANGED"
fb:RegisterEvent"LOOT_READY"
fb:RegisterEvent"ZONE_CHANGED_NEW_AREA"
fb:RegisterEvent"ZONE_CHANGED"
fb:RegisterEvent"UNIT_INVENTORY_CHANGED"

local function Print(text)
	ChatFrame1:AddMessage(string.format("|cffff8000Fishbringer|r: %s", text))
end

local zones = {
	[1411] = -70,
	[1412] = -70,
	[1413] = -20,
	[1416] = 130,
	[1417] = 130,
	[1420] = -70,
	[1421] = -20,
	[1422] = 205,
	[1423] = 330,
	[1424] = 55,
	[1425] = 205,
	[1426] = -70,
	[1428] = 330,
	[1429] = -70,
	[1430] = 330,
	[1431] = 55,
	[1432] = -20,
	[1433] = 55,
	[1434] = 130,
	[1435] = 130,
	[1436] = -20,
	[1437] = 55,
	[1438] = -70,
	[1439] = -20,
	[1440] = 55,
	[1441] = 130,
	[1442] = 55,
	[1443] = 130,
	[1444] = 205,
	[1445] = 130,
	[1446] = 205,
	[1447] = 205,
	[1448] = 205,
	[1449] = 205,
	[1450] = 205,
	[1451] = 330,
	[1452] = 330,
	[1453] = -20,
	[1454] = -20,
	[1455] = -20,
	[1456] = -20,
	[1457] = -20,
	[1458] = -20,
	[1941] = -70,
	[1942] = -20,
	[1943] = -70,
	[1944] = 280,
	[1946] = 305,
	[1947] = -20,
	[1948] = 280,
	[1950] = -20,
	[1951] = 380,
	[1952] = 355,
	[1953] = 380,
	[1954] = -20,
}
local subzones = {
	[297] = 205,
	[718] = -20, --Wailing Caverns Entrance
	[719] = -20, --BFD Entrance
	[1112] = 330,
	[1222] = 330,
	[1227] = 330,
	[1477] = 205, -- ST Entrance
	[1977] = 330, -- ZG Entrance
	[2100] = 205, --Maraudon Entrance
	[3140] = 330,
	[3614] = 395,
	[3621] = 395,
	[3653] = 355,
	[3656] = 355,
	[3658] = 355,
	[3679] = 405,
	[3690] = 405,
	[3691] = 405,
	[3692] = 405,
	[3859] = 405,
	[3974] = 405,
	[3975] = 405,
	[3976] = 405,
}
local instances = {
	[36] = -20,
	[43] = -20,
	[48] = -20,
	[109] = 205,
	[309] = 309,
	[329] = 330,
	[349] = 205,
	[548] = 405,
	[1001] = 130,
	[1004] = 130,
	[1007] = 330,
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
		L["%d fish caught at this level"],
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

local function populateAreaTable()
	local areaName
	for areaId=1,10500 do
	   areaName=C_Map.GetAreaInfo(areaId)
	   if areaName then
		  areaTable[areaName]=areaId
	   end
	end
end

--[[ GetExploredAreaIDsAtPosition doesn't always work for many locations - UNRELIABLE
local function getPlayerAreaId()
	local areaId
	local unit = "Player"
	local mapId = C_Map.GetBestMapForUnit(unit)
	local mapPos = C_Map.GetPlayerMapPosition(mapId, unit)
	areaIds = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(mapId,mapPos)
	if areaIds and areaIds[1] then
		areaId = areaIds[1]
	end
	return areaId
end
--]]

local function UpdateCatchInfo()
	local zoneText
	local zoneSkill
	
	if IsInInstance() then
		local _,_,_,_,_,_,_,instanceId = GetInstanceInfo()
		zoneSkill = instances[instanceId]
		zoneText = GetRealZoneText()
	else
		zoneText = GetSubZoneText()
		if zoneText == "" then
			zoneText = GetRealZoneText()
		end
		local areaId = areaTable[zoneText]
		if areaId then
			zoneSkill = subzones[areaId]
		end
		if not zoneSkill then
			zoneText = GetRealZoneText()
			local mapId = C_Map.GetBestMapForUnit("Player")
			zoneSkill = zones[mapId]
		end
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
			db[char].fishingSkill + db[char].fishingBuff - zoneSkill
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
	if zoneSkill == 0 then
		Fishbringer.zoneInfo:SetFormattedText(
			L["\124c%s%s\124r\nNo fish in this zone"],
			color, zoneText, zoneSkill, maxZoneSkill, chance * 100
		)
		Fishbringer.catchRate:SetText("")
	else
		Fishbringer.zoneInfo:SetFormattedText(
			L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"],
			color, zoneText, zoneSkill, maxZoneSkill, chance * 100
		)
		Fishbringer.catchRate:SetFormattedText(L["%d%% catch rate"], chance * 100)
	end
end

local function GetFishingSkill()
	for i = 1, GetNumSkillLines() do
		local skillName, _, _, skillRank, _, skillModifier, skillMaxRank, _, _, _, _, _, _= GetSkillLineInfo(i)
		if skillName == L["Fishing"] then 
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
		skillRankText = string.format("%d(%d)", skillRank, skillMaxRank)
		fishNeededText = string.format(L["\n%d fish needed to skill up"], fishNeeded)
	end

	local skillModifierText = ""
	if skillModifier > 0 then
		skillModifierText = string.format("+%d = %d", skillModifier, skillRank+skillModifier)
	end
		
	Fishbringer.content:SetFormattedText(
		L["%s%s fishing skill%s"],
		skillRankText,
		skillModifierText,
		fishNeededText
	)

	if forceResetFishCounter or db[char].fishingSkill ~= skillRank then
		db[char].fishingSkill = skillRank
		ResetFishCounter(fishNeeded)
		UpdateCatchInfo()
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
	if fishingpoles[tonumber(itemid)] then
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
	populateAreaTable()
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

local function classicEraCreateFrame()
	return CreateFrame("Frame", "Fishbringer", UIParent)
end
local function classicTBCCreateFrame()
	return CreateFrame("Frame", "Fishbringer", UIParent, "BackdropTemplate")
end

local function InitializeFrame()
	-- Frame madness
	if Fishbringer then
		return
	end
	if classicEra then
		local Fishbringer = classicEraCreateFrame()
	elseif classicTBC then
		local Fishbringer = classicTBCCreateFrame()
	else
		return
	end
	Fishbringer:EnableMouse(true)
	Fishbringer:SetMovable(true)
	Fishbringer:SetUserPlaced(true)
	Fishbringer:SetHeight(150)
	Fishbringer:SetWidth(250)
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
	CheckForFishingPole()
	UpdateFishCount(false)
end

fb.ADDON_LOADED = function(self, event, addon)
	if addon ~= "Fishbringer" then
		return
	end
	InitializeDB(false)
	InitializeFrame()
end

fb.COMBAT_LOG_EVENT = UpdateFishingSkill
fb.SKILL_LINES_CHANGED = UpdateFishingSkill
fb.LOOT_READY = IncrementFishCount
fb.ZONE_CHANGED_NEW_AREA = UpdateCatchInfo
fb.ZONE_CHANGED = UpdateCatchInfo
fb.UNIT_INVENTORY_CHANGED = CheckForFishingPole

local function ShowHelp()
	Print(L["Nat Pagle would be proud of you."])
	Print(L["- /fishbringer show - Toggles visibility."])
	Print(L["- /fishbringer align - Cycles through text alignment."])
	Print(L["- /fishbringer count - Toggles fish count visibility."])
	Print(L["- /fishbringer reset - Resets the fish database."])
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
if not select(4, GetAddOnInfo"FishingBuddy") then
	SLASH_FISHBRINGER2 = "/fb"
end

Print(L["Pack yer bags, we be leavin' fer fishin'!"])
