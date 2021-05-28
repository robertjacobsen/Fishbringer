local ADDON_NAME, namespace = ...
local L = namespace.L

if namespace.locale == "deDE" then

    --ShowHelp Funktion
    L["Nat Pagle would be proud of you."] = "Nat Pagle wäre stolz auf dich!"
    L["- /fishbringer show - Toggles visibility."] = "- /fishbringer show - Fishbringer Bildschirmanzeige an/aus."
	L["- /fishbringer align - Cycles through text alignment."] = "- /fishbringer align - Textausrichtung ändern."
	L["- /fishbringer count - Toggles fish count visibility."] = "- /fishbringer count - Gefangene Fische auf dem Level anzeigen an/aus."
    L["- /fishbringer reset - Resets the fish database."] = "- /fishbringer reset - Fishbringer Datenbank zurücksetzen."

    --Anzeige auf Bildschirm
    L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"] = "\124c%s%s\124r\n%d Angelskill benötigt zum Angeln\n(%d benötigt für 100%% Fangchance)"
    L["%d%% catch rate"] = "%d%% Fangchance"
    L["%s%s fishing skill%s"] = "%s%s Angelskill%s"
    L["\n%d fish needed to skill up"] = "\n%d Fische benötigt für Skillpunkt"
    L["%d fish caught at this level"] = "%d Fische auf diesem Level gefangen"

	-- Name des Angelperks / Name of the Fishingperk

    L["Fishing"] = "Angeln"

	-- Login Message

    L["Pack yer bags, we be leavin' fer fishin'!"] = "Pack deine Taschen, wir gehen angeln!"

    -- Angelzonen / Fishingzones

    L["Dun Morogh"] = "Dun Morogh"
	L["Durotar"] = "Durotar"
	L["Elwynn Forest"] = "Wald von Elwynn"
	L["Mulgore"] = "Mulgore"
	L["Eversong Forest"] = "Immersangwald" 
	L["Azuremyst Isle"] = "Azurmythosinsel"
	L["Teldrassil"]  = "Teldrassil"
	L["Tirisfal"] =  "Tirisfal"
	L["Orgrimmar"] = "Orgrimmar" 
	L["Ironforge"] = "Ironforge"
	L["Stormwind City"] = "Stormwind" 
	L["Thunder Bluff"] = "Thunder Bluff" 
	L["Silvermoon City"] = "Silbermond" 
	L["The Exodar"] = "Die Exodar"
	L["Darnassus"] = "Darnassus" 
	L["Undercity"] = "Undercity"
	L["The Barrens"] = "Brachland" 
	L["Blackfathom Deeps"] = "Blackfathom-Tiefe" 
	L["Bloodmyst Isle"] = "Blutmythosinsel" 
	L["Darkshore"] = "Dunkelküste" 
	L["The Deadmines"] = "Die Todesminen" 
	L["Ghostlands"] = "Geisterlande" 
	L["Loch Modan"] = "Loch Modan" 
	L["Silverpine Forest"] = "Silberwald"
	L["The Wailing Caverns"] = "Die Höhlen des Wehklagens" 
	L["Westfall"] = "Westfall"
	L["Ashenvale"] = "Ashenvale" 
	L["Duskwood"] = "Dämmerwald" 
	L["Hillsbrad Foothills"] = "Vorgebirge von Hillsbrad"
	L["Redridge Mountains"] = "Rotkammgebirge"
	L["Stonetalon Mountains"] = "Steinkrallengebirge" 
	L["Wetlands"] = "Sumpfland"
	L["Alterac Mountains"] = "Alteracgebirge" 
	L["Arathi Highlands"] = "Arathihochland"
	L["Desolace"] = "Desolace"
	L["Dustwallow Marsh"] = "Marschen von Dustwallow"
	L["Scarlet Monastery"] = "Das scharlachrote Kloster"
	L["Stranglethorn Vale"] = "Schlingendorntal"
	L["Swamp of Sorrows"] = "Sümpfe des Elends"
	L["Thousand Needles"] = "Tausend Nadeln"
	L["Azshara"] = "Azshara"
	L["Felwood"] = "Teufelswald"
	L["Feralas"] = "Feralas"
	L["The Hinterlands"] = "Hinterland"
	L["Maraudon"] = "Maraudon"
	L["Moonglade"] = "Moonglade"
	L["Tanaris"] = "Tanaris"
	L["The Temple of Atal'Hakkar"] = "Der Tempel von Atal'Hakkar"
	L["Un'Goro Crater"] = "Un'Goro-Krater"
	L["Western Plaguelands"] = "Westliche Pestländer" 
	L["Shadowmoon Valley"] = "Schattenmondtal"
	L["Burning Steppes"] = "Brennende Steppe"
	L["Deadwind Pass"] = "Gebirgspass der Todenwinde"
	L["Eastern Plaguelands"] = "Östliche Pestländer" 
	L["Scholomance"] = "Scholomance"
	L["Silithus"] = "Silithus"
	L["Stratholme"] = "Stratholme"
	L["Winterspring"] = "Winterspring" 
	L["Zul'Gurub"] = "Zul'Gurub"
	--- Burning Crusade
	L["Terokkar Forest"] = "Wälder von Terokkar"
	L["Nagrand"] = "Nagrand"
	L["Netherstorm"] = "Nethersturm"
	L["Zangarmarsh"] = "Zangarmarschen"
	-- Burning Crusade Subzones
	L["Lake Sunspring"] = "Lake Sunspring" -- Nagrand
	L["Marshlight Lake"] = "Sumpflichtsee" -- Zangarmarschen
	L["Sporewind Lake"] = "Sporenwindsee" -- Zangarmarschen
	L["Serpent Lake"] = "Schlangensee" -- Zangarmarschen
	L["Blackwind Lake"] = "Schattenwindsee" -- Wälder von Terokarr
	L["Lake Ere'Noru"] = "See von Ere'Noru" -- Wälder von Terokarr 
	L["Lake Jorune"] = "Jorunsee" -- Wälder von Terokarr
	--- WOTLK
	L["Borean Tundra"] = "Boreanische Tundra" 
	L["Dragonblight"] = "Drachenöde"
	L["Howling Fjord"] = "Heulende Fjord" 
	L["Crystalsong Forest"] = "Kristallsangwald"
	L["Dalaran"] = "Dalaran" 
	L["Sholazar Basin"] = "Sholazarbecken" 
	L["The Frozen Sea"] = "Die gefrorene See"

return end