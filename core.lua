-- TODO LIST (in no particular order):
--	overall:
--		1. Make sure all of the included librarys are getting used and get rid of any that aren't.
--		2. Incorperate more with Quick Auctions: mat cost, craft queue, scroll selling price.
--		3. Have the queue be refreshed when an enchant is cast and remove that enchant from the list.
--		4. Who doesn't love localizations?!
--		5. Look into better splitting up the files.
--		6. Fix the bug that causes problems when more than one window is open at a time.
--	core.lua:
--		1. Improve slash command navigation.
--		2. Improve the options interface. Possibly add buttons to open the other frames.
--	data.lua
--		1. Improve how extra mats are stored. Maybe give each one its own row of the matricies.
-- 		2. Save more information to DB instead of using globals.
--	gui.lua
--		1. Add tooltip functionality.
--		2. Make the text in the summary frame larger / easier to read.
--		3. Improve how the GUI closes / releases widgets and frames.
--		4. Get rid of the "Calculate Prices" buttons and caluclate them automatically upon loading the tab instead.

Slippy = LibStub("AceAddon-3.0"):NewAddon("Slippy", "AceConsole-3.0", "AceEvent-3.0")
AceGUI = LibStub("AceGUI-3.0")
version = "1.1" -- current version of the addon

-- options frame
local options = {
    name = "Slippy",
    handler = Slippy,
    type = "group",
    args = {
		infiniteDust = {
            type = "input",
            name = "Infinite Dust",
            desc = "The cost of 1 infinite dust in gold",
            get = "GetDust",
            set = "SetDust",
        },
		gce = {
            type = "input",
            name = "Greater Cosmic Essence",
            desc = "The cost of 1 greater cosmic essence in gold",
            get = "GetGCE",
            set = "SetGCE",
        },
		lce = {
            type = "input",
            name = "Lesser Cosmic Essence",
            desc = "The cost of 1 lesser cosmic essence in gold",
            get = "GetLCE",
            set = "SetLCE",
        },
		dream = {
            type = "input",
            name = "Dream Shard",
            desc = "The cost of 1 dream shard in gold",
            get = "GetDream",
            set = "SetDream",
        },
		abyss = {
            type = "input",
            name = "Abyss Crystal",
            desc = "The cost of 1 abyss crystal in gold",
            get = "GetAbyss",
            set = "SetAbyss",
        },
		titanium = {
            type = "input",
            name = "Titanium Bar",
            desc = "The cost of 1 Titanium Bar in gold",
            get = "GetTitanium",
            set = "SetTitanium",
        },
		water = {
            type = "input",
            name = "Crystallized Water",
            desc = "The cost of 1 Crystallized Water in gold",
            get = "GetWater",
            set = "SetWater",
        },
		earth = {
            type = "input",
            name = "Eternal Earth",
            desc = "The cost of 1 eternal earth in gold",
            get = "GetEarth",
            set = "SetEarth",
        },
		air = {
            type = "input",
            name = "Eternal Air",
            desc = "The cost of 1 eternal air in gold",
            get = "GetAir",
            set = "SetAir",
        },
		titansteel = {
            type = "input",
            name = "Titansteel Bar",
            desc = "The cost of 1 titansteel bar in gold",
            get = "GetTitansteel",
            set = "SetTitansteel",
        },
    },
}


-- default values for the different material costs for new profiles in SlippyDB
local defaults = {
    profile = {
		infiniteDust = 2,
		gce = 15,
		lce = 5,
		dream = 6,
		abyss = 29,
		titanium = 18,
		water = 0.2,
		earth = 6,
		air = 21,
		titansteel = 130,
    },
}

function Slippy:OnInitialize()
    -- Called when the addon is loaded
	self:Print("Loaded Slippy v" .. version .. "!")
    self.db = LibStub("AceDB-3.0"):New("SlippyDB", defaults, true)
    self:RegisterChatCommand("sl", "ChatCommand")
    self:RegisterChatCommand("slippy", "ChatCommand")
	Slippy:Register_Options_Frame() -- Loads options-table
	Slippy:FrameToggle()
	frame:Hide()
	--frame2:Hide()
	--SlippyGUI_Background:Hide()
end

function Slippy:OnEnable()
    -- Called when the addon is enabled
end

function Slippy:OnDisable()
    -- Called when the addon is disabled
end

