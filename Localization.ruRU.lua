local ADDON_NAME, namespace = ...
local L = namespace.L

if namespace.locale == "ruRU" then

	--*** Important Info: Don't change the Original Text

    --ShowHelp Function
    L["Nat Pagle would be proud of you."] = "Нат Пэгл будет гордиться тобой."
    L["- /fishbringer show - Toggles visibility."] = "- /fishbringer show - Переключает видимость."
	L["- /fishbringer align - Cycles through text alignment."] = "- /fishbringer align - Выравнивание текста."
	L["- /fishbringer count - Toggles fish count visibility."] = "- /fishbringer count - Переключает видимость счетчика пойманной рыбы."
    L["- /fishbringer reset - Resets the fish database."] = "- /fishbringer reset - Сбросить данные."

    --Anzeige auf Bildschirm - Fishbringer Overlay/Display Widget
    L["\124c%s%s\124r\n%d skill needed to fish\n(%d needed for 100%% catch rate)"] = "\124c%s%s\124r\n%d навыка требуется для рыбалки\n(%d требуется для 100%% успеха)"
    L["%d%% catch rate"] = "%d%% шанс поймать"
    L["%s%s fishing skill%s"] = "%s%s навык рыбной ловли"
    L["\n%d fish needed to skill up"] = "\n%d рыб осталось до повышения навыка"
    L["%d fish caught at this level"] = "%d рыб поймано на этом уровне"

	-- Angeln/Fishing - Name of the Fishing Perk - put the localized name into the "" 
    L["Fishing"] = "Рыбная ловля"

	-- Welcome Message on Login - put the localized text into the ""
    L["Pack yer bags, we be leavin' fer fishin'!"] = "Пакуй снасти, валим рыбачить!"

    -- Angelzonen/Fishing Zones - put the localized names into the "". Example: L["Dun Morogh"] = "Localized Name of the Zone"
    L["Dun Morogh"] = "Дун Морог"
	L["Durotar"] = "Дуротар"
	L["Elwynn Forest"] = "Элвиннский лес"
	L["Mulgore"] = "Мулгор"
	L["Eversong Forest"] = "Леса Вечной Песни" 
	L["Azuremyst Isle"] = "Остров Лазурной Дымки"
	L["Teldrassil"]  = "Тельдрассил"
	L["Tirisfal"] =  "Тирисфаль"
	L["Orgrimmar"] = "Оргриммар" 
	L["Ironforge"] = "Стальгорн"
	L["Stormwind City"] = "Штормград" 
	L["Thunder Bluff"] = "Громовой Утес" 
	L["Silvermoon City"] = "Луносвет" 
	L["The Exodar"] = "Экзодар"
	L["Darnassus"] = "Дарнас" 
	L["Undercity"] = "Подгород"
	L["The Barrens"] = "Степи" 
	L["Blackfathom Deeps"] = "Непроглядная Пучина" 
	L["Bloodmyst Isle"] = "Остров Кровавой Дымки" 
	L["Darkshore"] = "Темные берега" 
	L["The Deadmines"] = "Мертвые копи" 
	L["Ghostlands"] = "Призрачные земли" 
	L["Loch Modan"] = "Лок Модан" 
	L["Silverpine Forest"] = "Серебряный бор"
	L["The Wailing Caverns"] = "Пещеры Стенаний" 
	L["Westfall"] = "Западный Край"
	L["Ashenvale"] = "Ясеневый лес" 
	L["Duskwood"] = "Сумеречный лес" 
	L["Hillsbrad Foothills"] = "Предгорья Хилсбрада"
	L["Redridge Mountains"] = "Красногорье"
	L["Stonetalon Mountains"] = "Когтистые горы" 
	L["Wetlands"] = "Болотина"
	L["Alterac Mountains"] = "Альтеракские горы" 
	L["Arathi Highlands"] = "Нагорье Арати"
	L["Desolace"] = "Пустоши"
	L["Dustwallow Marsh"] = "Пылевые топи"
	L["Scarlet Monastery"] = "Монастырь Алого ордена"
	L["Stranglethorn Vale"] = "Тернистая долина"
	L["Swamp of Sorrows"] = "Болото Печали"
	L["Thousand Needles"] = "Тысяча Игл"
	L["Azshara"] = "Азшара"
	L["Felwood"] = "Оскверненный лес"
	L["Feralas"] = "Фералас"
	L["The Hinterlands"] = "Внутренние земли"
	L["Maraudon"] = "Мародон"
	L["Moonglade"] = "Лунная поляна"
	L["Tanaris"] = "Танарис"
	L["The Temple of Atal'Hakkar"] = "Храм Атал'Хаккара"
	L["Un'Goro Crater"] = "Кратер Ун'Горо"
	L["Western Plaguelands"] = "Западные Чумные земли" 
	L["Shadowmoon Valley"] = "Долина Призрачной Луны"
	L["Burning Steppes"] = "Пылающие степи"
	L["Deadwind Pass"] = "Перевал Мертвого Ветра"
	L["Eastern Plaguelands"] = "Восточные Чумные земли" 
	L["Scholomance"] = "Некроситет"
	L["Silithus"] = "Силитус"
	L["Stratholme"] = "Стратхольм"
	L["Winterspring"] = "Зимние Ключи" 
	L["Zul'Gurub"] = "Зул'Гуруб"
	-- The Burning Crusade
	L["Hellfire Peninsula"] = "Полуостров Адского Пламени - Темный портал"
	L["Terokkar Forest"] = "Лес Тероккар"
	L["Nagrand"] = "Награнд"
	L["Netherstorm"] = "Пустоверть"
	L["Zangarmarsh"] = "Зангартопь"
	-- Burning Crusade Subzones
	L["Lake Sunspring"] = "Озеро Солнечного Источника" -- Nagrand
	L["Marshlight Lake"] = "Озеро Болотных Огоньков" -- Zangarmarschen
	L["Sporewind Lake"] = "Озеро Спороветра" -- Zangarmarschen
	L["Serpent Lake"] = "Змеиное озеро" -- Zangarmarschen
	L["Blackwind Lake"] = "Озеро Черного Ветра" -- Wälder von Terokarr
	L["Lake Ere'Noru"] = "Озеро Эре'Нору" -- Wälder von Terokarr 
	L["Lake Jorune"] = "Озеро Иорун" -- Wälder von Terokarr
	-- Wrath of the Lich King
	L["Borean Tundra"] = "Борейская тундра" 
	L["Dragonblight"] = "Драконий Погост"
	L["Howling Fjord"] = "Ревущий фьорд" 
	L["Crystalsong Forest"] = "Лес Хрустальной Песни"
	L["Dalaran"] = "Даларан" 
	L["Sholazar Basin"] = "Низина Шолазар" 
	L["The Frozen Sea"] = "Ледяное море"


return end
