
local easing = require("easing")

local AVERAGE_WALK_SPEED = 4
local WALK_SPEED_VARIATION = 2
local SPEED_VAR_INTERVAL = .5
local ANGLE_VARIANCE = 10

local assets =
{
    Asset("ANIM", "anim/tumbleweed.zip"),
	Asset("ATLAS", "images/tumbleweed.xml"),
}

local prefabs =
{
	"ash",
    "cutgrass",
    "twigs",
}

local CHESS_LOOT =
{
    "chesspiece_pawn_sketch",
    "chesspiece_muse_sketch",
    "chesspiece_formal_sketch",
    "trinket_15", --bishop
    "trinket_16", --bishop
    "trinket_28", --rook
    "trinket_29", --rook
    "trinket_30", --knight
    "trinket_31", --knight
}

for k, v in ipairs(CHESS_LOOT) do
    table.insert(prefabs, v)
end

local SFX_COOLDOWN = 5

local function onplayerprox(inst)
    if not inst.last_prox_sfx_time or (GetTime() - inst.last_prox_sfx_time > SFX_COOLDOWN) then
       inst.last_prox_sfx_time = GetTime()
       inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_choir")
    end
end

local function CheckGround(inst)
	if not inst:IsOnValidGround() then
        SpawnPrefab("splash_ocean").Transform:SetPosition(inst.Transform:GetWorldPosition())
        inst:PushEvent("detachchild")
        inst:Remove()
    end
end

local function startmoving(inst)
    inst.AnimState:PushAnimation("move_loop", true)
    inst.bouncepretask = inst:DoTaskInTime(10*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
        inst.bouncetask = inst:DoPeriodicTask(24*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
			CheckGround(inst)
        end)
    end)
    inst.components.blowinwind:Start()
    inst:RemoveEventCallback("animover", startmoving)
end

--local tumbleweedResources = require("tumbleweed_resources")

local tumbleweed_resources_data = require("resources/tumbleweed_resources_list")--导入风滚草资源



--生成风滚草资源列表
local function MakeLoot(inst,picker)
	--生成资源列表
	--local possible_loot=tumbleweedResources:CreatResources(picker)
    local possible_loot={
        {chance = 4, item = "cutgrass"},
        --{chance = 5, item = "twigs"},
        {chance = 4, item = "ash"},
        {chance = 4, item = "foliage"},--蕨叶
        {chance = 4, item = "petals_evil"},--恶魔花瓣
    }
    if tumbleweed_resources_data then
        for i, v in pairs(tumbleweed_resources_data) do
            --local multiple = v.multiple or 1--资源倍率
            --if multiple>0 then
                local temporaryTable = deepcopy(v.resourcesList)
                for k,x in ipairs(temporaryTable) do
                    table.insert(possible_loot, x)
                end

            --end
        end
    end

    local chessunlocks = TheWorld.components.chessunlocks
    if chessunlocks ~= nil then
        for i, v in ipairs(CHESS_LOOT) do
            if not chessunlocks:IsLocked(v) then
                table.insert(possible_loot, { chance = .1, item = v })
            end
        end
    end

    local totalchance = 0
    for m, n in ipairs(possible_loot) do
        totalchance = totalchance + n.chance
    end

    inst.loot = {}
    local next_loot = nil--道具、生物
    local next_aggro = nil--是否主动攻击
    local next_af = nil
	local next_fn = nil--函数
    local next_name = nil
	local next_announce = nil--公告
    local next_chance = nil
    local num_loots = 3
    while num_loots > 0 do
        next_chance = math.random()*totalchance
        next_loot = nil
        next_aggro = nil
		next_fn = nil
        for m, n in ipairs(possible_loot) do
            next_chance = next_chance - n.chance
            if next_chance <= 0 then
                if n.aggro then next_aggro = true end
				if n.item then next_loot = n.item end
				if n.pickfn then next_fn = n.pickfn end
                if n.name then next_name = n.name end
                if n.eventF then
                    next_af = n.eventF
                elseif n.eventA then
                    next_af = n.eventA
                end
				if n.announce then next_announce = n.announce end
                break
            end
        end
        if next_loot ~= nil then
            table.insert(inst.loot, {item=next_loot,aggro=next_aggro,announce=next_announce,eventaf = next_af,name = next_name})
			num_loots = num_loots - 1
        end
		if next_fn ~= nil then
            table.insert(inst.loot, {pickfn=next_fn})
            num_loots = num_loots - 1
        end
    end
end

-----------------------------------公用函数---------------------------------
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