-- deals with slash commands
function Slippy:ChatCommand(input)
    if not input or input:trim() == "" then --'/sl' or '/slippy' opens the options frame
		InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    elseif input == "show" then	--'/sl show' or '/slippy show' opens up the main window
		Slippy:FrameToggle()
	elseif input == "summary" then	--'/sl summary' or '/slippy summary' opens up the summary window
		Slippy:CalcTotals()
		frame2:Show()
		tab2:SelectTab("tab2")
		tab:SelectTab("tab1")
	elseif input == "test" then
	SlippyGUI_Background:Show()
	else	-- if the command is unrecognized, Ace deals with it.
        LibStub("AceConfigCmd-3.0").HandleCommand(Slippy, "sl", "Slippy", input)
    end
end

function Slippy:GetDust(info)
    return self.db.profile.dust
end

function Slippy:SetDust(info, newValue)
    self.db.profile.dust = newValue
end

function Slippy:GetGCE(info)
    return self.db.profile.gce
end

function Slippy:SetGCE(info, newValue)
    self.db.profile.gce = newValue
end

function Slippy:GetLCE(info)
    return self.db.profile.lce
end

function Slippy:SetLCE(info, newValue)
    self.db.profile.lce = newValue
end

function Slippy:GetDream(info)
    return self.db.profile.dream
end

function Slippy:SetDream(info, newValue)
    self.db.profile.dream = newValue
end

function Slippy:GetAbyss(info)
    return self.db.profile.abyss
end

function Slippy:SetAbyss(info, newValue)
    self.db.profile.abyss = newValue
end

function Slippy:GetTitanium(info)
    return self.db.profile.titanium
end

function Slippy:SetTitanium(info, newValue)
    self.db.profile.titanium = newValue
end

function Slippy:GetWater(info)
    return self.db.profile.water
end

function Slippy:SetWater(info, newValue)
    self.db.profile.water = newValue
end

function Slippy:GetEarth(info)
    return self.db.profile.earth
end

function Slippy:SetEarth(info, newValue)
    self.db.profile.earth = newValue
end

function Slippy:GetAir(info)
    return self.db.profile.air
end

function Slippy:SetAir(info, newValue)
    self.db.profile.air = newValue
end

function Slippy:GetTitansteel(info)
    return self.db.profile.titansteel
end

function Slippy:SetTitansteel(info, newValue)
    self.db.profile.titansteel = newValue
end

-- gets called whenever the value of a checkbox is changed
-- this function takes in the new value of the checkbox (true/false) as well as
-- the slot which corresponds to the type of item the enchant is for (boots, bracers, staff, etc)
-- and also it takes in a number corresponding to the enchant
-- it then sets the correct array from the data.lua file to the value of the checkbox
function Slippy:SetEnchant(value, slot, enchant)
	if slot == 1 then
		twoH[1][enchant] = value
	elseif slot == 2 then
		boots[1][enchant] = value
	elseif slot == 3 then
		bracers[1][enchant] = value
	elseif slot == 4 then
		chest[1][enchant] = value
	elseif slot == 5 then
		cloak[1][enchant] = value
	elseif slot == 6 then
		gloves[1][enchant] = value
	elseif slot == 7 then
		shield[1][enchant] = value
	elseif slot == 8 then
		staff[1][enchant] = value
	elseif slot == 9 then
		weapon[1][enchant] = value
	else print("Error: SetEnchant could not determine slot.") end
end

-- Calculates the costs for all of the 2H weapon enchants
function Slippy:CalcTwoH()
	for i=1, 2 do
		twoH[8][i] = twoH[2][i]*self.db.profile.dust + twoH[3][i]*self.db.profile.gce +
			twoH[4][i]*self.db.profile.lce + twoH[5][i]*self.db.profile.dream + twoH[6][i]*self.db.profile.abyss
		GUItable[2][1][i]:SetText(twoH[8][i] .. "g")
	end
end

-- Calculates the costs for all of the boot enchants
function Slippy:CalcBoots()
	boots[7][1] =1*self.db.profile.water
	for i=1, 8 do
		boots[8][i] = boots[2][i]*self.db.profile.dust + boots[3][i]*self.db.profile.gce + boots[4][i]*self.db.profile.lce
			+ boots[5][i]*self.db.profile.dream + boots[6][i]*self.db.profile.abyss + boots[7][i]
		GUItable[2][2][i]:SetText(boots[8][i] .. "g")
	end
