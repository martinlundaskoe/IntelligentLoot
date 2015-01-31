-- Author      : Martin Lund Askøe (Ðoctorion - Aggramar)
-- Create Date : 21/10/2013

local Locale = LibStub("AceLocale-3.0"):NewLocale("IntelligentLoot", "enUS", true);

if Locale then
	Locale["IntelligentLoot"] = "Intelligent Loot";	

	Locale["SettingsTab"] = "Settings";
	Locale["SettingsTabDescription"] = "";

	Locale["SlashToggleParameter"] = "toggle";
	Locale["SlashToggleParameterDescription"] = "toggle IntelligentLoot globally";
	
	Locale["GeneralHeader"] = "General";
	Locale["ConfigurationState"] = "Group Setting";
	Locale["ConfigurationStateDescription"] = "Determines the settings for solo, party and raid looting";
	Locale["Auto"] = "Intelligent AutoLoot Enabled";
	Locale["AutoDescription"] = "A global IntelligentLoot setting. If this is disabled IntelligentLoot will perform no autolooting";
	
	Locale["LootingOptionsHeader"] = "Optional AutoLoot Settings";

	Locale["Money"] = "Money Looting";
	Locale["MoneyDescription"] = "Enable autolooting of copper, silver and gold";
	Locale["Currency"] = "Currency Looting";
	Locale["CurrencyDescription"] = "Enable autolooting of currencies such as Valor Points";
	Locale["Quest"] = "QuestItem Looting";
	Locale["QuestDescription"] = "Enable autolooting of quest items";
	Locale["Inventory"] = "Inventory Based Looting";
	Locale["InventoryDescription"] = "Enable autolooting of items that is already in your inventory";

	Locale["RarityOrAbove"] = "Rarity Based Looting";
	Locale["RarityOrAboveDescription"] = "Enable autolooting based on an items rarity";
	Locale["Rarity"] = "Minimum Rarity";
	Locale["RarityDescription"] = "The item rarity must exceed or be equal to this value";

	Locale["LevelOrAbove"] = "iLevel Based Looting";
	Locale["LevelOrAboveDescription"] = "Enable autolooting based on an items iLevel";
	Locale["Level"] = "Minimum iLevel Value";
	Locale["LevelDescription"] = "The iLevel value of an item, for stacks this is the individual iLevel value not the summarized stack value";

	Locale["MakeRoom"] = "Make Room";
	Locale["MakeRoomDescription"] = "Enable a feature that, when looting non-vendor items, will clear a bag slot (detroying the item in the slot), when there are no available slots left in your bags. The detroyed item will be the least valuable VendorTrash item in your bags. This feature is only in effect when looting non-vendortrash items, that requires a free bag slot";

	Locale["AlwaysLootOrDestroy"] = "Always AutoLoot (destroy)";
	Locale["AlwaysLootOrDestroyDescription"] = "Enables constant autolooting. However items that would not otherwise meet the requirements for looting, will be detroyed immediately. This setting is only available when solo looting";

	Locale["Price"] = "Always AutoLoot - Required Vendor Price (copper value)";
	Locale["PriceDescription"] = "When Always AutoLoot is enabled, all vendor trash looted will be detroyed, if the vendor price does not exceed this amount";
	
	Locale["Destroying"] = "Destroying";
	Locale["EMPTY"] = "";
end