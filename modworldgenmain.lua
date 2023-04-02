GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

--[[
客户端ui界面大部分是借鉴熔炉mod https://steamcommunity.com/sharedfiles/filedetails/?id=1938752683 
但直接抄也会有问题，就是预设加载问题，这部分是本人从报错的一步步看源码，一点点测试得到的。
]]
if rawget(GLOBAL,"WorldSim") then
    local idx = getmetatable(WorldSim).__index
    local SetWorldSize_ = idx.SetWorldSize
    local ConvertToTileMap_ = idx.ConvertToTileMap
    idx.SetWorldSize = function(self,a,b) SetWorldSize_(self,100,100) end --没有啥用的
	local size = tonumber(GetModConfigData("minmap"))
    idx.ConvertToTileMap = function(self,x) ConvertToTileMap_(self,size) end --设置地图大小,单位一地皮
end

local StaticLayout = require("map/static_layout")
local obj_layout = require("map/object_layout")
local Layouts = require("map/layouts").Layouts

Layouts["DefaultStart1"] = StaticLayout.Get("map/static_layouts/default_start1", {
    start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    layout_position = LAYOUT_POSITION.CENTER,

	defs={
		--有特别活动吗
		welcomitem = IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) and {"pumpkin_lantern"} or {"flower"},
	},
})

Layouts["Ocean_Boss"] = StaticLayout.Get("map/static_layouts/boss", {
    start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    layout_position = LAYOUT_POSITION.CENTER,
    add_topology = {room_id = "StaticLayoutIsland:OceanBoss", tags = {"sandstorm"}, node_type = 7},

	defs={
		--有特别活动吗
		welcomitem = IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) and {"pumpkin_lantern"} or {"flower"},
	},
})

-- 中庭布局
Layouts["Atrium_End"] = StaticLayout.Get("map/static_layouts/rooms/atrium_end/atrium_end", {
    start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    layout_position = LAYOUT_POSITION.CENTER,
    add_topology = {room_id = "StaticLayoutIsland:AtriumEnd", tags = {"Atrium"}, node_type = 7},

	defs={
		--有特别活动吗
		welcomitem = IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) and {"pumpkin_lantern"} or {"flower"},
	},
})

-- 小月岛布局
Layouts["Ocean_Moon"] = StaticLayout.Get("map/static_layouts/ocean_moon", {
    start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    layout_position = LAYOUT_POSITION.CENTER,
    add_topology = {room_id = "StaticLayoutIsland:OceanMoon", tags = {"lunacyarea"}, node_type = 7},

	defs={
		--有特别活动吗
		welcomitem = IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) and {"pumpkin_lantern"} or {"flower"},
	},
})

-- 小月岛布局
Layouts["Ocean_Moon2"] = StaticLayout.Get("map/static_layouts/ocean_moon", {
    start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
    layout_position = LAYOUT_POSITION.CENTER,
    add_topology = {room_id = "StaticLayoutIsland:OceanMoon2", tags = {"lunacyarea"}, node_type = 7},

	defs={
		--有特别活动吗
		welcomitem = IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) and {"pumpkin_lantern"} or {"flower"},
	},
})

-- 移除蟹岛上面的物品
Layouts["HermitcrabIsland"].layout["sapling_moon"] = nil
Layouts["HermitcrabIsland"].layout["bullkelp_beachedroot"] = nil
Layouts["HermitcrabIsland"].layout["moon_tree"] = nil
Layouts["HermitcrabIsland"].layout["moonglass_rock"] = nil

Layouts["HermitcrabIsland"].layout["singingshell_octave3"] = nil
Layouts["HermitcrabIsland"].layout["singingshell_octave4"] = nil
Layouts["HermitcrabIsland"].layout["singingshell_octave5"] = nil
Layouts["HermitcrabIsland"].layout["moonglass"] = nil
Layouts["HermitcrabIsland"].layout["twigs"] = nil
Layouts["HermitcrabIsland"].layout["driftwood_tall"] = nil
Layouts["HermitcrabIsland"].layout["driftwood_small1"] = nil
Layouts["HermitcrabIsland"].layout["driftwood_small2"] = nil
Layouts["HermitcrabIsland"].layout["flint"] = nil

