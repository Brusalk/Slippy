function Slippy:FrameToggle()
		local totalCost = "0"
		local function DrawGroup1(container)
		  local desc = AceGUI:Create("Label")
		  desc:SetText("This is Tab 1")
		  desc:SetFullWidth(true)
		  container:AddChild(desc)
		  
		  local button = AceGUI:Create("Button")
		  button:SetText("Tab 1 Button")
		  button:SetWidth(200)
		  container:AddChild(button)
		  button:SetCallback("OnClick", function() self.frame:hide() end)
end

		-- function that draws the widgets for the second tab
		local function DrawGroup2(container)
		  local desc = AceGUI:Create("Label")
		  desc:SetText("This is Tab 2")
		  desc:SetFullWidth(true)
		  container:AddChild(desc)
		  
		  local button = AceGUI:Create("Button")
		  button:SetText("Tab 2 Button")
		  button:SetWidth(200)
		  container:AddChild(button)
		end

		-- Callback function for OnGroupSelected
		local function SelectGroup(container, event, group)
		   container:ReleaseChildren()
		   if group == "tab1" then
			  DrawGroup1(container)
		   elseif group == "tab2" then
			  DrawGroup2(container)
		   end
		end

		-- Create the frame container
		frame = AceGUI:Create("Frame")
		frame:SetTitle("Example Frame")
		frame:SetStatusText(totalCost)
		frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
		frame:SetCallback("OnHide", function() AceGUI:ReleaseChildren(container)end)
		-- Fill Layout - the TabGroup widget will fill the whole frame
		frame:SetLayout("List")

		-- Create the TabGroup
		tab =  AceGUI:Create("TabGroup")
		tab:SetLayout("Flow")
		tab:SetRelativeWidth(1)
		tab:SetHeight(400)
		-- Setup which tabs to show
		tab:SetTabs({{text="Tab 1", value="tab1"}, {text="Tab 2", value="tab2"}})
		-- Register callback
		tab:SetCallback("OnGroupSelected", SelectGroup)
		-- Set initial Tab (this will fire the OnGroupSelected callback)
		tab:SelectTab("tab1")

		tab2 = AceGUI:Create("TabGroup")
		--tab2:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
		tab2:SetRelativeWidth(1)
		tab2:SetLayout("Flow")
		tab2:SetTabs({{text="Tab 1", value="tab1"}, {text="Tab 2", value="tab2"}})
		-- Register callback
		tab2:SetCallback("OnGroupSelected", SelectGroup)
		-- Set initial Tab (this will fire the OnGroupSelected callback)
		tab2:SelectTab("tab1")
		-- add to the frame container
		frame:AddChild(tab)
		frame:AddChild(tab2)
		Slippy_Frame_Shown_12356741 = "1"
end


