-- Author      : Martin Lund Askøe (Ðoctorion - Aggramar)
-- Create Date : 21/10/2013

IntelligentLoot = LibStub("AceAddon-3.0"):NewAddon("IntelligentLoot", "AceEvent-3.0", "AceConsole-3.0");
local Locale = LibStub("AceLocale-3.0"):GetLocale("IntelligentLoot", true);

local AutoLootKey = "Auto";
local MoneyLootKey = "Money";
local CurrencyLootKey = "Currency";
local QuestLootKey = "Quest";
local InventoryLootKey = "Inventory";
local RarityOrAboveLootKey = "RarityOrAbove";
local RarityLootKey = "Rarity";
local LevelOrAboveLootKey = "LevelOrAbove";
local LevelLootKey = "Level"; 
local MakeRoomLootKey = "MakeRoom";
local AlwaysLootOrDestroyLootKey = "AlwaysLootOrDestroy";
local PriceLootKey = "Price";

local configurationState;

function getConfigurationState()
	if (configurationState ~= nil) then
		return configurationState;
	end;
	return "SoloState"
end
function setConfigurationState(value)
	configurationState = value;
end

function getCurrentState()
	if (UnitInRaid("player")) then
		return "RaidState";
	elseif (UnitInParty("player")) then
		return "PartyState";
	else
		return "SoloState";
	end
end

function getConfiguration(key, state)
	if (state) then
		return IntelligentLoot.db.global[state][key];
	else
		return IntelligentLoot.db.global[getConfigurationState()][key];
	end
end
function setConfiguration(key, value, state)
	if (state) then
		IntelligentLoot.db.global[state][key] = value;
	else
		IntelligentLoot.db.global[getConfigurationState()][key] = value;
	end
end

IntelligentLoot.Config = {
    type = "group",  
    childGroups = "tab",
	args = {
		settings = {
			name = Locale["SettingsTab"],
			type = "group",
			order = 1,
			args = {
				configuration = {
					type = "select",
					name = Locale["ConfigurationState"],
					desc = Locale["ConfigurationStateDescription"],
					values = {["SoloState"]="Solo", ["PartyState"]="Party", ["RaidState"]="Raid"},
					style = "dropdown",
					width = "full",
					order = 11,
					get = function() return getConfigurationState() end,
					set = function(_, value) setConfigurationState(value); end
				},
				AutoLootKey = {
					type = "toggle",
					name = Locale[AutoLootKey],
					desc = Locale[AutoLootKey.."Description"],
					width = "full",
					order = 12,
					get = function() return getConfiguration(AutoLootKey) end,
					set = function(_, value) setConfiguration(AutoLootKey, value); end
				},
				lootingOptionsHeader = {
					name = Locale["LootingOptionsHeader"],
					type = "header",
					width = "full",
					order = 20,
				},
				MoneyLootKey = {
					name = Locale[MoneyLootKey],
					desc = Locale[MoneyLootKey.."Description"],
					type = "toggle",
					width = "full",
					order = 21,
					get = function() return getConfiguration(MoneyLootKey) end,
					set = function(_, value) setConfiguration(MoneyLootKey, value); end
				},
				CurrencyLootKey = {
					name = Locale[CurrencyLootKey],
					desc = Locale[CurrencyLootKey.."Description"],
					type = "toggle",
					width = "full",
					order = 22,
					get = function() return getConfiguration(CurrencyLootKey) end,
					set = function(_, value) setConfiguration(CurrencyLootKey, value); end
				},
				QuestLootKey = {
					name = Locale[QuestLootKey],
					desc = Locale[QuestLootKey.."Description"],
					type = "toggle",
					width = "full",
					order = 23,
					get = function() return getConfiguration(QuestLootKey) end,
					set = function(_, value) setConfiguration(QuestLootKey, value); end
				},
				InventoryLootKey = {
					name = Locale[InventoryLootKey],
					desc = Locale[InventoryLootKey.."Description"],
					type = "toggle",
					width = "full",
					order = 24,
					get = function() return getConfiguration(InventoryLootKey) end,
					set = function(_, value) setConfiguration(InventoryLootKey, value); end
				},
				RarityOrAboveLootKey = {
					name = Locale[RarityOrAboveLootKey],
					desc = Locale[RarityOrAboveLootKey.."Description"],
					type = 'toggle',
					order = 25,
					width = "full",
					get = function() return getConfiguration(RarityOrAboveLootKey) end,
					set = function(_, value) setConfiguration(RarityOrAboveLootKey, value); end
				},
				RarityLootKey = {
					name = Locale[RarityLootKey],
					desc = Locale[RarityLootKey.."Description"],
					type = 'select',
					style = "dropdown",
					values = {"|cff9d9d9dVendor Trash|r", "Common", "|cff1eff00Uncommon|r", "|cff0070ddRare|r", "|cffa335eeEpic|r", "|cffff8000Legendary|r", "|cffe6cc80Hierloom|r"},
					disabled = function() return not getConfiguration(RarityOrAboveLootKey) end, 
					order = 26,
					width = "normal",
					get = function() return getConfiguration(RarityLootKey) end,
					set = function(_, value) setConfiguration(RarityLootKey, value); end
				},
				LevelOrAboveLootKey = {
					name = Locale[LevelOrAboveLootKey],
					desc = Locale[LevelOrAboveLootKey.."Description"],
					type = 'toggle',
					order = 27,
					width = "full",
					get = function() return getConfiguration(LevelOrAboveLootKey) end,
					set = function(_, value) setConfiguration(LevelOrAboveLootKey, value); end
				},
				LevelLootKey = {
					name = Locale[LevelLootKey],
					desc = Locale[LevelLootKey.."Description"],
					type = 'input',
					disabled = function() return not getConfiguration(LevelOrAboveLootKey) end, 
					order = 28,
					width = "normal",
					get = function() return getConfiguration(LevelLootKey) end,
					set = function(_, value) setConfiguration(LevelLootKey, value); end
				},
				MakeRoomLootKey = {
					name = Locale[MakeRoomLootKey],
					desc = Locale[MakeRoomLootKey.."Description"],
					type = 'toggle',
					order = 29,
					width = "full",
					get = function() return getConfiguration(MakeRoomLootKey) end,
					set = function(_, value) setConfiguration(MakeRoomLootKey, value); end
				},
				AlwaysLootOrDestroyLootKey = {
					name = Locale[AlwaysLootOrDestroyLootKey],
					desc = Locale[AlwaysLootOrDestroyLootKey.."Description"],
					type = 'toggle',
					order = 30,
					width = "full",
					get = function() return getConfiguration(AlwaysLootOrDestroyLootKey) end,
					set = function(_, value) setConfiguration(AlwaysLootOrDestroyLootKey, value); end
				},
				PriceLootKey = {
					name = Locale[PriceLootKey],
					desc = Locale[PriceLootKey.."Description"],
					type = 'input',
					disabled = function() return not getConfiguration(AlwaysLootOrDestroyLootKey) end, 
					order = 31,
					width = "normal",
					get = function() return getConfiguration(PriceLootKey) end,
					set = function(_, value) setConfiguration(PriceLootKey, value); end
				}
			}
		}
	}
};

