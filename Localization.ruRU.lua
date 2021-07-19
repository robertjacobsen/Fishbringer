local ADDON_NAME, namespace = ...
local L = namespace.L

if namespace.locale == "ruRU" then

    --ShowHelp Function
    L["Nat Pagle would be proud of you."] = "Нат Пэгл будет гордиться тобой."
    L["- /fishbringer show - Toggles visibility."] = "- /fishbringer show - Переключает видимость."
	L["- /fishbringer align - Cycles through text alignment."] = "- /fishbringer align - Выравнивание текста."
	L["- /fishbringer count - Toggles fish count visibility."] = "- /fishbringer count - Переключает видимость счетчика пойманной рыбы."
    L["- /fishbringer reset - Resets the fish database."] = "- /fishbringer reset - Сбросить данные."

    --Fishbringer Overlay/Display Widget
	L["\124c%s%s\124r\nNo fish in this zone"] = "\124c%s%s\124r\nВ этой зоне нет рыбы"
    L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"] = "\124c%s%s\124r\n%d навыка требуется для рыбалки\n(%d требуется для 100%% успеха)"
    L["%d%% catch rate"] = "%d%% шанс поймать"
    L["%s%s fishing skill%s"] = "%s%s навык рыбной ловли"
    L["\n%d fish needed to skill up"] = "\n%d рыб осталось до повышения навыка"
    L["%d fish caught at this level"] = "%d рыб поймано на этом уровне"

	-- Angeln/Fishing - Name of the Fishing Perk
    L["Fishing"] = "Рыбная ловля"

	-- Welcome Message on Login
    L["Pack yer bags, we be leavin' fer fishin'!"] = "Пакуй снасти, валим рыбачить!"

return end