local slippy_options_frame = { -- Config Settings!!!!
		type = "group", 
		args = {
			SlippyOptionsDescription = {
				type = "description",
				name = "Easy way to view the materials and total estimated cost of user selected current enchants.\nFeel free to contact us at |cff00ff00SlippyAddon@gmail.com\r",
			},
--Options Frame!
			SlippyOptionsHeader = {
				order = 2,
				type = "header",
				name = GetAddOnMetadata("Slippy", "title").." v"..GetAddOnMetadata("Slippy", "version"),
			},
			SlippyOptFrame = {
		        order = 3,
		        type  = "group",
       			name  = "Enchant Options",
				handler = Slippy,
		        args = {
					Header = {  -- Title which appears as a main-tab-option
						type = "header",
						order = 1,
						name = "Enchant Options"
					},
					description = {  -- Description - shows up at the top of the right-pane
						type = "description",
						order = 2,
						name = "Set values for materials in gold.\nExample: 20.32 = 20 Gold, 32 Silver",
					},
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
			},
		},
	}
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


	function Slippy:Register_Options_Frame() 
	    LibStub("AceConfig-3.0"):RegisterOptionsTable("Slippy", slippy_options_frame)
		--LibStub("AceConfig-3.0"):RegisterOptionsTable("Slippy", options)
		self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Slippy", "Slippy")
	end
	
	function Slippy:CreateFrame(anchor,anchorpoint,x,y,width,height,name,type1,buttonText) --Creates a frame with the proper offsets. Easy of coding purposes. Returns a reference to the created frame.
		TempFrame=CreateFrame(type1,"SlippyGUI_MainBackground_Frame_"..name,anchor)
		if(TempFrame:IsVisible()) then
			while 1>0 do
				if(TempFrame:IsVisible()==nil) then
					break;
				end
				TempFrame:Hide()
			end
		end
		
		if(strlower(type1)=="button") then
			MyFrame=CreateFrame(type1,"SlippyGUI_MainBackground_Frame_"..name,anchor,"UIPanelButtonTemplate")
			MyFrame:SetText(buttonText)
		else
			MyFrame=CreateFrame(type1,"SlippyGUI_MainBackground_Frame_"..name,anchor)
		end
		MyFrame:SetPoint(anchorpoint,x,y)
		MyFrame:SetWidth(width)
		MyFrame:SetHeight(height)
		return MyFrame
	end
	function Slippy:SlippyGUI_SelectGroup(number)  -- the long and complicated function which handles ALL swapping of Main content for the main-frame. The basic gist of it is that it inputs a number which corresponds to a button on the left-menu. That number is then used to create a frame and anchor that frame to the main-content area.
			local kids = {SlippyGUI_MainBackground1:GetChildren()};
			for _, child in ipairs(kids) do
				child:hide()
			end
			
			f=Slippy:CreateFrame(SlippyGUI_MainBackground1,"TOPLEFT",15,-15,555,310,"Test","Frame")
			g=Slippy:CreateFrame(f,"TOPLEFT",5,-5,100,20,"Button_1Test","Button","This is Some text")
	
			
			
	end

	--IGNORE THIS. This is from another project :3 --
	
	
	
	
	
	
	
	
	
	
	
	
	
	---------------------------------------------
	
	
	
	
	
	function Slippy:GetPlayerFacing1(unit)
	
		local x1,y1 = Slippy:GetPlayerMapPosition("player")
		local x2,y2
		local playerfacing = GetPlayerFacing()
		mapname = GetMapInfo()
		local list = MapDims[mapname]
		--if not list then return end
		local level = GetCurrentMapDungeonLevel()
		local dims = list[level]
		if not dims then 
			if level == 0 and list[1] then
				SetMapToCurrentZone()
				level = GetCurrentMapDungeonLevel()
				dims = list[level]
				if not dims then return end
			else return end
		end
		x2,y2 = GetPlayerMapPosition(unit)
		local dx = (x2 - x1) * dims.w
		local dy = (y2 - y1) * dims.h
		
		local to_return 
		local relative_facing = math.atan(dx/dy)  -- Value of theta between us, and the target  ->> SohCahToa ftw
		if(dy>0) then
			if(dx>0) then
				print("1")
				to_return =  math.abs(((2*math.pi)-relative_facing)-playerfacing)  -- Target is infront and to the right.
			elseif(dx<0) then
			print("2")
				to_return =  math.abs(relative_facing-playerfacing) -- target is infront and to the left
			else
			print("3")
				to_return =  0  -- Target is right in front of you
			end
		elseif(dy<0) then
			if(dx>0) then
			print("4")
				to_return =  math.abs(((math.pi)+relative_facing)-playerfacing)  -- target is behind and to the right
			elseif(dx<0) then
			print("5")
				to_return =  ((math.pi)-relative_facing)-playerfacing  -- target is behind and to the left
			else
			print("6")
				to_return =  math.pi	-- target is right behind you.
			end
		else
			if(dx>0) then
			print("7")
				to_return =  math.abs(((3*math.pi)/2))  -- target to the right  ->> Hurray for exact values!!! <<-
			elseif(dx<0) then	-- target is to the left!
			print("8")
				to_return =  math.abs(math.pi/2)  -- target is behind and to the left
			else
			print("9")
				to_return =  -1	-- target is ON YOU
			end
		end
	return math.deg(to_return)
end


function Slippy:GetPlayerMapPosition(unit)
	local x,y = GetPlayerMapPosition(unit)
	if x <= 0 and y <= 0 then
		SetMapToCurrentZone()
		x,y = GetPlayerMapPosition(unit) 
	end
	return x,y
end

-------------------------
-- MAP DIMENSIONS
-------------------------
MapDims= {
	Ulduar = {
		[1] = {w = 3064.9614761023, h = 2039.5413309668}, 	-- Expedition Base Camp
		[2] = {w = 624.19069622949, h = 415.89374357805}, 	-- Antechamber of Ulduar
		[3] = {w = 1238.37427179,   h = 823.90183235628}, 	-- Conservatory of Life
		[4] = {w = 848.38069183829, h = 564.6688835337}, 	-- Prison of Yogg-Saron
		[5] = {w = 1460.4694647684, h = 974.65312886234},  -- Spark of Imagination
		[6] = {w = 576.71549337896, h = 384.46653291368},  -- The Mind's Eye (Under Yogg)
	},
	Naxxramas = {
		[1] = {w = 1018.3655494957, h = 679.40523953718}, -- Construct
		[2] = {w = 1019.1310739251, h = 679.18864376555}, -- Arachnid
		[3] = {w = 1118.1083638787, h = 744.57895516418}, -- Military
		[4] = {w = 1117.0809918236, h = 745.97398439776}, -- Plague
		[5] = {w = 1927.3190541014, h = 1284.6530841959}, -- Entrance
		[6] = {w = 610.62737087301, h = 407.3875157986},  -- KT/Sapphiron
	},
	TheObsidianSanctum = {
		[0] = {w = 1081.6334214432, h = 721.79860069158},
	},
	TheEyeofEternity = {
		[1] = {w = 400.728405332355, h = 267.09113174487},
	},
	TheArgentColiseum = {
		[1] = {w = 344.20785972537, h = 229.57961178118},
		[2] = {w = 688.60679691348, h = 458.95801567569},
	},
	VaultofArchavon = {
		[1] = {w = 842.2254908359, h = 561.59878021123},
	},
	IcecrownCitadel = {
		[1] = {w = 1262.8025621533, h = 841.91669450207}, -- The Lower Citadel
		[2] = {w = 993.25701607873, h = 662.58829476644}, -- The Rampart of Skulls
		[3] = {w = 181.83564716405, h = 121.29684810833}, -- Deathbringer's Rise
		[4] = {w = 720.60965618252, h = 481.1621506613}, -- The Frost Queen's Lair
		[5] = {w = 1069.6156745738, h = 713.83371679543}, -- The Upper Reaches
		[6] = {w = 348.05218433541, h = 232.05964286208}, -- Royal Quarters
	},
}
	
	
	
	
	
	
	
	
	