function IntelligentLoot:OnInitialize()
		
	self.db = LibStub("AceDB-3.0"):New("IntelligentLootDB", self.DefaultOptions);

	IntelligentLoot:InitializeSettings();

	self.ConfigUI = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("IntelligentLoot", Locale["IntelligentLoot"]);	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("IntelligentLoot", self.Config);

	self:RegisterChatCommand("intelligentloot", "SlashCommandHandler");
	self:RegisterChatCommand("iloot", "SlashCommandHandler");
	self:RegisterChatCommand("il", "SlashCommandHandler");
	
   	self:RegisterEvent("LOOT_OPENED", "OnLootWindowOpened");
   	self:RegisterEvent("BAG_UPDATE", "OnBagUpdate");

end

function IntelligentLoot:SlashCommandHandler(message)	
	local lowerCasedMessage = strlower(message)
	if (lowerCasedMessage == Locale["SlashToggleParameter"]) then
		self.db.global.GlobalState = not self.db.global.GlobalState;
	else
		IntelligentLoot:Print(Locale["SlashToggleParameter"].." - "..Locale["SlashToggleParameterDescription"])
	end
end

local lootDestroyInformation = {};
function IntelligentLoot:OnBagUpdate()
	table.foreach(lootDestroyInformation, IntelligentLoot_DeleteItem);
end

function IntelligentLoot_DeleteItem(index, itemIDForDeletion)
	if (itemIDForDeletion) then
		for bagID = 0, NUM_BAG_SLOTS do
			local numberOfContainerSlots = GetContainerNumSlots(bagID);
			if numberOfContainerSlots > 0 then
				for slotID = 1, numberOfContainerSlots do
					local containerItemID = GetContainerItemID(bagID, slotID);
					if (containerItemID and itemID and itemID == containerItemID) then
						local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(containerItemID);
						if (itemRarity and itemRarity == 0) then
							IntelligentLoot:Print(Locale["Destroying"].." "..itemLink);
							PickupContainerItem(bagID, slotID);
							DeleteCursorItem();
							table.remove(lootDestroyInformation, index);
						end
					end			
				end
			end
		end
	end
