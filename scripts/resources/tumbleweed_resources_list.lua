
local tumbleweed_auto_list = require("loots")--引入自动生成的预制物列表
local easing = require("easing")

----------------获取料理-----------------
local preparedfoods_loot={}--普通料理
local preparedfoods_warly_loot={}--大厨料理
--普通料理
for k, v in pairs(require("preparedfoods")) do
	table.insert(preparedfoods_loot,{chance=0.08,item=v.name})
end
--大厨料理
for k, v in pairs(require("preparedfoods_warly")) do
	table.insert(preparedfoods_warly_loot,{chance=0.04,item=v.name})
end
----------------获取巨型作物-----------------
local huge_fruits_loot = {}--巨型作物
for k, v in pairs(require("prefabs/farm_plant_defs").PLANT_DEFS) do
	if v.product_oversized ~= nil then
		table.insert(huge_fruits_loot, v.prefab)
	end
end
----------------空间乱流相关函数-----------------
--获取随机传送点(传送者)
local function getrandomposition(teleportee)
	local centers = {}
	for i, node in ipairs(TheWorld.topology.nodes) do
		if TheWorld.Map:IsPassableAtPoint(node.x, 0, node.y) and node.type ~= NODE_TYPE.SeparatedRoom then
			table.insert(centers, {x = node.x, z = node.y})
		end
	end
	if #centers > 0 then
		local pos = centers[math.random(#centers)]
		return Point(pos.x, 0, pos.z)
	else
		return teleportee:GetPosition()
	end
end
--传送结束
local function teleport_end(teleportee, locpos)
    --防止被闪电引燃
    local preventburning = teleportee.components.burnable ~= nil and not teleportee.components.burnable.burning
    if preventburning then
        teleportee.components.burnable.burning = true
    end
    TheWorld:PushEvent("ms_sendlightningstrike", locpos)
    if preventburning then
        teleportee.components.burnable.burning = false
    end
	--播放结束动画，唤醒玩家，取消无敌状态
    if teleportee:HasTag("player") then
        teleportee.sg.statemem.teleport_task = nil
        teleportee.sg:GoToState(teleportee:HasTag("playerghost") and "appear" or "wakeup")
        teleportee.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
    else
        teleportee:Show()
        if teleportee.DynamicShadow ~= nil then
            teleportee.DynamicShadow:Enable(true)
        end
        if teleportee.components.health ~= nil then
            teleportee.components.health:SetInvincible(false)
        end
        teleportee:PushEvent("teleported")
    end
end
--继续传送(传送者,待传坐标)
local function teleport_continue(teleportee, locpos)
    --设置新坐标
	if teleportee.Physics ~= nil then
        teleportee.Physics:Teleport(locpos.x, 0, locpos.z)
    else
        teleportee.Transform:SetPosition(locpos.x, 0, locpos.z)
    end
	--如果是玩家的话延迟执行传送结束函数，并黑屏一会儿，否则直接执行
    if teleportee:HasTag("player") then
        teleportee:SnapCamera()
        teleportee:ScreenFade(true, 1)
        teleportee.sg.statemem.teleport_task = teleportee:DoTaskInTime(1, teleport_end, locpos)
    else
        teleport_end(teleportee, locpos)
    end
end
--开始传送(传送者)
local function teleport_start(teleportee)
    local ground = TheWorld--世界
    local locpos = getrandomposition(teleportee)--获取随机传送点

	if teleportee.components == nil then return end

    if teleportee.components.locomotor ~= nil then
        teleportee.components.locomotor:StopMoving()
    end

    if ground:HasTag("cave") then
        --在洞穴里则发生地震
        ground:PushEvent("ms_miniquake", { rad = 3, num = 5, duration = 1.5, target = teleportee })
        return
    end

    --传送的时候无敌
	local isplayer = teleportee:HasTag("player")
    if isplayer then
        teleportee.sg:GoToState("forcetele")
    else
        if teleportee.components.health ~= nil then
            teleportee.components.health:SetInvincible(true)
        end
        if teleportee.DynamicShadow ~= nil then
            teleportee.DynamicShadow:Enable(false)
        end
        teleportee:Hide()
    end

    --防止被闪电引燃
    local preventburning = teleportee.components.burnable ~= nil and not teleportee.components.burnable.burning
    if preventburning then
        teleportee.components.burnable.burning = true
    end
    ground:PushEvent("ms_sendlightningstrike", teleportee:GetPosition())
    if preventburning then
        teleportee.components.burnable.burning = false
    end
	--计算潮湿度
    ground:PushEvent("ms_deltamoisture", TUNING.TELESTAFF_MOISTURE)
	--如果是玩家则延迟3秒执行下一步函数，否则立刻执行
    if isplayer then
        teleportee.sg.statemem.teleport_task = teleportee:DoTaskInTime(3, teleport_continue, locpos)
    else
        teleport_continue(teleportee, locpos)
    end
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

----------------打包礼物-----------------
--风滚草、礼物列表、拾取者(需要皮肤的时候才需要这个参数)
local function spawnGift(inst,giftloot,picker)
	local x,y,z= inst.Transform:GetWorldPosition()
	local bundleitems = {}
	for k,v in pairs(giftloot) do
		local item=SpawnPrefab(k)
		if item then
			if picker then
				setRandomSkinFgc(item,picker)--设置皮肤
			end
			if v>1 then
				if item.components.stackable then
					item.components.stackable.stacksize = v
				else--不可堆叠则多生成几个放进去
					for i=1,v-1 do
						local extra=SpawnPrefab(k)
						if picker then
							setRandomSkinFgc(extra,picker)--设置皮肤
						end
						table.insert(bundleitems, extra)
					end
				end
			end
			table.insert(bundleitems, item)
		end
	end
	local bundle = SpawnPrefab("gift")
	bundle.components.unwrappable:WrapItems(bundleitems)
	for i, v in ipairs(bundleitems) do
	    v:Remove()
	end
	bundle.Transform:SetPosition(x, y, z)
end

----------------生成各种怪圈(玩家,预置物列表,公告)-----------------
local function spawnCircleItem(player,spawnLoot,announce)
	if player then
		local px,py,pz = player.Transform:GetWorldPosition()--获取玩家坐标
		local item=nil--空实体
		--遍历生成物列表
		for _,v in ipairs(spawnLoot) do
			local x = nil
            if type(v.item) == "table" then
               item = v.item[math.random(#v.item)]
            else
                item = v.item
            end
			--对玩家执行函数
			if v.playerfn then
				v.playerfn(player)
			end
			--有代码则生成对应预置物
			if v.item or v.randomlist then
				local num=v.num or 1--生成数量
				local specialnum=v.specialfn and math.random(num)-1 or nil--特殊道具
				--生成怪圈
				for i=0,num-1 do
					local code=v.item--预置物代码
					if v.randomlist then
						code=GetRandomItem(v.randomlist)--从随机列表里取一种
					end
					local angle_offset=v.angle_offset or 0--角度偏移
					local angle = (i+angle_offset) * 2 * PI / (num)--根据数量计算角度
					local tries =v.offset and 5 or 1--尝试生成次数,有偏移值的情况下要多次尝试生成,避免少刷
					local canspawn=nil--是否可生成
					if v.randomlist then
						
					end
					--多次尝试生成
					for j=1,tries do
						--有偏移值则用偏移值生成坐标，否则根据半径生成坐标，没半径则原地生成
						local ix=v.offset and (math.random()*2-1)*v.offset+px or v.radius and v.radius*math.cos(angle)+px or px
						local iy=py
						local iz=v.offset and (math.random()*2-1)*v.offset+pz or v.radius and v.radius*math.sin(angle)+pz or pz
						--水中奇遇则判断坐标点是不是在水里
						if v.iswater then
							canspawn = TheWorld.Map:IsOceanAtPoint(ix, iy, iz)
						else
							canspawn = TheWorld.Map:IsPassableAtPoint(ix, iy, iz)
						end
						--坐标点可生成则生成，否则继续尝试
						if canspawn then
							item = SpawnPrefab(code)
							if item then
								item.Transform:SetPosition(ix, iy, iz)
								--如果没有特意取消，那么开出来的生物默认仇恨玩家
								if item.components.combat and not v.noaggro then
									item.components.combat:SuggestTarget(player)
								end
								--有特殊函数则执行特殊函数
								if specialnum and i==specialnum then
									v.specialfn(item,player)
								elseif v.itemfn then--否则执行正常预置物函数
									v.itemfn(item,player)
								end
							end
							break
						end
					end
				end
			end
		end
		--发出公告
		if announce then
			TheNet:Announce(STRINGS.TUMBLEWEEDANNOUNCE.QIAN..player:GetDisplayName()..STRINGS.TUMBLEWEEDANNOUNCE[announce])
		end
	end
end

--风滚草列表
local tumbleweed_resources_list = {
	
	--[[
		]]
	--食物
	food_resources = {
		resourcesList = tumbleweed_auto_list.ingredients,
		multiple=1,
		--multiple=TUNING.BASIC_RESOURCES_MULTIPLE,--这个以后再改，通过模组设置更改
	},
	--材料
	goods_resources = {
		resourcesList = tumbleweed_auto_list.materials,
		multiple=1,
	},
	--物品
	scarce_resources = {
		resourcesList = tumbleweed_auto_list.goods,
		multiple=1,
	},
	--穿戴
	equipments_resources = {
		resourcesList = tumbleweed_auto_list.equipments,
		multiple=1,
	},
	--种植
	plant_resources = {
		resourcesList = tumbleweed_auto_list.plant,
		multiple=1,
	},
	--生物
	organisms_resources = {
		resourcesList = tumbleweed_auto_list.organisms,
		multiple=1,
	},
	--各种蓝图
	blueprints_resources = {
		resourcesList = tumbleweed_auto_list.blueprints,
		multiple=1,
	},
	--建筑
	builds_resources = {
		resourcesList = tumbleweed_auto_list.builds,
		multiple=1,
	},
	--料理
	foods_resources = {
		resourcesList = tumbleweed_auto_list.foods,
		multiple=1,
	},
	--事件表
	events_resources = {
		resourcesList = tumbleweed_auto_list.events,
		multiple=1,
	},
	--花样作死
	seek_death_resources = {
		resourcesList = {
			--晴天霹雳0.05
			{chance = 0.1,pickfn=function(inst,picker)
				local spawnLoot={
					{playerfn=function(player)--玩家状态函数
						local num_lightnings = 30--闪电数量
						local px,py,pz= player.Transform:GetWorldPosition()
						player:StartThread(function()
							for k = 0, num_lightnings-1 do
								local rad = math.random(2, 10)
								local angle = k * 2 * PI / (num_lightnings)
								local pos = Vector3(rad * math.cos(angle)+px, py, rad * math.sin(angle)+pz)
								TheWorld:PushEvent("ms_sendlightningstrike", pos)
								Sleep(.1 + math.random() * .1)
							end
						end)
					end},
				}
				spawnCircleItem(picker,spawnLoot,"QTPL")
			end},
			--精神风暴0.05
			{chance = 0.1,	pickfn = function(inst,picker)
				local spawnLoot={
					{playerfn=function(player)--玩家状态函数
						if player.components.sanity~=nil then
							player.components.sanity:SetPercent(math.random(0,100))--设置随机值
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"JSFB")
			end},
			--高鸟牢笼
			{chance = .1,	pickfn = function(inst,picker)
				local spawnLoot={
					{item="tallbird",num=6,radius=4,itemfn=function(inst,player)
						--六只高鸟攻速加倍，dpu（单位时间伤害）会乘12，所以攻击力应除以12，考虑到玩家僵直这里攻击力除以20，也就是2.5
						if inst.components.combat then
							inst.components.combat:SetDefaultDamage(2.5)
							inst.components.combat:SetAttackPeriod(1)--高鸟原本攻速是2
						end
						if inst.components.lootdropper then
							SetSharedLootTable('tallbird2',{{'smallmeat', 0.5},{'drumstick', 0.5},})
							inst.components.lootdropper:SetChanceLootTable('tallbird2')
						end
					end},--高鸟
				}
				spawnCircleItem(picker,spawnLoot,"GNGQ")
			end},
			--杀人蜂阵
			{chance = 0.1,	pickfn = function(inst,picker)
				local spawnLoot={
					{item="wasphive",num=3,radius=7,itemfn=function(inst,player)
						if inst then--到5s时间清理钓，防止玩家白嫖
							inst:DoTaskInTime(5, inst.Remove)
						end
					end},--杀人蜂窝
				}
				spawnCircleItem(picker,spawnLoot,"SRFZ")
			end},
			--触手牢笼
			{chance = .1,	pickfn = function(inst,picker)
				local spawnLoot={
					{item="wall_stone",num=8,radius=2,itemfn=function(inst,player)
						if inst.components.lootdropper then
							SetSharedLootTable('wall_stone1',{})
							inst.components.lootdropper:SetChanceLootTable('wall_stone1')
						end
					end},--石墙
					{item="tentacle",num=8,radius=5,itemfn=function(inst,player)
						if inst.components.combat then
							inst.components.combat:SetDefaultDamage(2)
						end
						if inst.components.lootdropper then
							SetSharedLootTable('tentacle2',{{'tentaclespike', 0.5},{'tentaclespots', 0.5},})
							inst.components.lootdropper:SetChanceLootTable('tentacle2')
						end
					end},--触手
				}
				spawnCircleItem(picker,spawnLoot,"CSLL")
			end},
			--爆炸法阵
			{chance = 0.1, pickfn = function(inst,picker)
				local spawnLoot={
					--火药
					{item="gunpowder",num=2,radius=3,itemfn=function(inst,player)
						if inst.components.explosive then
							inst.components.explosive:OnBurnt()
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"BZFZ")
			end},
			--燃烧陷阱
			{chance = 0.1,	pickfn = function(inst,picker)
				local spawnLoot={
					--木墙
					{item="wall_wood",num=4,radius=1.5,itemfn=function(inst,player)
						if inst.components.burnable then
							inst.components.burnable:Ignite(true)
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"RSXJ")
			end},
			--冰雕演员
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					--冰阵
					{item="deer_ice_circle",num=1,itemfn=function(inst,player)
						--10秒后移除
						inst:DoTaskInTime(15,inst.KillFX)
						--范围冰冻
						local x,y,z=player.Transform:GetWorldPosition()
						local ents = TheSim:FindEntities(x, y, z, 12, {"freezable"}, { "FX", "NOCLICK", "DECOR", "INLIMBO" })
						for i,v in pairs(ents) do
							if v.components.freezable then
								v.components.freezable:AddColdness(6)
							end
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"BDYY")
			end},
			--无法自拔
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					{playerfn=function(player)--玩家状态函数
						local x,y,z=player.Transform:GetWorldPosition()
						local ents = TheSim:FindEntities(x, y, z, 12,{"freezable"}, { "FX", "NOCLICK", "DECOR", "INLIMBO" })
						for i,v in pairs(ents) do
							if v.components.pinnable ~= nil then
								v.components.pinnable:Stick()
							end
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"WFZB")
			end},
			--真爱之吻
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					{item="wall_hay",num=4,radius=1},
					--蚊子
					{item="mosquito",num=8,radius=4,noaggro=true,itemfn=function(inst,player)
						if inst.drinks then
							inst.drinks=4
							inst.AnimState:Show("body_4")
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"ZAZW")
			end},
			--长睡不醒
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					{item="mole",num=1,offset=5},--鼹鼠
					--火药
					{item="gunpowder",num=1,itemfn=function(inst,player)
						--让玩家睡觉
						if player.components.grogginess then
							player.components.grogginess:AddGrogginess(10, 10)
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"CSBX")
			end},
			--儿孙满堂
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					--桦木树
					{item="deciduoustree",num=3,radius=1.5,itemfn=function(inst,player)
						--变成桦木精
						if inst.StartMonster then
							inst:StartMonster(true)
						end
						if inst.components.lootdropper then
							inst:DoTaskInTime(60, inst.Remove)
							SetSharedLootTable('deciduoustree1',{{'livinglog', 0.1},{'acorn', 0.1},})
							inst.components.lootdropper:SetChanceLootTable('deciduoustree1')
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"ESMT")
			end},
			--暴躁舌吻
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					{item="wall_stone",num=8,radius=2,itemfn=function(inst,player)
						--让化石碎片不掉落任何物品，防止白嫖
						if inst.components.lootdropper then
							SetSharedLootTable('fossil_stalker1',{})
							inst.components.lootdropper:SetChanceLootTable('fossil_stalker1')
						end
					end},--化石碎片
					--青蛙
					{item="frog",num=8,radius=1,itemfn=function(inst,player)
						--把攻击降低，刮痧
						if inst.components.combat then
							inst.components.combat:SetDefaultDamage(2)
						end
						--概率掉锤子，让玩家出去
						if inst.components.lootdropper then
							--这里想把锤子的耐久设置为1%但是但是方法不知道怎么整
							SetSharedLootTable('frog1',{{'hammer', 0.1},{'froglegs', 0.25},})
							inst.components.lootdropper:SetChanceLootTable('frog1')
							--inst.components.lootdropper:AddChanceLoot("hammer", 0.1)
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"BZSW")
			end},
			--阴晴不定
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					{playerfn=function(player)--玩家状态函数
						if TheWorld.state.israining or TheWorld.state.issnowing then
							TheWorld:PushEvent("ms_forceprecipitation", false)
						else
							TheWorld:PushEvent("ms_forceprecipitation", true)
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"YQBD")
			end},
			--流星雨
			{chance = 0.1,pickfn=function(inst,picker)
				local spawnLoot={
					{playerfn=function(player)--玩家状态函数
						local num_meteor = 20--流星数量
						local px,py,pz= player.Transform:GetWorldPosition()
						player:StartThread(function()
							for k = 0, num_meteor-1 do
								local theta = math.random() * 2 * PI
								local radius = easing.outSine(math.random(), math.random() * 5, 5, 1)
								local fan_offset = FindValidPositionByFan(theta, radius, 30,
									function(offset)
										return TheWorld.Map:IsPassableAtPoint(px + offset.x, py + offset.y, pz + offset.z)
									end)
								local met = SpawnPrefab("shadowmeteor")
								met.Transform:SetPosition(px + fan_offset.x, py + fan_offset.y, pz + fan_offset.z)
								Sleep(.3 + math.random() * .2)
							end
						end)
					end},
				}
				spawnCircleItem(picker,spawnLoot,"LXY")
			end},
			--腐朽之地
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					{item="sporecloud",num=math.random(1,3),radius=2},--一圈孢子云
					{item="mushroomsprout",num=math.random(2,4),radius=2},--蘑菇树
					--中间孢子云
					{item="sporecloud",num=1,itemfn=function(inst,player)
						--玩家减速
						if player.components.grogginess ~= nil then 
							player.components.grogginess:AddGrogginess(5, 10)
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"FXZD")
			end},
			--空间乱流
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					{playerfn=function(player)--玩家状态函数
						--范围冰冻
						local x,y,z=player.Transform:GetWorldPosition()
						local ents = TheSim:FindEntities(x, y, z, 12, {"freezable"}, { "FX", "NOCLICK", "DECOR", "INLIMBO" })
						for i,v in pairs(ents) do
							teleport_start(ents)--传送玩家
						end
						
					end},
				}
				spawnCircleItem(picker,spawnLoot,"KJLL")
			end},
			--沙漠之刺
			{chance = 0.1,pickfn=function(inst,picker)
				local spawnLoot={
					{playerfn=function(player)--玩家状态函数
						local spike_num = math.random(10,15)--单次沙刺数量
						local spike_times=math.random(5,10)--沙刺波数
						local item_num = 8--沙堡数量
						local radius=4--沙堡半径
						local px,py,pz= player.Transform:GetWorldPosition()
						--生成外圈沙堡
						for k=0,item_num-1 do
							local angle = k * 2 * PI / (item_num)
							if TheWorld.Map:IsPassableAtPoint(radius*math.cos(angle)+px, py, radius*math.sin(angle)+pz) then
								local item = SpawnPrefab("sandblock")
								item.Transform:SetPosition(radius*math.cos(angle)+px, py, radius*math.sin(angle)+pz)
							end
						end
						--内圈沙刺
							player:StartThread(function()
								for k = 0, spike_times-1 do
									for i=0,spike_num-1 do
										local theta = math.random() * 2 * PI
										local radius = easing.outSine(math.random(), math.random() * 2, 2, 1)
										local fan_offset = FindValidPositionByFan(theta, radius, 30,
											function(offset)
												return TheWorld.Map:IsPassableAtPoint(px + offset.x, py + offset.y, pz + offset.z)
											end)
										local met = SpawnPrefab("sandspike")
										met.Transform:SetPosition(px + fan_offset.x, py + fan_offset.y, pz + fan_offset.z)
									end
								Sleep(1.5 + math.random() * 1)
								end
							end)
					end},
				}
				spawnCircleItem(picker,spawnLoot,"SMTC")
			end},
			--盐焗蜗牛
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					--火阵
					{item="deer_fire_circle",num=1,itemfn=function(inst,player)
						--2秒后移除
						inst:DoTaskInTime(8,inst.KillFX)
					end},
					{randomlist={"snurtle","slurtle"},num=math.random(3,6),radius=1,itemfn=function(inst,player)
						if inst.components.explosive then
							inst.components.explosive:OnBurnt()
						end
					end},--蜗牛
					{item="saltlick",num=math.random(3,6),radius=2,itemfn=function(inst,player)
						if inst.components.lootdropper then
							inst.components.lootdropper:SetLoot({})
        					inst.components.lootdropper.chanceloottable = nil
							--SetSharedLootTable('saltlick1',{{'nitre', 0.5},})
							--inst.components.lootdropper:SetChanceLootTable('saltlick1')

						end
					end},--舔盐器
				}
				spawnCircleItem(picker,spawnLoot,"YJWN")
			end},
			--湿身诱惑
			{chance = 0.1,pickfn = function(inst,picker)
				local spawnLoot={
					--水球
					{item="waterballoon",num=3,itemfn=function(inst,player)
						if inst.components.complexprojectile then
							inst.components.complexprojectile:Hit(player)
						end
					end},
				}
				spawnCircleItem(picker,spawnLoot,"SSYH")
			end},
			--暗影骨牢0.03
			{chance = 0.1,pickfn=function(inst,picker)
				local spawnLoot={
					{item="fossilspike2",num=math.random(10,25),offset=1.5},--天降骨刺
					{item="fossilspike",num=math.random(10,20),radius=1.5},--骨刺，地下
				}
				spawnCircleItem(picker,spawnLoot,"AYGL")
			end},
			--定时炸弹0.03
			{chance = 0.1,pickfn=function(inst,picker)
				local spawnLoot={
					{item="alterguardian_phase3trap",num=1},--启迪陷阱
					{item="alterguardian_phase2spike",num=10,radius=3.5,itemfn=function(inst,player)
						if inst.components.workable then
							inst.components.workable:SetOnWorkCallback(function(inst,worker)
								local item = SpawnPrefab("gunpowder")
								if item then
									item.Transform:SetPosition(inst.Transform:GetWorldPosition())
									if item.components.explosive then
										item.components.explosive:OnBurnt()
									end
								end
							end)
						end
					end},--月光玻璃突刺
				}
				spawnCircleItem(picker,spawnLoot,"DSZD")
			end},
			--醍醐灌顶0.03
			{chance = 0.1,pickfn=function(inst,picker)
				local spawnLoot={
					{item="bird_mutant_spitter",num=math.random(4,6),radius=3},--奇行鸟
					{item="alterguardian_phase2spike",num=10,radius=2.5},--月光玻璃突刺
				}
				spawnCircleItem(picker,spawnLoot,"THGD")
			end},
		},
		--multiple=TUNING.SEEK_DEATH_MULTIPLE,
		multiple=1,
	},

	--[[

		--医疗包
		{chance = 0.09,	pickfn = function(inst,picker)
			if picker~=nil then
				local giftloot={
								amulet=1,--生命护符
								lifeinjector=3,--强心针
								bandage=5,--蜂蜜药膏
								spidergland=3,--腺体
							}
							spawnGift(inst,giftloot,picker)
							TheNet:Announce(STRINGS.TUMBLEWEEDANNOUNCE.QIAN..picker:GetDisplayName()..STRINGS.TUMBLEWEEDANNOUNCE.YLB)
						end
					end},
	]]
}

--玩具
for i = 1,NUM_TRINKETS do
	local chess_list={15,16,28,29,30,31}
	local chance = table.contains(chess_list,i) and 0.05 or 0.1
	--table.insert(tumbleweed_resources_list.advanced_resources.resourcesList,{chance=chance,item="trinket_"..i})
end

return tumbleweed_resources_list