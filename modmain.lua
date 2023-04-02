GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {
    "fishingsurprised", -- 钓起事件时的特效物品
    "artificial_atrium_gate", -- 钓起织影者的伪·大门
    "ancient_hulk",
    "hamlet_fx",
    "laser_ring",
    "laser",
    "rock_basalt",
}

--------------------------模组设置-------------------------------
GLOBAL.setsleeper = GetModConfigData("sleeper") or false -- 生物钓起是睡眠
GLOBAL.build = GetModConfigData("build") or false --钓起建筑

-- 中庭重置时间
TUNING.ATRIUM_GATE_COOLDOWN = (GetModConfigData("atriumgate") or 20) * TUNING.TOTAL_DAY_TIME

-- 风滚草是否可捕捉
TUNING.CAN_CATCH_TUMBLEWEED=GetModConfigData("cancatch_tumbleweed_switch")

-- 加载受难模式
modimport("scripts/suffering.lua") 
--------------------------------------------------------

-- 覆盖本mod已设置的钓起物表
HARVEST = HARVEST or nil
-- 本mod, 钓起执行的方法
TUNING.OCEANFISHINGROD_E = TUNING.OCEANFISHINGROD_E or {}
TUNING.OCEANFISHINGROD_E.oceanfishingrod = require("event_table")

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT =
{
    WILSON = {},
    WILLOW = {"lighter", "bernie_inactive"},
    WENDY = {"abigail_flower"},
    WOLFGANG = {"dumbbell"},
    WX78 = {"wx78_scanner_item", "wx78_moduleremover"},
    WICKERBOTTOM = {"papyrus"},
    WES = {"balloons_empty"},
    WAXWELL = {"waxwelljournal", "nightmarefuel", "nightmarefuel"},
    WOODIE = {"lucy"},
    WATHGRITHR = {"spear", "footballhat", "smallmeat", "smallmeat", "smallmeat", "smallmeat"},
    WEBBER = {"spidereggsack", "monstermeat", "monstermeat", "spider_whistle"},
    WINONA = {"sewing_tape", "sewing_tape", "sewing_tape"},
    WORTOX = {"wortox_soul", "wortox_soul", "wortox_soul"},
    WORMWOOD = {},
    WARLY = {"portablecookpot_item"},
    WURT = {},
    WALTER = {"walterhat", "slingshot", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite", "slingshotammo_thulecite"},
    WANDA = {"pocketwatch_heal", "pocketwatch_parts"},
    WONKEY = {},
},

--[[ 
--钓起后执行方法, 也可以不用, 直接写在下面 的 event 里
TUNING.OCEANFISHINGROD_E = TUNING.OCEANFISHINGROD_E or {}
TUNING.OCEANFISHINGROD_E.xxxx = { -- xxxx是自己命名，确保其他mod不同, 与下面的应该要保持一致
    funxxx = function(inst, player) --参数是: 物品 钓起玩家
    end
}
--设置额外钓起的内容
TUNING.OCEANFISHINGROD_R = TUNING.OCEANFISHINGROD_R or {}
TUNING.OCEANFISHINGROD_R.xxxx = { -- xxxx是自己命名，确保唯一性
    {
        chance = 1, -- 权重, 必填
        item = "log" or {"log"}, -- 名称,如果是物品,则为预制体名称, 必填, 通常名称不应该重复。
        name = "", -- 命名, 用于宣告, announce无需添加此项也会宣告。
        eventF = function(inst, player) end, -- 钓起时执行事件。
        eventA = function(inst, player) end, -- 钓起后执行事件。
        build = true, -- 钓起时是建筑, true 是建筑, 默认是物品。
        sleeper = true, -- 钓起时睡眠, true 是不睡觉, 默认睡眠。
        hatred = true, -- 钓起时仇恨玩家, true 是不仇恨, 默认仇恨。
        announce = true, -- 钓起时进行宣告, true 是宣告, 默认不宣告。
    },
    default = { -- 项参数默认值。 可有可无, 其他项对应参数为空时, 为其他项添加对应参数的默认值。
        build = ,
        sleeper = ,
        hatred = ,
        announce = ,
    }
} 
-- 说明:
-- build, 即使是建筑, 不添加, 将视为物品一样被钓起, 生物也视为物品。
-- sleeper hatred, 钓起物是生物才要添加。
-- 事件也归为物品, 利用了 fishingsurprised 特效物品, 要执行的方法放到 eventF 或 eventA 里。
--]]
--------------------------------------------
-- 设置海钓竿
modimport("scripts/setoceanfishingrod.lua")
---------------------------------------------
--开局赠送 海钓杆\船套装\桨
local function IsStart(name)
    if TheWorld.components.worldstate.data.new_fishing[name] == nil then
        TheWorld.components.worldstate.data.new_fishing[name] = 0
        return true
    end
    return false
end

--设置随机皮肤
local function setRandomSkinFgc(item,player)
	--生成皮肤
	local skin_list={}--皮肤列表
	if item:IsValid() and PREFAB_SKINS[item.prefab] ~= nil then
		if player~=nil and player:HasTag("player") then
			for _,item_type in pairs(PREFAB_SKINS[item.prefab]) do
				--如果玩家能使用皮肤，插入皮肤列表
				if TheInventory:CheckClientOwnership(player.userid, item_type) then
					table.insert(skin_list,item_type)
				end
			end
			if #skin_list>0 then
				--更改目标皮肤（目标全局标识符，原皮肤名，新皮肤名，xxx，玩家ID）
				TheSim:ReskinEntity(item.GUID, item.skinname, skin_list[math.random(#skin_list)], nil, player.userid )
			end
		end
	end
end

AddPrefabPostInit("world", function(inst)
    if TheWorld.ismastersim then --判断是不是主机
        if inst.components.worldstate and inst.components.worldstate.data and inst.components.worldstate.data.new_fishing == nil then --利用组件保存
            inst.components.worldstate.data.new_fishing = {} -- 仅第一次进入游戏
        end
        inst:ListenForEvent("ms_playerspawn", function(inst, player)
            local CurrentOnNewSpawn = player.OnNewSpawn or function() return true end -- 记录角色本身开局物品
            

            player.OnNewSpawn = function(...)
                if IsStart(player.userid) then

                    for k = 1, player.components.inventory.maxslots do
                        local v = player.components.inventory.itemslots[k]
                        --if k<3 then TheNet:Announce( " 第 " .. k .. "个东西是" .. v.prefab) end
                        if v ~= nil and v.prefab == "wathgrithrhat" then
                            TheNet:Announce( " 有 " .. v.prefab)
                            player.components.inventory.itemslots[k] = SpawnPrefab("footballhat")
                        end
                        if v ~= nil and v.prefab == "meat" then
                            TheNet:Announce( " 有 " .. v.prefab)
                            player.components.inventory.itemslots[k] = SpawnPrefab("smallmeat")
                        end
                    end

                    player.components.inventory.ignoresound = true

                    local boat = SpawnPrefab("boat_item")
                    setRandomSkinFgc(boat,player)
                    player.components.inventory:GiveItem(boat) --船套装
                    player.components.inventory:GiveItem(SpawnPrefab("log")) --给木头而不是给浆
                    ------这里给开局赠送的钓竿皮肤
                    local of = SpawnPrefab("oceanfishingrod")
                    setRandomSkinFgc(of,player)
                    player.components.inventory:GiveItem(of) --海钓杆  
                    return CurrentOnNewSpawn(...)
                end
            end
        end)
        inst:DoTaskInTime(0,function()
            -- 记录岛id
            local lands = {}
            for i, id in ipairs(TheWorld.topology.ids) do -- 旧档新添加岛屿, 不会改变顺序
                local str = string.split(id,":")
                if str[1] == "StaticLayoutIsland" then
                    table.insert(lands,i)
                end
            end 
            TheWorld.topology.lands = lands
            if TheWorld.components.messagebottlemanager then 
                TheWorld.components.messagebottlemanager.lands = lands
            end
        end)
    end
end)

require "language/tumbleweed_strings_ch"

-- 启迪陷阱 不要月亮碎片
AddPrefabPostInit("alterguardian_phase3trap",function(inst)
    if inst.components.lootdropper then
        inst.components.lootdropper:SetLoot({})
        -- inst.components.lootdropper.ifnotchanceloot = nil
        inst.components.lootdropper.chanceloottable = nil
    end
end)

-- 克劳斯掉落赃物带
AddPrefabPostInit("klaus",function(inst)
    if inst.components.lootdropper then
        inst.components.lootdropper:AddChanceLoot("klaus_sack", 1)
    end
end)

-- local nosoulItems = {"hound","spider","mosquito","bee","killerbee"

-- }
-- for k,v in pairs(nosoulItems) do
--     AddPrefabPostInit(v,function(inst)
--         if not inst:HasTag("soulless") and math.random < 0.3 then
--             --inst:AddTag("soulless")
--         end
--     end)
-- end

-- 修改麦斯威尔的犬牙陷阱
AddPrefabPostInit("trap_teeth_maxwell", function(inst)
    if TheWorld.ismastersim then --判断是不是主机
        if inst.components.mine then
            inst.components.mine:SetRadius(1.5)
            inst.components.mine:SetTestTimeFn(function()return 0.75 end)
        end
    end
end)

-- 这里不知道是做什么的
AddComponentPostInit("mine",function(self) 
    local mine_test_fn = function(dude, inst)
        return not (dude.components.health ~= nil and
                    dude.components.health:IsDead())
            and dude.components.combat:CanBeAttacked(inst)
    end
    local mine_test_tags = { "monster", "character", "animal" }
    -- See entityreplica.lua
    local mine_must_tags = { "_combat" }
    local function MineTest(inst, self)
        if self.radius ~= nil then
            local notags = { "notraptrigger", "flying", "ghost", "playerghost", "spawnprotection"}
            table.insert(notags, self.alignment) -- 移除它,默认alignment 忽略玩家

            local target = FindEntity(inst, self.radius, mine_test_fn, mine_must_tags, notags, mine_test_tags)
            if target ~= nil then
                self:Explode(target)
            end
        end
    end
    self.StartTesting = function(self)
        if self.testtask ~= nil then
            self.testtask:Cancel()
        end
        local next_test_time = self.testtimefn ~= nil and self.testtimefn(self.inst) or (1 + math.random())
        self.testtask = self.inst:DoPeriodicTask(next_test_time, MineTest, 0, self)  --只要重置了就直接开始搜索     
    end
end)

--  伍迪加强
TUNING.BEAVER_ABSORPTION = .90
TUNING.BEAVER_WOOD_DAMAGE = 25
TUNING.BEAVER_GNAW_GAIN = 1.5
TUNING.HUNGER_DUMP = 1
TUNING.BEAVER_FULLMOON_DRAIN_MULTIPLIER = 0
WEREMOOSE_DAMAGE = 34 * 3.5

--  鱼人沃特吃肉
AddPrefabPostInit("wurt", function(inst)
    inst:RemoveComponent("eater")
    inst:AddComponent("eater")
end)

-- 沃利随便吃
AddPrefabPostInit("warly", function(inst)
    inst:RemoveComponent("eater")
    inst:AddComponent("eater")
end)

--伯尼60减伤三倍攻击，阿比盖尔50减伤
AddComponentPostInit("combat", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    local oldbonusdamagefn = inst.bonusdamagefn
    inst.bonusdamagefn = function(attacker, target, damage, weapon)
        local bonus = 0
        if oldbonusdamagefn then
            bonus = oldbonusdamagefn(attacker, target, damage, weapon) or 0
        end
		
		if target.prefab == "bernie_big" and attacker:HasTag("epic") then
            bonus = bonus - (damage + bonus) * 0.4
        end
		
		if target.prefab == "abigail" and attacker:HasTag("epic") then
            bonus = bonus - (damage + bonus) * 0.5
        end
		
		if attacker.prefab == "bernie_big" or attacker.prefab == "bernie_active" then
            bonus = bonus + (damage + bonus) * 3
        end
		
        return bonus
    end
end)

-- 薇诺娜：提升投石车攻击力
AddPrefabPostInit("winona_catapult", function(inst) 
    local OldOnSave = inst.OnSave
    inst.OnSave = function(inst, data)
        if OldOnSave ~= nil then
            OldOnSave(inst, data)
        end
    end

    local OldOnLoad = inst.OnLoad
    inst.OnLoad = function(inst, data)
        if OldOnLoad ~= nil then
            OldOnLoad(inst, data)
        end

        if inst.components.health and inst.components.combat then
            inst.components.health:SetMaxHealth(TUNING.WINONA_CATAPULT_HEALTH*3)
            inst.components.combat:SetDefaultDamage(TUNING.WINONA_CATAPULT_DAMAGE*3)
        end
    end
end)

---------------------------------------------
-- 修改骨架
local ATRIUM_RANGE = 8.5
local function ActiveStargate(gate)
    return gate:IsWaitingForStalker()
end
local STARGET_TAGS = { "stargate" }
local function OnAccept(inst, giver, item)
    if item.prefab == "shadowheart" then
        local stalker
        if TheWorld.state.isnight then
            stalker = SpawnPrefab("stalker_forest")
        else
            local stargate = FindEntity(inst, ATRIUM_RANGE, ActiveStargate, STARGET_TAGS) -- 查找大门
            if stargate ~= nil then
                stalker = SpawnPrefab("stalker_atrium")
                stalker.components.entitytracker:TrackEntity("stargate", stargate)
                stargate:TrackStalker(stalker) -- 跟踪者
            else
                stalker = SpawnPrefab("stalker")
            end
        end

        local x, y, z = inst.Transform:GetWorldPosition()
        local rot = inst.Transform:GetRotation()
        inst:Remove()

        stalker.Transform:SetPosition(x, y, z)
        stalker.Transform:SetRotation(rot)
        stalker.sg:GoToState("resurrect")

        giver.components.sanity:DoDelta(TUNING.REVIVE_SHADOW_SANITY_PENALTY)
    end
end

AddPrefabPostInit("fossil_stalker", function(inst)
    if TheWorld.ismastersim and not TheWorld:HasTag("cave") then --是服务器且不是洞穴
        if inst.components.trader then
            inst.components.trader:SetAbleToAcceptTest(function(...) return true end)
            inst.components.trader.onaccept = OnAccept
        end
    end
end)

------------------------------
-- 船身组件
AddComponentPostInit("hull", function(self, inst)
    local AttachEntityToBoat_ = self.AttachEntityToBoat 
    self.AttachEntityToBoat = function(self, obj, offset_x, offset_z, parent_to_boat)
        -- 仅删除着火点
        if obj.prefab == "burnable_locator_medium" then
            obj:Remove()
        else
            AttachEntityToBoat_(self, obj, offset_x, offset_z, parent_to_boat)
        end
    end
end)


------------------------------
local function RandomWeight(weight_table)
    local totalchance = 0
    local number = 1
    local next = nil
    -- 计算权重表所有项的权重和
    for m, n in pairs(weight_table) do
        totalchance = totalchance + n.chance
    end

    while number > 0 do
        local next_chance = math.random()*totalchance 
        for m, n in pairs(weight_table) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                next = n
                break
            end
        end
        if next ~= nil then
            number = number - 1
        end
    end
    return next
end

GLOBAL.WeightRandom = WeightRandom or RandomWeight -- 可以自定义 权重方法。 用于重置权重表后，选择奖励的方法。

-----------------------------------
-- 对玩家进行更改
AddPlayerPostInit(function(inst)
    if TheWorld.ismastersim then --仅服务器添加
        inst:AddComponent("modnewbuff") --作用自身的buff组件
        inst:AddComponent("healthlink") --单向生命链接
    end  
    if inst.components.oldager then --单向生命链接可以作用到旺达身上了
        inst.components.oldager:AddValidHealingCause("healthlink") -- 可以作用到旺达身上
    end 
end)

-- 死亡不掉落钓竿
AddComponentPostInit("inventory", function(Inventory, inst)
	Inventory.oldDropEverythingFn = Inventory.DropEverything

	function Inventory:MyDropEverything(ondeath, keepequip)
		if self.inst:HasTag("player") and not GetGhostEnabled() and not GetGameModeProperty("revivable_corpse") then
			-- NOTES(JBK): This is for items like Wanda's watches that normally stick inside the inventory but Wilderness mode will force the player to reroll so drop everything.
			ondeath = false
		end
		if self.activeitem ~= nil and not (ondeath and self.activeitem.components.inventoryitem.keepondeath) then
			self:DropItem(self.activeitem)
			self:SetActiveItem(nil)
		end
	
		for k = 1, self.maxslots do
			local v = self.itemslots[k]
			if v ~= nil and not (ondeath and v.components.inventoryitem.keepondeath) and not v.components.curseditem and v.prefab ~= "oceanfishingrod" then
				self:DropItem(v, true, true)
			end
		end
	
		if not keepequip then
			if self.inst.EmptyBeard ~= nil then
				self.inst:EmptyBeard()
			end    
	
			for k, v in pairs(self.equipslots) do
				if not (ondeath and v.components.inventoryitem.keepondeath) and v.prefab ~= "oceanfishingrod" then
					self:DropItem(v, true, true)
				end
			end
		end
	end
    function Inventory:DropEverything(ondeath, keepequip)
        if not inst:HasTag("player") then --不是玩家
            return Inventory:oldDropEverythingFn(ondeath, keepequip)
        elseif inst:HasTag("player") then
            if ondeath then
                return Inventory:MyDropEverything(ondeath, keepequip)
            else
                return Inventory:oldDropEverythingFn(ondeath, keepequip)
            end
        end
    end
end)

-- 添加旧版农场的制作
local Ingredient = GLOBAL.Ingredient
local Tech = GLOBAL.TECH

-- 旧版农场
GLOBAL.STRINGS.RECIPE_DESC.SLOW_FARMPLOT = "Grows seeds."
GLOBAL.STRINGS.RECIPE_DESC.FAST_FARMPLOT = "Grows seeds a bit faster."
AddRecipe2("slow_farmplot", { Ingredient("cutgrass", 8), Ingredient("poop", 4), Ingredient("log", 4) }, Tech.SCIENCE_ONE, "slow_farmplot_placer", {"COOKING", "GARDENING"})
AddRecipe2("fast_farmplot", { Ingredient("cutgrass", 10), Ingredient("poop", 6), Ingredient("rocks", 4) }, Tech.SCIENCE_TWO, "fast_farmplot_placer", {"COOKING", "GARDENING"})

-- 活木制作
local AddCharacterRecipe = AddCharacterRecipe
AddCharacterRecipe("livinglog", {Ingredient("decrease_health", 140)}, TECH.NONE, {builder_tag="plantkin", sg_state="form_log", allowautopick = true, no_deconstruction=true} , {"REFINE"})
-- 沃尔特弹药制作
AddCharacterRecipe("slingshotammo_thulecite", {Ingredient("rocks", 1)}, TECH.NONE, {builder_tag="pebblemaker", numtogive = 10, no_deconstruction=true, nounlock=true} , {"WAR"})



-- 导入哈姆雷特铁巨人
local mainfiles = {
    "actions",
    "tstuning",
    "assets",
    "util",
    "postinit",
    "strings",
    "cmd"
}

for k, v in ipairs(mainfiles) do
    modimport("main/".. v)
    print("导入".. v .. "成功")
end


modimport("scripts/ham_fx")
Assets = {
    Asset("SOUND", "sound/DLC003_sfx.fsb"),
    Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"),
}