end

function IntelligentLoot:OnLootWindowOpened(eventType, ...)
	if (... ~= nil) then
		if (getConfiguration(AutoLootKey)) then
			local lootCount = GetNumLootItems();
			for slot = 1, lootCount, 1 do
				IntelligentLoot_HandleSlotLooting(slot)
			end
		end
	end
end

function IntelligentLoot_HandleSlotLooting(lootSlot)
	local lootIcon, lootName, lootQuantity, lootQuality, locked, isQuestItem, questID, isActive = GetLootSlotInfo(lootSlot);
	local lootSlotType = GetLootSlotType(lootSlot);
	if (lootSlotType == LOOT_SLOT_ITEM) then
		local itemLink = GetLootSlotLink(lootSlot);
		local itemID = IntelligentLoot_GetItemIDFromItemLink(itemLink);
		local itemName, _, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemID);
		local currentState = getCurrentState();
		local isLootRequirementFulfilled = IsLootRequirementFulfilled(currentState, lootSlotType, lootQuantity, itemID, isQuestItem, itemLevel, itemRarity, itemStackCount, itemSellPrice);
		if (isLootRequirementFulfilled) then
			if (getConfiguration(MakeRoomLootKey, currentState) and not IntelligentLoot_HasFreeSlotInBagsOrFreeSpaceInExistingStacks(itemID, lootQuantity, itemStackCount)) then
				IntelligentLoot_MakeRoomInBags(IntelligentLoot_GetLootValue(lootQuantity, itemSellPrice));
			end
			LootSlot(lootSlot);
		elseif (getConfiguration(AlwaysLootOrDestroyLootKey, currentState)) then
			if (IntelligentLoot_ContainerSlotsAvailable) then
				table.insert(lootDestroyInformation, itemID);
			end
			LootSlot(lootSlot);
		end
	elseif (lootSlotType == LOOT_SLOT_MONEY) then
		if (getConfiguration(MoneyLootKey, currentState)) then
			LootSlot(lootSlot);
		end
	elseif (lootSlotType == LOOT_SLOT_CURRENCY) then
		if (getConfiguration(CurrencyLootKey, currentState)) then
			LootSlot(lootSlot);
		end
	end	
end

function IntelligentLoot_GetItemIDFromItemLink(itemLink)
	local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
	return Id;
end

function IntelligentLoot_GetLootValue(lootQuantity, itemSellPrice)
	if (lootQuantity and itemSellPrice) then
		return tonumber(lootQuantity * itemSellPrice);
	elseif (itemSellPrice) then
		return tonumber(itemSellPrice);
	end
	return 0;
end

function IsLootRequirementFulfilled(currentState, lootSlotType, lootQuantity, itemID, isQuestItem, itemLevel, itemRarity, itemStackCount, itemSellPrice)
	if (lootSlotType == LOOT_SLOT_ITEM) then
		if (getConfiguration(QuestLootKey, currentState)) then
			if (isQuestItem) then
				return true;
			end
		end
		if (getConfiguration(LevelOrAboveLootKey, currentState) and itemLevel) then
			local configuredLevel = tonumber(getConfiguration(LevelLootKey, currentState));
			local incomingLevel = tonumber(itemLevel);
			if (configuredLevel <= incomingLevel) then
				return true;
			end
		end
		if (getConfiguration(RarityOrAboveLootKey, currentState) and itemRarity) then
			local configuredRarity = tonumber(getConfiguration(RarityLootKey, currentState))-1;
			local incomingRarity = tonumber(itemRarity);
			if (configuredRarity <= incomingRarity) then
				return true;
			end
		end
		if (getConfiguration(InventoryLootKey, currentState) and itemID) then
			if (IntelligentLoot_InventoryAlreadyContainsItem(itemID)) then
				return true;
			end
		end
	elseif (lootSlotType == LOOT_SLOT_MONEY) then
		if (getConfiguration(MoneyLootKey, currentState)) then
			return true;
		end
	elseif (lootSlotType == LOOT_SLOT_CURRENCY) then
		if (getConfiguration(CurrencyLootKey, currentState)) then
			return true;
		end
	end	
end

function IntelligentLoot_ContainerSlotsAvailable()
	for bagID = 0, NUM_BAG_SLOTS do
		numberOfFreeSlots = GetContainerNumFreeSlots(bagID);
		if numberOfFreeSlots > 0 then
			return true;
		end
	end
	return false;
end

