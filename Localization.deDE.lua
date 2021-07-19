local ADDON_NAME, namespace = ...
local L = namespace.L

if namespace.locale == "deDE" then

    --ShowHelp Funktion
    L["Nat Pagle would be proud of you."] = "Nat Pagle wäre stolz auf dich!"
    L["- /fishbringer show - Toggles visibility."] = "- /fishbringer show - Fishbringer Bildschirmanzeige an/aus."
	L["- /fishbringer align - Cycles through text alignment."] = "- /fishbringer align - Textausrichtung Ã¤ndern."
	L["- /fishbringer count - Toggles fish count visibility."] = "- /fishbringer count - Gefangene Fische auf dem Level anzeigen an/aus."
    L["- /fishbringer reset - Resets the fish database."] = "- /fishbringer reset - Fishbringer Datenbank zurücksetzen."

    --Anzeige auf Bildschirm
	L["\124c%s%s\124r\nNo fish in this zone"] = "\124c%s%s\124r\nKein fisch in dieser zone"
    L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"] = "\124c%s%s\124r\n%d Angelskill benötigt zum Angeln\n(%d benötigt für 100%% Fangchance)"
    L["%d%% catch rate"] = "%d%% Fangchance"
    L["%s%s fishing skill%s"] = "%s%s Angelskill%s"
    L["\n%d fish needed to skill up"] = "\n%d Fische benötigt für Skillpunkt"
    L["%d fish caught at this level"] = "%d Fische auf diesem Level gefangen"

	-- Name des Angelperks / Name of the Fishingperk
    L["Fishing"] = "Angeln"

	-- Login Message
    L["Pack yer bags, we be leavin' fer fishin'!"] = "Pack deine Taschen, wir gehen angeln!"

return end