local ADDON_NAME, namespace = ...
local L = namespace.L

if namespace.locale == "frFR" then

    --ShowHelp Function
    L["Nat Pagle would be proud of you."] = "Nat Pagle serait fier de vous."
    L["- /fishbringer show - Toggles visibility."] = "- /fishbringer show - Bascule la visibilité."
	L["- /fishbringer align - Cycles through text alignment."] = "- /fishbringer align - Fait défiler l'alignement du texte."
	L["- /fishbringer count - Toggles fish count visibility."] = "- /fishbringer count - Bascule la visibilité du nombre de poissons."
    L["- /fishbringer reset - Resets the fish database."] = "- /fishbringer reset - Réinitialise la base de données des poissons."

    --Fishbringer Overlay/Display Widget
	L["\124c%s%s\124r\nNo fish in this zone"] = "\124c%s%s\124r\nPas de poisson dans cette zone"
    L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"] = "\124c%s%s\124r\n%d compétence nécessaire pour pêcher\n(%d nécessaire pour un taux de capture de 100%%)"
    L["%d%% catch rate"] = "%d%% taux de capture"
    L["%s%s fishing skill%s"] = "%s%s compétence de pêche"
    L["\n%d fish needed to skill up"] = "\n%d рыб poisson nécessaire pour se perfectionner"
    L["%d fish caught at this level"] = "%d poisson pêché à ce niveau"

	-- Angeln/Fishing - Name of the Fishing Perk
    L["Fishing"] = "Pêche"

	-- Welcome Message on Login
    L["Pack yer bags, we be leavin' fer fishin'!"] = "Faites vos valises, nous partons « à la pêche » !"

return end