--MonkeyIsland
Layouts["MonkeyIsland"].layout["pirate_flag_pole"] = nil
Layouts["MonkeyIsland"].layout["boat_cannon"] = nil
Layouts["MonkeyIsland"].layout["monkeytail"] = nil
Layouts["MonkeyIsland"].layout["palmconetree"] = nil
Layouts["MonkeyIsland"].layout["monkeyisland_portal_debris"] = nil
Layouts["MonkeyIsland"].layout["bananabush"] = nil
Layouts["MonkeyIsland"].layout["dock_woodposts"] = nil
Layouts["MonkeyIsland"].layout["boat_pirate"] = nil



-- Layouts["HermitcrabIsland"].add_topology.tags = {"lunacyarea"}
-- 使得瓶中信可查岛
if obj_layout.LayoutForDefinition("桃园") then -- 判断一下是否加载了神话内容 如果加载了那么为神话岛添加id 方便查找
	Layouts["桃园"].add_topology = {room_id = "StaticLayoutIsland:peach"}
	Layouts["广寒宫"].add_topology = {room_id = "StaticLayoutIsland:ghg"}
	Layouts["熊猫林"].add_topology = {room_id = "StaticLayoutIsland:xml"}
end

----------------------------------------------------------------------------------------------------------------

-- 定义海洋房间
AddRoom("OceanSwell_cs", {
					colour={r=.5,g=0.6,b=.080,a=.10},
					value = GROUND.OCEAN_SWELL,
					contents =  {
						distributepercent = 0.001,
						distributeprefabs =
						{
							oceanfish_shoalspawner = 0.01, --鱼场
                        },
						countstaticlayouts =
						{
					        ["Atrium_End"] = {count = 1},
						},
					}})


--自定义起始位置
AddStartLocation("cs_sl", {
    name = "测试起始地",
    location = "forest",
    --起始布局
    start_setpeice = "DefaultStart1",
    --房间
    start_node = "Blank",
})

AddTask("Isolated Island", {
		locks={},
		keys_given={},
		room_choices={
			["Blank"] = 1, -- 添加空白房间
		},
		room_bg=GROUND.GRASS,
		background_room="Blank", --也为空白房间
		colour={r=0,g=1,b=0,a=1}
	})
local task_set = {
    name = "海岛",
    location = "forest",
    tasks = {
		"Isolated Island",
    },
    --保留原因是用于覆盖
    numoptionaltasks = 0,
    optionaltasks = {},
    valid_start_tasks = nil,
    required_prefabs = {},
    set_pieces = {},

	ocean_prefill_setpieces = {
		["BrinePool1"] = {count = 1},
		["Waterlogged1"] = {count = 1},
		["Waterlogged2"] = {count = 1},
		["CrabKing"] = {count =1},
		["HermitcrabIsland"] = {count =1},
		["MonkeyIsland"] = {count =1},
		["Ocean_Moon"] = {count =1},
		["Ocean_Moon2"] = {count =1},
		["Ocean_Boss"] = {count =1},
    },
    
    -- 海洋房间
	ocean_population = {
		"OceanSwell_cs",
	},
}
--生物群落设置
AddTaskSet("cs_sz2", task_set)
local overrides = {
    start_location = "cs_sl",
    season_start = "default",
    world_size = "default",
    task_set = "cs_sz2",
    layout_mode = "LinkNodesByKeys",
    wormhole_prefab = "wormhole",
    roads = "never",
    --birds = "never",
	keep_disconnected_tiles = true,
	no_wormholes_to_disconnected_tiles = true,
	no_joining_islands = true,
	has_ocean = true,
	is_oceanfishing = true, --标记用的, 专服要么拷贝客户端的leveldataoverride.lua 要么自己在它中的overrides添加这一条
}

-- 省一下进行服务器世界设置
AddLevelPreInitAny(function(self)
	if self.location == "forest" and self.id ~= "CS_ZDY_YS1" then --加载世界设置时
		self:SetID("CS_ZDY_YS1")
		self:SetBaseID("CS_ZDY_YS1")

		for key, vel in pairs(overrides) do
			self.overrides[key] = vel
		end

		for k, v in pairs(task_set) do
			self[k] = v
		end
	end	
end)