end

-- Calculates the costs for all of the bracer enchants
function Slippy:CalcBracers()
	for i=1, 9 do
		bracers[8][i] = bracers[2][i]*self.db.profile.dust + bracers[3][i]*self.db.profile.gce +
			bracers[4][i]*self.db.profile.lce + bracers[5][i]*self.db.profile.dream + bracers[6][i]*self.db.profile.abyss
		GUItable[2][3][i]:SetText(bracers[8][i] .. "g")
	end
end

-- Calculates the costs for all of the chest enchants
function Slippy:CalcChest()
	chest[7][3] = 1*self.db.profile.earth
	for i=1, 8 do
		chest[8][i] = chest[2][i]*self.db.profile.dust + chest[3][i]*self.db.profile.gce + chest[4][i]*self.db.profile.lce
			+ chest[5][i]*self.db.profile.dream + chest[6][i]*self.db.profile.abyss + chest[7][i]
		GUItable[2][4][i]:SetText(chest[8][i] .. "g")
	end
end

-- Calculates the costs for all of the cloak enchants
function Slippy:CalcCloak()
	cloak[7][5] = 2*self.db.profile.titanium
	for i=1, 9 do
		cloak[8][i] = cloak[2][i]*self.db.profile.dust + cloak[3][i]*self.db.profile.gce + cloak[4][i]*self.db.profile.lce
			+ cloak[5][i]*self.db.profile.dream + cloak[6][i]*self.db.profile.abyss + cloak[7][i]
		GUItable[2][5][i]:SetText(cloak[8][i] .. "g")
	end
end

-- Calculates the costs for all of the glove enchants
function Slippy:CalcGloves()
	gloves[7][4] = 8*self.db.profile.earth
	for i=1, 7 do
		gloves[8][i] = gloves[2][i]*self.db.profile.dust + gloves[3][i]*self.db.profile.gce + gloves[4][i]*self.db.profile.lce
			+ gloves[5][i]*self.db.profile.dream + gloves[6][i]*self.db.profile.abyss + gloves[7][i]
		GUItable[2][6][i]:SetText(gloves[8][i] .. "g")
	end
end

-- Calculates the costs for all of the shield enchants
function Slippy:CalcShield()
	shield[7][2] = 6*self.db.profile.earth
	for i=1, 2 do
		shield[8][i] = shield[2][i]*self.db.profile.dust + shield[3][i]*self.db.profile.gce + shield[4][i]*self.db.profile.lce
			+ shield[5][i]*self.db.profile.dream + shield[6][i]*self.db.profile.abyss + shield[7][i]
		GUItable[2][7][i]:SetText(shield[8][i] .. "g")
	end
end

-- Calculates the costs for all of the staff enchants
function Slippy:CalcStaff()
	for i=1, 2 do
		staff[8][i] = staff[2][i]*self.db.profile.dust + staff[3][i]*self.db.profile.gce + staff[4][i]*self.db.profile.lce
			+ staff[5][i]*self.db.profile.dream + staff[6][i]*self.db.profile.abyss
		GUItable[2][8][i]:SetText(staff[8][i] .. "g")
	end
end

-- Calculates the costs for all of the weapon enchants
function Slippy:CalcWeapon()
	weapon[7][1] =1*self.db.profile.titansteel
	weapon[7][6] =4*self.db.profile.air
	for i=1, 9 do
		weapon[8][i] = weapon[2][i]*self.db.profile.dust + weapon[3][i]*self.db.profile.gce + weapon[4][i]*self.db.profile.lce
			+ weapon[5][i]*self.db.profile.dream + weapon[6][i]*self.db.profile.abyss + weapon[7][i]
		GUItable[2][9][i]:SetText(weapon[8][i] .. "g")
	end
end

