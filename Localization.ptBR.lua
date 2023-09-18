local ADDON_NAME, namespace = ...
local L = namespace.L

if namespace.locale == "ptBR" then

    --ShowHelp Function
    L["Nat Pagle would be proud of you."] = "Nat Pagle ficaria orgulhoso de você."
    L["- /fishbringer show - Toggles visibility."] = "- /fishbringer show - Alterna a visibilidade."
	L["- /fishbringer align - Cycles through text alignment."] = "- /fishbringer align - Percorre o alinhamento do texto."
	L["- /fishbringer count - Toggles fish count visibility."] = "- /fishbringer count - Alterna a visibilidade da contagem de peixes."
    L["- /fishbringer reset - Resets the fish database."] = "- /fishbringer reset - Reinicia o banco de dados de peixes."

    --Fishbringer Overlay/Display Widget
	L["\124c%s%s\124r\nNo fish in this zone"] = "\124c%s%s\124r\nNenhum peixe nesta zona"
    L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"] = "\124c%s%s\124r\n%d habilidade necessária para pescar\n(%d necessário para 100%% de taxa de captura)"
    L["%d%% catch rate"] = "%d%% taxa de captura"
    L["%s%s fishing skill%s"] = "%s%s habilidade de pesca"
    L["\n%d fish needed to skill up"] = "\n%d peixes precisavam de habilidade"
    L["%d fish caught at this level"] = "%d peixes capturados neste nível"

	-- Angeln/Fishing - Name of the Fishing Perk
    L["Fishing"] = "pescaria"

	-- Welcome Message on Login
    L["Pack yer bags, we be leavin' fer fishin'!"] = "Faça as malas, vamos partir 'para pescar'!"

return end