function IntelligentLoot_InventoryAlreadyContainsItem(itemID)
	for bagID = 0, NUM_BAG_SLOTS do
		numberOfContainerSlots = GetContainerNumSlots(bagID);
		if numberOfContainerSlots > 0 then
			for slotID = 1, numberOfContainerSlots do
				local containerItemID = GetContainerItemID(bagID, slotID);
				if (containerItemID and itemID and tonumber(containerItemID) == tonumber(itemID)) then
					return true;
				end
			end
		end
	end
	return false;
end

function IntelligentLoot_HasFreeSlotInBagsOrFreeSpaceInExistingStacks(lootItemID, lootQuantity, lootItemStackSize)
	if (not IntelligentLoot_ContainerSlotsAvailable()) then
		local freeSpaceInExistingStacks = 0;
		for bagID = 0, NUM_BAG_SLOTS do
			numberOfContainerSlots = GetContainerNumSlots(bagID);
			if numberOfContainerSlots > 0 then
				for slotID = 1, numberOfContainerSlots do
					local bagItemTexture, bagItemCount, bagItemLocked, bagItemQuality, bagItemReadable = GetContainerItemInfo(bagID, slotID);
					local containerItemID = GetContainerItemID(bagID, slotID);
					if (containerItemID and lootItemID == containerItemID) then
						freeSpaceInExistingStacks = addition(freeSpaceInExistingStacks, subtraction(lootItemStackSize, bagItemCount));
						if (lootQuantity <= freeSpaceInExistingStacks) then
							return true;
						end
					end
				end
			end
		end
	end
end

function IntelligentLoot_MakeRoomInBags(lootSellPrice)
	if (not IntelligentLoot_ContainerSlotsAvailable()) then
		local leastValuableVendorTrashStackValue, leastValuableVendorTrashBagID, leastValuableVendorTrashSlotID, leastValuableVendorTrashItemLink;
		for bagID = 0, NUM_BAG_SLOTS do
			numberOfContainerSlots = GetContainerNumSlots(bagID);
			if numberOfContainerSlots > 0 then
				for slotID = 1, numberOfContainerSlots do
					local bagItemTexture, bagItemCount, bagItemLocked, bagItemQuality, bagItemReadable = GetContainerItemInfo(bagID, slotID);
					local containerItemID = GetContainerItemID(bagID, slotID);
					if (containerItemID) then
						local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(containerItemID);
						if (itemRarity and itemRarity == 0) then
							local bagStackPrice = tonumber(bagItemCount * itemSellPrice);
							if (not leastValuableVendorTrashStackValue or leastValuableVendorTrashStackValue > bagStackPrice) then
								leastValuableVendorTrashStackValue = bagStackPrice;
								leastValuableVendorTrashBagID = bagID;
								leastValuableVendorTrashSlotID = slotID;
								leastValuableVendorTrashItemID = containerItemID;
								leastValuableVendorTrashItemLink = itemLink;
							end
						end
					end
				end
			end
		end
		if (not lootSellPrice or lootSellPrice > leastValuableVendorTrashStackValue) then
			IntelligentLoot:Print(Locale["Destroying"].." "..leastValuableVendorTrashItemLink)
			PickupContainerItem(leastValuableVendorTrashBagID, leastValuableVendorTrashSlotID);
			DeleteCursorItem();
		end
	end
end

function addition(x, y)
	if (x and y) then return x + y;
	elseif (x) then return x;
	elseif (y) then return y;
	else return 0 end;
end

function subtraction(x, y)
	if (x and y) then return x - y;
	elseif (x) then return x;
	elseif (y) then return -y;
	else return 0 end;
end


function IntelligentLoot:InitializeSettings()
	if (self.db.global.GlobalState == nil) then
		self.db.global.GlobalState = true;
	end
	if (self.db.global.SoloState == nil) then
		self.db.global.SoloState = initializeConfiguration();
	end
	if (self.db.global.PartyState == nil) then
		self.db.global.PartyState = initializeConfiguration();
	end
	if (self.db.global.RaidState == nil) then
		self.db.global.RaidState = initializeConfiguration();
	end
end

function initializeConfiguration()
	return {
		[AutoLootKey] = true,
		[MoneyLootKey] = true,
		[CurrencyLootKey] = true,
		[QuestLootKey] = true,
		[InventoryLootKey] = true,
		[RarityOrAboveLootKey] = false,
		[RarityLootKey] = 1,
		[LevelOrAboveLootKey] = false,
		[LevelLootKey] = 1,
		[MakeRoomLootKey] = false,
		[AlwaysLootOrDestroyLootKey] = false,
		[PriceLootKey] = 10000
	};
end