--打开风滚草
local function onpickup(inst, picker)
    local x, y, z = inst.Transform:GetWorldPosition()
	local firstPickup=false--是否是第一次开
	local pickerNum=0--已经开过风滚草的玩家数量

	--判断打开风滚草的是不是玩家，防止眼球草吃风滚草后崩档
	if picker~=nil and picker:HasTag("player") then
		if TheWorld.components.firstpickersave then
			--判断玩家是不是第一次打开风滚草
			if TheWorld.components.firstpickersave:Isfirst(picker.userid) == nil then --~= 1 then
				firstPickup=true
			end
			--获取已经开启过风滚草的玩家数量
			pickerNum = TheWorld.components.firstpickersave:getPickerNum() or 0
		end
	end

	-- print("已经有"..pickerNum.."个玩家开启过风滚草")
	-- if picker and picker:HasTag("player") then
		-- firstPickup=true--测试用
	-- end
	if firstPickup then
		TheWorld.components.firstpickersave:DoFirst(picker.userid)
	else
		MakeLoot(inst,picker)
	end

    inst:PushEvent("detachchild")

    for i, v in ipairs(inst.loot) do
		--执行函数
		if v.pickfn~=nil then
			v.pickfn(inst,picker)
			break
		--生成物品
		else
			--local item = SpawnPrefab(type(v.item) == "table" and v.item[math.random(#v.item)] or v.item)
            local item = nil
            if type(v.item) == "table" then
               item = v.item[math.random(#v.item)]
            else
                item = v.item
            end

            if item == "fishingsurprised" then
                v.eventaf(item,picker)
                TheNet:Announce(STRINGS.TUMBLEWEEDANNOUNCE.QIAN..picker:GetDisplayName()..STRINGS.TUMBLEWEEDANNOUNCE.ZHONG..v.name..STRINGS.TUMBLEWEEDANNOUNCE.HOU)
                break
            end
            
            item = SpawnPrefab(item)
            
			local item_code = v.item--实体代码，报错时方便查看
            
			if item~=nil then
                
                --TheNet:Announce(STRINGS.TUMBLEWEEDANNOUNCE.QIAN..picker:GetDisplayName()..STRINGS.TUMBLEWEEDANNOUNCE.ZHONG..item:GetDisplayName()..STRINGS.TUMBLEWEEDANNOUNCE.HOU)
                
                --if item ~= "fishingsurprised" then item.Transform:SetPosition(x, y, z) end
                item.Transform:SetPosition(x, y, z)
				-- if v.item=="klaus" then
				-- 	item:SpawnDeer()
				-- end
				--切换随机皮肤
				setRandomSkinFgc(item,picker)
				--如果有掉落函数则触发掉落函数
				if item.components and item.components.inventoryitem ~= nil and item.components.inventoryitem.ondropfn ~= nil then
					item.components.inventoryitem.ondropfn(item)
				end
				--生物目标仇视玩家(默认仇视)
                if item.components and item.components.combat ~= nil and picker ~= nil then
					if not (item:HasTag("spider") and (picker:HasTag("spiderwhisperer") or picker:HasTag("spiderdisguise") or (picker:HasTag("monster") and not picker:HasTag("player")))) then
						item.components.combat:SuggestTarget(picker)
					end
				end

                -- 加上不掉落灵魂标签
                if item.components and item.components.health ~= nil and (not item:HasTag("soulless")) and (not item:HasTag("epic")) then
                    item:AddTag("soulless")
                end

                if v.eventaf~=nil then
                    v.eventaf(item,picker)
                end

				--公告
				if v.announce~=nil and picker~=nil then
					-- TheNet:Announce("【"..picker:GetDisplayName().."】从风滚草中开出了【"..item:GetDisplayName().."】")
					TheNet:Announce(STRINGS.TUMBLEWEEDANNOUNCE.QIAN..picker:GetDisplayName()..STRINGS.TUMBLEWEEDANNOUNCE.ZHONG..item:GetDisplayName()..STRINGS.TUMBLEWEEDANNOUNCE.HOU)
				end
			else
				-- TheNet:Announce("【"..v.item.."】不存在，如果看到该消息可截图给作者反馈~")
				TheNet:Announce(STRINGS.TUMBLEWEEDANNOUNCE.QIAN..item_code..STRINGS.TUMBLEWEEDANNOUNCE.ERRORTXT)
			end
		end
    end

    SpawnPrefab("tumbleweedbreakfx").Transform:SetPosition(x, y, z)
    inst:Remove()
    return true --This makes the inventoryitem component not actually give the tumbleweed to the player
end


local function DoDirectionChange(inst, data)

    if not inst.entity:IsAwake() then return end

    if data and data.angle and data.velocity and inst.components.blowinwind then
        if inst.angle == nil then
            inst.angle = math.clamp(GetRandomWithVariance(data.angle, ANGLE_VARIANCE), 0, 360)
            inst.components.blowinwind:Start(inst.angle, data.velocity)
        else
            inst.angle = math.clamp(GetRandomWithVariance(data.angle, ANGLE_VARIANCE), 0, 360)
            inst.components.blowinwind:ChangeDirection(inst.angle, data.velocity)
        end
    end
end

local function spawnash(inst)
    local x, y, z = inst.Transform:GetWorldPosition()

    local ash = SpawnPrefab("ash")
    ash.Transform:SetPosition(x, y, z)

    if inst.components.stackable ~= nil then
        ash.components.stackable.stacksize = math.min(ash.components.stackable.maxsize, inst.components.stackable.stacksize)
    end

    inst:PushEvent("detachchild")
    SpawnPrefab("tumbleweedbreakfx").Transform:SetPosition(x, y, z)
    inst:Remove()
end

local function onburnt(inst)
    inst:PushEvent("detachchild")
    inst:AddTag("burnt")

    inst.components.pickable.canbepicked = false
    inst.components.propagator:StopSpreading()

    inst.Physics:Stop()
    inst.components.blowinwind:Stop()
    inst:RemoveEventCallback("animover", startmoving)

    if inst.bouncepretask then
        inst.bouncepretask:Cancel()
        inst.bouncepretask = nil
    end
    if inst.bouncetask then
        inst.bouncetask:Cancel()
        inst.bouncetask = nil
    end
    if inst.restartmovementtask then
        inst.restartmovementtask:Cancel()
        inst.restartmovementtask = nil
    end
    if inst.bouncepst1 then
        inst.bouncepst1:Cancel()
        inst.bouncepst1 = nil
    end
    if inst.bouncepst2 then
        inst.bouncepst2:Cancel()
        inst.bouncepst2 = nil
    end

    inst.AnimState:PlayAnimation("move_pst")
    inst.AnimState:PushAnimation("idle")
    inst.bouncepst1 = inst:DoTaskInTime(4*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
        inst.bouncepst1 = nil
    end)
    inst.bouncepst2 = inst:DoTaskInTime(10*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
        inst.bouncepst2 = nil
    end)

    inst:DoTaskInTime(1.2, spawnash)
end

local function OnSave(inst, data)
    data.burnt = inst.components.burnable ~= nil and inst.components.burnable:IsBurning() or inst:HasTag("burnt") or nil
end

local function OnLoad(inst, data)
    if data ~= nil and data.burnt then
        onburnt(inst)
    end
end

local function CancelRunningTasks(inst)
    if inst.bouncepretask then
       inst.bouncepretask:Cancel()
        inst.bouncepretask = nil
    end
    if inst.bouncetask then
        inst.bouncetask:Cancel()
        inst.bouncetask = nil
    end
    if inst.restartmovementtask then
        inst.restartmovementtask:Cancel()
        inst.restartmovementtask = nil
    end
    if inst.bouncepst1 then
       inst.bouncepst1:Cancel()
        inst.bouncepst1 = nil
    end
    if inst.bouncepst2 then
        inst.bouncepst2:Cancel()
        inst.bouncepst2 = nil
    end
end

local function OnEntityWake(inst)
	if not (inst.components.inventoryitem and inst.components.inventoryitem:IsHeld()) then
		inst.AnimState:PlayAnimation("move_loop", true)
		inst.bouncepretask = inst:DoTaskInTime(10*FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
			inst.bouncetask = inst:DoPeriodicTask(24*FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
				CheckGround(inst)
			end)
		end)
	end
end

local function OnLongAction(inst)
    inst.Physics:Stop()
    inst.components.blowinwind:Stop()
    inst:RemoveEventCallback("animover", startmoving)

    CancelRunningTasks(inst)

    inst.AnimState:PlayAnimation("move_pst")
    inst.bouncepst1 = inst:DoTaskInTime(4*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
        inst.bouncepst1 = nil
    end)
    inst.bouncepst2 = inst:DoTaskInTime(10*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/tumbleweed_bounce")
        inst.bouncepst2 = nil
    end)
    inst.AnimState:PushAnimation("idle", true)
    inst.restartmovementtask = inst:DoTaskInTime(math.random(2,6), function(inst)
        if inst and inst.components.blowinwind then
            inst.AnimState:PlayAnimation("move_pre")
            inst.restartmovementtask = nil
            inst:ListenForEvent("animover", startmoving)
        end
    end)
end

local function burntfxfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBuild("tumbleweed")
    inst.AnimState:SetBank("tumbleweed")
    inst.AnimState:PlayAnimation("break")

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst:ListenForEvent("animover", inst.Remove)
    -- In case we're off screen and animation is asleep
    inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + FRAMES, inst.Remove)

    return inst
end
--放到身上
local function OnPutInInventoryFn(inst)
	inst:DoTaskInTime(0.5,function()
		-- inst.Physics:Stop()
		-- inst.components.blowinwind:Stop()
		-- inst:RemoveEventCallback("animover", startmoving)
		--取消各种定时任务
		CancelRunningTasks(inst)
	end)
end

--用网网住
local function OnWorked(inst, worker)
	if worker.components.inventory ~= nil then
        worker.components.inventory:GiveItem(inst, nil, inst:GetPosition())
    end
end
--丢弃
local function OnDropped(inst)
	if inst.components.workable ~= nil then
        inst.components.workable:SetWorkLeft(1)
    end
	local x, y, z = inst.Transform:GetWorldPosition()
	inst.Physics:Teleport(x, y, z)
	OnEntityWake(inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced()
    inst.DynamicShadow:SetSize(1.7, .8)

    inst.AnimState:SetBuild("tumbleweed")
    inst.AnimState:SetBank("tumbleweed")
    inst.AnimState:PlayAnimation("move_loop", true)

    MakeCharacterPhysics(inst, .5, 1)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor")
    inst.components.locomotor:SetTriggersCreep(false)

    inst:AddComponent("blowinwind")
    inst.components.blowinwind.soundPath = "dontstarve_DLC001/common/tumbleweed_roll"
    inst.components.blowinwind.soundName = "tumbleweed_roll"
    inst.components.blowinwind.soundParameter = "speed"
    inst.angle = (TheWorld and TheWorld.components.worldwind) and TheWorld.components.worldwind:GetWindAngle() or nil
    inst:ListenForEvent("windchange", function(world, data)
        DoDirectionChange(inst, data)
    end, TheWorld)
    if inst.angle ~= nil then
        inst.angle = math.clamp(GetRandomWithVariance(inst.angle, ANGLE_VARIANCE), 0, 360)
        inst.components.blowinwind:Start(inst.angle)
    else
        inst.components.blowinwind:StartSoundLoop()
    end

    ---local color = 0.5 + math.random() * 0.5
    ---inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetOnPlayerNear(onplayerprox)
    inst.components.playerprox:SetDist(5,10)

    --inst:AddComponent("lootdropper")

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/harvest_sticks"
    inst.components.pickable.onpickedfn = onpickup
    inst.components.pickable.canbepicked = true


    inst:ListenForEvent("startlongaction", OnLongAction)

    --MakeLoot(inst)
	if TUNING.CAN_CATCH_TUMBLEWEED then
		--可捕捉，可库存
		-- inst:AddComponent("stackable")
		inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.imagename = "tumbleweed"
		inst.components.inventoryitem.atlasname = "images/tumbleweed.xml"
		inst.components.inventoryitem.canbepickedup = false
		inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
		inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventoryFn)
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.NET)
		inst.components.workable:SetWorkLeft(1)
		inst.components.workable:SetOnFinishCallback(OnWorked)
		--可作燃料
		inst:AddComponent("fuel")
		inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
	end

    inst:AddComponent("burnable")
    inst.components.burnable:SetFXLevel(2)
    inst.components.burnable:AddBurnFX("character_fire", Vector3(.1, 0, .1), "swap_fire")
    inst.components.burnable.canlight = true
    inst.components.burnable:SetOnBurntFn(onburnt)
    inst.components.burnable:SetBurnTime(10)

    MakeSmallPropagator(inst)
    inst.components.propagator.flashpoint = 5 + math.random()*3
    inst.components.propagator.propagaterange = 5

    inst.OnEntityWake = OnEntityWake
    inst.OnEntitySleep = CancelRunningTasks
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetOnHauntFn(function(inst, haunter)
        if math.random() <= TUNING.HAUNT_CHANCE_OCCASIONAL then
            onpickup(inst, nil)
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_MEDIUM
        end
        return true
    end)

    return inst
end

return Prefab("tumbleweed", fn, assets, prefabs),
    Prefab("tumbleweedbreakfx", burntfxfn, assets)