-- Calculates the total number of mats needed to craft the selected enchants
function Slippy:CalcTotals()
	for i=1, 13 do	-- resets the totals to 0
		totals[i] = 0
	end
	
	-- This series of for loops is where all the magic happens!
	-- The function BooleanToNumber converts the true/false value that represents
	-- if that enchant is selected or not to a 1 for true or a 0 for false.
	-- This is then multiplied by the number of the specific material needed for that enchant
	-- and added to the total of that specific material required for all selected enchants.
	-- Also, for each enchant selected, 1 is added to the number of the respective vellum needed
	-- to make an enchanting scroll for that enchant.
	for k=1, 5 do
		for i=1, 2 do
			totals[k] = totals[k] + staff[k+1][i]*Slippy:BooleanToNumber(staff[1][i]) +
				shield[k+1][i]*Slippy:BooleanToNumber(shield[1][i]) +
				twoH[k+1][i]*Slippy:BooleanToNumber(twoH[1][i])
			if k == 1 then
				totals[11] = totals[11] + Slippy:BooleanToNumber(staff[1][i]) + Slippy:BooleanToNumber(twoH[1][i])
				totals[12] = totals[12] + Slippy:BooleanToNumber(shield[1][i])
			end
		end
		
		for i=1, 7 do
			totals[k] = totals[k] + gloves[k+1][i]*Slippy:BooleanToNumber(gloves[1][i])
			if k == 1 then
				totals[12] = totals[12] + Slippy:BooleanToNumber(gloves[1][i])
			end
		end
		
		for i=1, 8 do
			totals[k] = totals[k] + boots[k+1][i]*Slippy:BooleanToNumber(boots[1][i]) +
				chest[k+1][i]*Slippy:BooleanToNumber(chest[1][i])
			if k == 1 then
				totals[12] = totals[12] + Slippy:BooleanToNumber(boots[1][i]) +	Slippy:BooleanToNumber(chest[1][i])
			end
		end
		
		for i=1, 9 do
			totals[k] = totals[k] + weapon[k+1][i]*Slippy:BooleanToNumber(weapon[1][i]) +
				cloak[k+1][i]*Slippy:BooleanToNumber(cloak[1][i]) +
				bracers[k+1][i]*Slippy:BooleanToNumber(bracers[1][i])
			if k == 1 then
				totals[11] = totals[11] + Slippy:BooleanToNumber(weapon[1][i])
				totals[12] = totals[12] + Slippy:BooleanToNumber(cloak[1][i]) + Slippy:BooleanToNumber(bracers[1][i])
			end
		end
	end
	-- these few commands deal with the extra materials (titanium bar, eternals, etc)
	totals[6] = totals[6] + 2*Slippy:BooleanToNumber(cloak[1][5])
	totals[7] = totals[7] + Slippy:BooleanToNumber(boots[1][1])
	totals[8] = totals[8] + Slippy:BooleanToNumber(chest[1][3]) + 6*Slippy:BooleanToNumber(shield[1][2]) +
		8*Slippy:BooleanToNumber(gloves[1][4])
	totals[9] = totals[9] + 4*Slippy:BooleanToNumber(weapon[1][6])
	totals[10] = totals[10] + Slippy:BooleanToNumber(weapon[1][1])
	
	-- calculates the total number of enchants selected by adding the weapon and armor vellum totals
	totals[13] = totals[12] + totals[11]
end

function Slippy:BooleanToNumber(value)	-- simple function to convert true->1 and false->0
	if value==true then	return 1
	elseif value==false then return 0
	else print("Error: BooleanToNumber could not determine value")
	end
end

function Slippy:ResetData()	-- resets all of the data when the "Reset Craft Queue" button is pressed
	staff[1] = {false, false}
	staff[8] = {0, 0}
	shield[1] = {false, false}
	shield[8] = {0, 0}
	twoH[1] = {false, false}
	twoH[8] = {0, 0}
	gloves[1] = {false, false, false, false, false, false, false}
	gloves[8] = {0, 0, 0, 0, 0, 0, 0}
	chest[1] = {false, false, false, false, false, false, false, false}
	chest[8] = {0, 0, 0, 0, 0, 0, 0, 0}
	boots[1] = {false, false, false, false, false, false, false, false}
	boots[8] = {0, 0, 0, 0, 0, 0, 0, 0}
	weapon[1] = {false, false, false, false, false, false, false, false, false}
	weapon[8] = {0, 0, 0, 0, 0, 0, 0, 0, 0}
	bracers[1] = {false, false, false, false, false, false, false, false, false}
	bracers[8] = {0, 0, 0, 0, 0, 0, 0, 0, 0}
	cloak[1] = {false, false, false, false, false, false, false, false, false}
	cloak[8] = {0, 0, 0, 0, 0, 0, 0, 0, 0}
	
	tab2:SelectTab("tab22")
end