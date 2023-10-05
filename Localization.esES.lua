local ADDON_NAME, namespace = ...
local L = namespace.L

if namespace.locale == "esES" then

    --ShowHelp Function
    L["Nat Pagle would be proud of you."] = "Nat Pagle estaría orgulloso de ti."
    L["- /fishbringer show - Toggles visibility."] = "- /fishbringer show - Alterna la visibilidad."
	L["- /fishbringer align - Cycles through text alignment."] = "- /fishbringer align - Recorre la alineación del texto."
	L["- /fishbringer count - Toggles fish count visibility."] = "- /fishbringer count - Alterna la visibilidad del recuento de peces."
    L["- /fishbringer reset - Resets the fish database."] = "- /fishbringer reset - Restablece la base de datos de peces."

    --Fishbringer Overlay/Display Widget
	L["\124c%s%s\124r\nNo fish in this zone"] = "\124c%s%s\124r\nNo hay peces en esta zona"
    L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"] = "\124c%s%s\124r\n%d habilidad necesaria para pescar\n(%d necesario para una tasa de captura del 100%%)"
    L["%d%% catch rate"] = "%d%% tasa de captura"
    L["%s%s fishing skill%s"] = "%s%s habilidad de pesca"
    L["\n%d fish needed to skill up"] = "\n%d peces necesarios para mejorar"
    L["%d fish caught at this level"] = "%d pescado capturado a este nivel"

	-- Angeln/Fishing - Name of the Fishing Perk
    L["Fishing"] = "Pescar"

	-- Welcome Message on Login
    L["Pack yer bags, we be leavin' fer fishin'!"] = "¡Prepara tus maletas, nos vamos 'a pescar'!"

return end
