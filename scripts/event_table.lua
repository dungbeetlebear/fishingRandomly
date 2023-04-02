-- require("method")
local data = require("event_data")

local function spawnAtGround(name, x,y,z)
    if TheWorld.Map:IsPassableAtPoint(x, y, z) then
        local item = SpawnPrefab(name)
        if item then
            item.Transform:SetPosition(x, y, z)
            if item.components.lootdropper then
                SetSharedLootTable('mod_nil',{})
                item.components.lootdropper:SetChanceLootTable('mod_nil')
            end
            return item
        end
    end
end

-- 圆心x, 圆心y, 半径, 几等分, 对象表, 将要执行的方法
local function circular(target,r,num,lsit,fn)
    if target == nil or lsit == nil or #lsit <= 0 then return end 
    local x,y,z = target.Transform:GetWorldPosition()
    for k=1,num do
        local angle = k * 2 * PI / num
        local item = spawnAtGround(lsit[math.random(#lsit)], r*math.cos(angle)+x, 0, r*math.sin(angle)+z)
        if item ~= nil and fn ~= nil and type(fn) == "function" then 
            fn(item, target, k)
        end
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

-- local function announce(player, content)
-- 	local name = player and player:GetDisplayName() or "???"
--     TheNet:Announce(name.." 钓到了 "..content)	
-- end
local filter = {"moonbase","multiplayer_portal","crabking_spawner","dragonfly_spawner","hermithouse_construction1","sculpture_rook",
"sculpture_bishop","sculpture_knight","terrariumchest","cave_entrance","wormhole_MARKER","beequeenhivegrown","beequeenhive","pigking",
"statueglommer","antlion_spawner","oasislake","critterlab","walrus_camp","sculpture_bishophead","sculpture_knighthead","sculpture_rooknose",
"moon_altar_rock_glass","moon_altar_rock_idol","moon_altar_rock_seed"}
-- 木墙、石墙、铥矿墙、月岩墙、木门、木栅栏、火坑、吸热火坑、箱子、龙鳞宝箱、冰箱、烹饪锅、龙蝇火炉、鸟笼、强征传送塔、眼球炮塔、雪球发射器、避雷针、船桨、浮木桨、船、方向舵、锚、桅杆、飞翼风帆

SetSharedLootTable('mod_nil',{})

local function gift(inst, player) 
    inst:DoTaskInTime(1,function(inst) --等鸟飞起睡眠它, 超2s就被删了
        if inst.components and inst.components.sleeper then inst.components.sleeper:GoToSleep(0) end
    end)
end

local function grotto_pool_small(inst, player) 
    if inst._waterfall then
        inst._waterfall.Transform:SetPosition(inst.Transform:GetWorldPosition())
    end
    inst.children = nil
end

local function klaus(inst, player) 
	-- inst:SpawnDeer() -- 产鹿 钓起后,产鹿也暴怒。 钓起前,原克劳斯位置在海上,无法用海上坐标,所以产鹿坐标设置当前玩家坐标。
    local pos = player:GetPosition()
    local rot = player.Transform:GetRotation()
    local theta = (rot - 90) * DEGREES
    local offset =
        FindWalkableOffset(pos, theta, inst.deer_dist, 5, true, false) or
        FindWalkableOffset(pos, theta, inst.deer_dist * .5, 5, true, false) or
        Vector3(0, 0, 0)

    local deer_red = SpawnPrefab("deer_red")
    deer_red.Transform:SetRotation(rot)
    deer_red.Transform:SetPosition(pos.x + offset.x, 0, pos.z + offset.z)
    local redP = deer_red.Physics:GetCollisionMask()
    deer_red.Physics:SetCollisionMask(COLLISION.GROUND)  
    deer_red:DoTaskInTime(1,function(inst)
    	inst.Physics:SetCollisionMask(redP)  
	end)
    deer_red.components.spawnfader:FadeIn()
    inst.components.commander:AddSoldier(deer_red)

    theta = (rot + 90) * DEGREES
    offset =
        FindWalkableOffset(pos, theta, inst.deer_dist, 5, true, false) or
        FindWalkableOffset(pos, theta, inst.deer_dist * .5, 5, true, false) or
        Vector3(0, 0, 0)

    local deer_blue = SpawnPrefab("deer_blue")
    deer_blue.Transform:SetRotation(rot)
    deer_blue.Transform:SetPosition(pos.x + offset.x, 0, pos.z + offset.z)
    deer_blue.Physics:SetCollisionMask(COLLISION.GROUND)  
    deer_blue:DoTaskInTime(1,function(inst)
    	inst.Physics:SetCollisionMask(redP)  
	end)
    deer_blue.components.spawnfader:FadeIn()
    inst.components.commander:AddSoldier(deer_blue)	

	inst.components.knownlocations:RememberLocation("spawnpoint", player:GetPosition(), false) -- 重新记住玩家位置
	inst.components.spawnfader:FadeIn() -- 渐入效果
end

local function stalker_atrium(inst, player)
    local stargate = SpawnPrefab("artificial_atrium_gate") --添加伪远古大门
    stargate.Transform:SetPosition(player.Transform:GetWorldPosition())
    inst.components.entitytracker:TrackEntity("stargate", stargate)
    stargate:TrackStalker(inst)
    inst.persists = false
    local prefabs_atrium =
    {
        {"fossil_piece",1},
        {"fossilspike",1},
        {"fossilspike2",1},
        {"stalker_shield",1},
        {"stalker_minion",1},
        {"shadowchanneler",1},
        {"mindcontroller",1},
        {"nightmarefuel",1},
        {"thurible",1},
        {"armorskeleton",1},
        {"skeletonhat",1},
        {"flower_rose",1},
        {"winter_ornament_boss_fuelweaver",1},
        {"chesspiece_stalker_sketch",1},
    }
    SetSharedLootTable('zhiying',prefabs_atrium)
    if inst and inst.components and inst.components.lootdropper then
        inst.components.lootdropper:SetChanceLootTable('zhiying')
    end
end

local function weatherchanged(inst, player)
    if TheWorld.state.israining or TheWorld.state.issnowing then --如果在下雨或者下雪
        TheWorld:PushEvent("ms_forceprecipitation", false)
    else
        TheWorld:PushEvent("ms_forceprecipitation", true)
    end
    -- 宣告
    -- announce(player,"阴晴不定")
end

local function rockcircle(inst, player)
	local items = data.rockcircle
    if TheWorld.state.iswinter then --冬天才能出冰川
        items = {"rock_ice"}
    end
	circular(player,6,10,items)
	-- announce(player, "岩石怪圈")
end

local function campfirecircle(inst, player)
	local items = {"campfire","coldfire"}
    if TheWorld.state.iswinter then
        items = {"coldfire"}
    end
	circular(player,2,10,items)
	-- announce(player, "营火晚会")
end

local function monstercircle(inst, player)
    local items = data.monstercircle
    circular(player,5,math.random(4,9),items,function(inst, target)
    	if target ~= nil and inst.components.combat then
    		inst.components.combat:SuggestTarget(target) --仇恨
    	end
	end)
	-- announce(player, "生物怪圈")
end

local function maxwellcircle(inst, player)
    circular(player,3,5,{"beemine_maxwell"})
    circular(player,5,14,{"trap_teeth_maxwell"})
    circular(player,7,7,{"beemine_maxwell"})
    circular(player,9,15,{"trap_teeth_maxwell"})
    circular(player,11,11,{"trap_teeth_maxwell"})
end

local function fengguncao(inst, player)
    circular(player,3,5,{"tumbleweed"})
    circular(player,7,7,{"tumbleweed"})
    circular(player,7,15,{"tumbleweed"})
end

local function radiationtentacle(inst, player)
    circular(player,3,6,{"gestalt_alterguardian_projectile"})
    for i=4,9 do
        circular(player,i*1.5,8,{"tentacle_pillar_arm","minotaur_blood_big"})  
    end

    for i=10,20 do
        circular(player,i*1.5,16,{"tentacle_pillar_arm","minotaur_blood_big"})  
    end

end

local function pigelite(inst, player)
    circular(player,math.random(1,2),math.random(4,6),{"propsign"})
    circular(player,math.random(3,4),math.random(4,6),{"propsign"})
    circular(player,math.random(5,6),math.random(7,8),{"propsign"})
    circular(player,math.random(4,5),math.random(3,5),{"pigelite1","pigelite2","pigelite3","pigelite4"})
    circular(player,math.random(6,7),math.random(4,6),{"pigelite1","pigelite2","pigelite3","pigelite4"})
end

local function eyecircle(inst, player)
    player:StartThread(function()  --开启线程
        circular(player,math.random(4,6),math.random(15,20),{"eyeplant"})
        Sleep(0.5 + math.random(5,10)/10)
        circular(player,math.random(2,3),math.random(15,20),{"fossilspike1","fossilspike2"})

        Sleep(0.5)
        local x,y,z = player.Transform:GetWorldPosition()
        spawnAtGround("stalker_shield",x,y,z)

    end)

end

local function clumsyimitation(inst, player)
    player:StartThread(function()  --开启线程
        local x,y,z = player.Transform:GetWorldPosition()
        spawnAtGround("moonstorm_lightning",x,y,z)
        Sleep(0.5 + math.random(1,3)/10)

        for i=3,7 do
            local k = i*2.5
            local j = (i + 2)*2.5
            circular(player,k,k*1.5,{"deciduous_root"})
            circular(player,j,j*1.5,{"deciduous_root"})
            circular(player,15-k,(15-k)*1.5,{"deciduous_root"})
            circular(player,15-j,(15-j)*1.5,{"deciduous_root"})
            Sleep(1 + math.random(0.5,0.1))
        end
        
        for i=1,60 do
            local r = math.random(0, 30)
            local angle = math.random(2, 10) * 2 * PI / math.random(5, 30)
            spawnAtGround("stalker_shield",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
        end

        Sleep(0.5 + math.random(3,5)/10)

        for i=7,9 do
            local k = i*2.5
            local j = (i + 2)*2.5
            circular(player,k,k*1.5,{"deciduous_root"})
            circular(player,j,j*1.5,{"deciduous_root"})
            circular(player,15-k,(15-k)*1.5,{"deciduous_root"})
            circular(player,15-j,(15-j)*1.5,{"deciduous_root"})
            Sleep(1 + math.random(0.5,0.1))
        end

    end)

end

local function floods(inst, player)
    local x,y,z = player.Transform:GetWorldPosition()
    spawnAtGround("spider_web_spimoonpulse_spawnert_creep",x,y,z)
    circular(player,3,10,{"houndfire","wave_med"})
    circular(player,5,14,{"houndfire","wave_med"})
    circular(player,7,18,{"houndfire","wave_med"})
    circular(player,9,22,{"houndfire","wave_med"})
    circular(player,11,26,{"wave_med"})
    circular(player,13,30,{"wave_med"})
    circular(player,15,34,{"wave_med"})
    circular(player,17,38,{"wave_med"})
end

local function ghostcir(inst, player)
    circular(player,5,5,{"ghost"})
    circular(player,7,6,{"ghost"})
end

local function chest(inst, player)
    local prefab = inst.prefab
    local items = nil
    if prefab == "treasurechest" then
        items = data.chest.treasurechest
    elseif prefab == "pandoraschest" then 
        items = data.chest.pandoraschest
    elseif prefab == "dragonflychest" then
        items = data.chest.dragonflychest
    elseif prefab == "minotaurchest" then
        items = data.chest.minotaurchest
    end
    if inst.components.workable then inst:RemoveComponent("workable") end --不能被敲
    if inst.components.burnable then inst:RemoveComponent("burnable") end --移除燃烧属性   
    inst.persists = false --退出时不会保存
    inst:DoTaskInTime(60, inst.Remove) --到60s清理掉
    -- announce(player, inst:GetDisplayName())
    if items == nil and type(items) ~= "table" and #items <= 0 then return end
    for i=1,math.random(3,9) do
        local giveItem = SpawnPrefab(items[math.random(#items)])
        if inst.components.container then --箱子容器组件存在，添加到箱子里
            inst.components.container:GiveItem(giveItem)
        end  
    end
end

local function lightningTarget(inst, player)  --天雷陷阱方法，10道雷，分布在玩家1-5单位距离范围内(1块地皮大小4*4)
    player:StartThread(function()  --开启线程
        local x,y,z = player.Transform:GetWorldPosition()
        local num = 35
        for k = 1, num do
            local r = math.random(1, 5)
            local angle = k * 2 * PI / num
            local pos = Point(r*math.cos(angle)+x, y, r*math.sin(angle)+z)
            TheWorld:PushEvent("ms_sendlightningstrike", pos) --触发天雷事件(饥荒自带的降雷),提供坐标
            Sleep(0.1 + math.random() * .1)
            if math.random()<0.5 then spawnAtGround("moonstorm_lightning",r*math.cos(angle)+x,y,r*math.sin(angle)+z) end
        end
    end)
end

local function celestialfury(inst, player)
    player:StartThread(function()  --开启线程
        local num = 5
        for k = 1, num do 
            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(1, 4)
                local angle = j * 2 * PI / 3
                spawnAtGround("alterguardian_phase2spike", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.25)
            end
            local x,y,z = player.Transform:GetWorldPosition()
            local r = math.random(1, 4)
            local angle = k * 2 * PI / num
            spawnAtGround("alterguardian_phase3trapprojectile",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
            Sleep(math.random())
        end
    end)
end

local function bonerain(inst, player)
    player:StartThread(function()  --开启线程
        local num = 9
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            spawnAtGround("fossilspike2",x,y,z)
            Sleep(0.5)
        end

        num = 10
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            local r = math.random(0.5, 4)
            local angle = k * 2 * PI / num
            spawnAtGround("fossilspike2",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
            circular(player,math.random(1,7),math.random(5,9),{"fossilspike","fossilspike2q"})
            Sleep(8.0/num)
        end

        num = 20
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            local r = math.random(0.5, 4)
            local angle = k * 2 * PI / num
            spawnAtGround("fossilspike2",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
            circular(player,math.random(1,7),math.random(5,9),{"fossilspike","fossilspike2q"})
            Sleep(4.5/num)
        end

        num = 27
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            local r = math.random(0.5, 4)
            local angle = k * 2 * PI / num
            spawnAtGround("fossilspike2",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
            circular(player,math.random(15,70)/10,math.random(5,9),{"fossilspike","fossilspike2q"})
            Sleep(3.0/num)
        end
    end)
end

local function luckybounce(inst, player)
    player:StartThread(function()  --开启线程
        local num = 5
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            spawnAtGround("stalker_shield",x,y,z)
            Sleep(0.5)
        end

        local num = 10
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            spawnAtGround("stalker_shield",x,y,z)
            Sleep(0.25)
        end

        local num = 15
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            spawnAtGround("stalker_shield",x,y,z)
            Sleep(0.1)
        end

        local num = 20
        for k = 1, num do 
            local x,y,z = player.Transform:GetWorldPosition()
            spawnAtGround("stalker_shield",x,y,z)
            Sleep(0.05)
        end

        -- num = 35
        -- for k = 1, num do 
        --     local x,y,z = player.Transform:GetWorldPosition()
        --     local r = math.random(0.5, 4)
        --     local angle = k * 2 * PI / num
        --     spawnAtGround("stalker_shield",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
        --     Sleep(60/num)
        -- end
    end)
end

local function moonspiderspike(inst, player)
    local x,y,z = player.Transform:GetWorldPosition()
    spawnAtGround("spider_web_spit_creep",x,y,z)
    spawnAtGround("spider_web_spit_creep",x+1,y,z+1)
    spawnAtGround("spider_web_spit_creep",x-1,y,z-1)   
    circular(player,5,16,{"sandblock"})
    player:StartThread(function()  --开启线程
        local x,y,z = player.Transform:GetWorldPosition()
        local num = 80
        Sleep(0.5)
        for k = 1, num do 
                local r = math.random(5, 45)/10
                local angle = math.random(2, 10) * 2 * PI / math.random(5, 30)
                spawnAtGround("moonspider_spike", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(math.random(10,15)/100) 
        end
    end)
end

local function moonspiderspikes(inst, player)
    local x,y,z = player.Transform:GetWorldPosition()
    local num = 80
    for k = 0, num do 
        spawnAtGround("spider_web_spit_creep",x+k,y,z+k)
        spawnAtGround("spider_web_spit_creep",x-k,y,z-k)  
    end
     
    circular(player,20,128,{"sandblock"})
    player:StartThread(function()  --开启线程
        x,y,z = player.Transform:GetWorldPosition()
        num = 500
        Sleep(0.5)
        for k = 1, num do
                local r = math.random(0.5, 19.5)
                local angle = math.random(0.5, 10) * 2 * PI / math.random(0.5, 10)
                spawnAtGround("moonspider_spike", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.01) 
        end

        circular(player,20,128,{"sandblock"})
        
        num = 500
        for k = 1, num do
                local r = math.random(0.5, 19.5)
                local angle = math.random(0.5, 10) * 2 * PI / math.random(0.5, 10)
                spawnAtGround("moonspider_spike", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.01) 
        end

    end)
end

local function sporebombs(inst, player)
    player:StartThread(function()  --开启线程
        local num = 2
        for k = 1, num do 

            for j = 1, 15 do
                if j % 3 == 0 then
                    circular(player,j*1.5,j+7,{"spore_moon"})
                end

                if j % 3 == 1 then
                    circular(player,j*1.5,j+7,{"spore_tall"})
                end

                if j % 3 == 2 then
                    circular(player,j*1.5,j+7,{"spore_medium"})
                end
                    
                Sleep(0.05)
            end
            
            Sleep(math.random(4,6))
        end
    end)
end

local function mushroombomb1(inst, player)
    player:StartThread(function()  --开启线程
        local num = 2
        for k = 1, num do 

            for j = 1, 3 do
                circular(player,(j+2)*1.3,j+6,{"mushroombomb","mushroombomb"})
            end
            for j = 4, 10 do
                circular(player,(j+2)*1.5,j+6,{"mushroombomb","mushroombomb"})
            end
            for j = 11, 16 do
                circular(player,(j+2)*1.7,j+6,{"mushroombomb","mushroombomb"})
            end
            
            Sleep(math.random(3,4))
        end
    end)
end

local function virtualshadow(inst, player)
    player:StartThread(function()  --开启线程
        local num = math.random(7,10)
        for k = 1, num do 
            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(1, 4)
                local angle = j * 2 * PI / 3
                spawnAtGround("alterguardianhat_projectile", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.2)
            end
            local x,y,z = player.Transform:GetWorldPosition()
            local r = math.random(1, 4)
            local angle = k * 2 * PI / num
            spawnAtGround("gestalt_alterguardian_projectile",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
            Sleep(math.random())
        end
    end)
end

local function shadowtentacle(inst, player)
    player:StartThread(function()  --开启线程
        --Sleep(0.4)
        local num = math.random(9,15)
        for k = 1, num do 
                local x,y,z = player.Transform:GetWorldPosition()
                spawnAtGround("minotaur_blood_big", x,y,z)
                Sleep(0.2)
        end
    end)
end

local function doubletrap(inst, player)
    player:StartThread(function()  --开启线程
        local num = math.random(4,6)
        for k = 1, num do 
            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(3, 7)
                local angle = j * 2 * PI / 3
                spawnAtGround("shadowmeteor", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.1)
            end

            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(4, 6)
                local angle = j * 2 * PI / 3
                spawnAtGround("mushroombomb_dark", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.1)
            end

            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(2, 8)
                local angle = j * 2 * PI / 3
                spawnAtGround("deciduous_root", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.1)
            end

            local x,y,z = player.Transform:GetWorldPosition()
            local r = math.random(1, 4)
            local angle = k * 2 * PI / num
            spawnAtGround("sandspike",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
            Sleep(math.random())
        end
    end)
end

local function teachyou(inst, player)
    player:StartThread(function()  --开启线程
        local num = math.random(4,9)
        for k = 1, num do 
            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(2, 8)
                local angle = j * 2 * PI / 3
                spawnAtGround("alterguardianhat_projectile", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.3)
            end

            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(3, 7)
                local angle = j * 2 * PI / 3
                spawnAtGround("deciduous_root", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.3)
            end

            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(4, 6)
                local angle = j * 2 * PI / 3
                spawnAtGround("tornado", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.3)
            end

            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(2, 7)
                local angle = j * 2 * PI / 3
                spawnAtGround("fossilspike2", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.2)
            end

            for j = 1, 3 do
                local x,y,z = player.Transform:GetWorldPosition()
                local r = math.random(2, 7)
                local angle = j * 2 * PI / 3
                spawnAtGround("wave_med", r*math.cos(angle)+x,y,r*math.sin(angle)+z)
                Sleep(0.2)
            end

            local x,y,z = player.Transform:GetWorldPosition()
            local r = math.random(1, 4)
            local angle = k * 2 * PI / num
            spawnAtGround("sandspike",r*math.cos(angle)+x,y,r*math.sin(angle)+z)
            Sleep(math.random())
        end
    end)
end

local function gunpowdercircle(inst, player)
    local arm = SpawnPrefab("armormarble") --替换为大理石甲
    if player.components and player.components.inventory then player.components.inventory:Equip(arm) end
    local x,y,z = player.Transform:GetWorldPosition()
    local num=4
    for k=1,num do
        local item = spawnAtGround("gunpowder", x,y,z)
        if item then
            item.components.explosive:OnBurnt()
        end
    end
end

local random_item = {
    oar_monkey = 1, --战桨
    nightstick = 1, --影刀
    tentaclespike = 1, --触手棒
    batbat = 1, --蝙蝠棒
    ruins_bat = 1, --铥矿棒
    hambat = 1, --火腿棒
    glasscutter = 1, --玻璃刀
    trident = 1, --三叉戟
    shieldofterror = 0.5, --盾牌
    spear_wathgrithr = 1, --战斗长矛
    spear = 1, --长矛
    multitool_axe_pickaxe = 1, --镐斧
    torch = 1, -- 火把
    
    
    pocketwatch_weapon = 0.3, --警告表
}

local random_hat = {
    footballhat = 1, --猪皮头
    wathgrithrhat = 1, --战斗头
    slurtlehat = 1, --蜗牛头
    ruinshat = 1, --铥矿头
    cookiecutterhat = 1, --饼干头
    eyemaskhat = 1, --恐怖面具
    hivehat = 0.5, --蜂王帽
    skeletonhat = 0.1, --骨头头盔
    
    alterguardianhat = 0.3, --启迪王冠
    eyebrellahat = 0.1, -- 眼球伞
}

local random_hat1 = {
    footballhat = 1, --猪皮头
    wathgrithrhat = 1, --战斗头
    slurtlehat = 1, --蜗牛头
    ruinshat = 0.3, --铥矿头
    cookiecutterhat = 1, --饼干头
    eyemaskhat = 1, --恐怖面具
    hivehat = 0.1, --蜂王帽
    flowerhat = 1, -- 花环
    watermelonhat = 1, -- 西瓜帽
    winterhat = 0.1, -- 冬帽 
    icehat = 0.5, --  冰块帽
}

local function getplayer(inst, player)
    local items = data.getplayer
    inst:DoTaskInTime(180,function(inst) inst:Remove() end)
    if inst.components.health then --设置生命上限, 容易弄死, 好掉落东西
        inst.components.health:SetMaxHealth(150)
    end
    if inst.components.inventory then --放一些东西
        local max = math.random(1,5)

        local oar = SpawnPrefab(weighted_random_choice(random_item))
        oar:AddTag("personal_possession")
        inst.components.inventory:GiveItem(oar)
        inst.components.inventory:Equip(oar)
	    if oar.prefab == "pocketwatch_weapon" then oar.components.equippable.restrictedtag = "monkey" end

        local hat = SpawnPrefab(weighted_random_choice(random_hat))
        hat:AddTag("personal_possession")
        inst.components.inventory:GiveItem(hat)
        inst.components.inventory:Equip(hat)

    end
end

local function getbuilds(inst, player)
    local farms = {"slow_farmplot","fast_farmplot"}
    local farm = farms[math.random(#farms)]

    -- 这个是奶奶读万物百科的效果
    --player.components.builder:GiveTempTechBonus({SCIENCE = 2, MAGIC = 2, SEAFARING = 2})
    --player.components.builder:GiveTempTechBonus({SCIENCE = 0, MAGIC = 0, SEAFARING = 0})
    
    -- 灯泡特效
    local fx = SpawnPrefab(player.components.rider ~= nil and player.components.rider:IsRiding() and "fx_book_research_station_mount" or "fx_book_research_station")
    fx.Transform:SetPosition(player.Transform:GetWorldPosition())
    fx.Transform:SetRotation(player.Transform:GetRotation())

    player.components.builder:UnlockRecipe(farm)
	player.components.builder.buffered_builds[farm] = 0
	player.replica.builder:SetIsBuildBuffered(farm, true)

end


local function giveitem(inst, player)
    local oar = SpawnPrefab(weighted_random_choice(random_item))
    local hat = SpawnPrefab(weighted_random_choice(random_hat))

    setRandomSkinFgc(oar,player)
    setRandomSkinFgc(hat,player)
    if oar == nil or hat == nil then return end

    oar:AddTag("personal_possession")
    inst.components.inventory:GiveItem(oar)
    inst.components.inventory:Equip(oar)
	if oar.prefab == "pocketwatch_weapon" then oar.components.equippable.restrictedtag = "monkey" end

    hat:AddTag("personal_possession")
    inst.components.inventory:GiveItem(hat)
    inst.components.inventory:Equip(hat)
end

local function giveitemtopigspider(inst, player)
    local hat = SpawnPrefab(weighted_random_choice(random_hat1))
    --hat:AddTag("personal_possession")
    --inst.components.inventory:GiveItem(hat)
    inst.components.inventory:Equip(hat)
end

local function oasislake(inst, player)
    inst.Physics:SetMass(0) -- 抛物结束，修改质量为0
    inst:DoTaskInTime(1.5,function(inst)
        if inst.driedup then -- 不可以钓鱼时
            inst.Physics:ClearCollisionMask() -- 清碰撞组
            inst.Physics:CollidesWith(COLLISION.ITEMS)
        else -- 可以钓鱼时
            inst.Physics:CollidesWith(COLLISION.CHARACTERS)
            inst.Physics:CollidesWith(COLLISION.GIANTS)
        end
    end)
end

local function onAddHun(inst, player) --啜食
    if player.components.modnewbuff then 
        player.components.modnewbuff:StartTimer("OnAddHun",10,0,1,0) -- 持续10秒
    end    
end

local function onAddSan(inst, player) --降智
    if player.components.modnewbuff then
        player.components.modnewbuff:StartTimer("OnAddSan",10,0,1,0) -- 持续10秒
    end    
end

local function onAddHp(inst, player) --流血
    if player.components.modnewbuff then
        player.components.modnewbuff:StartTimer("OnAddHp",10,0,1,0) -- 持续10秒
    end    
end

local shadow_boss = {"shadow_rook","shadow_knight","shadow_bishop"}
local function shadow_level(inst, player) --暗影陷阱 暗影基佬随机等级 
    local shadow = SpawnPrefab(shadow_boss[math.random(#shadow_boss)])
    shadow.Transform:SetPosition(player.Transform:GetWorldPosition())
    shadow:DoTaskInTime(0,function(inst)
        shadow:LevelUp(math.random(3))
    end)
end

local function healthlink(inst, player)
    -- print("触发事件的玩家",player)
    if player.components.healthlink == nil then
        player:AddComponent("healthlink")
    end
    player.components.healthlink:AddTarget()
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
	--local x,y,z= inst.Transform:GetWorldPosition()
    local x,y,z = picker.Transform:GetWorldPosition()
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

local function fengguncaobao(inst, player)
    
        if player~=nil then
            local giftloot={
                tumbleweed=4,
            }
            spawnGift(inst,giftloot,player)
        end

end

local function caveinobstacle(inst, player) -- 柱！柱！柱！
    player:StartThread(function()  --开启线程
        for i=1, math.random(4,6) do
            player:DoTaskInTime(0.5+(math.random()*5), function(inst)
                local x,y,z = inst.Transform:GetWorldPosition()
                local item = spawnAtGround("ruins_cavein_obstacle",x+math.random()*5,0,y+math.random()*5)
                if not item then return end -- 有概率生成失败，原因暂时不明，计算量太大了吗
                -- local obstacle = SpawnPrefab("ruins_cavein_obstacle")
                -- obstacle.components.lootdropper:SetChanceLootTable('mod_nil')
                -- obstacle.Transform:SetPosition(inst.Transform:GetWorldPosition())
                item.fall(item,Vector3(inst.Transform:GetWorldPosition()))
            end)
        end
    end)
end

local function sporecloud(inst, player) -- 多重孢子云
    player:StartThread(function()  --开启线程
        for i=1, math.random(1,3) do
            player:DoTaskInTime(1+(math.random()*2), function(inst)
                local sporecloud = SpawnPrefab("sporecloud")
                sporecloud.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end)
        end
    end)
end

local function geminimagiceye(inst, player) -- 双子魔眼

    local x,y,z = player.Transform:GetWorldPosition()

    local eyeofterror = SpawnPrefab("twinmanager")
    eyeofterror.Transform:SetPosition(x,y,z)    -- Needs to be done so the spawn fx spawn in the right place
    if eyeofterror.sg ~= nil then
        eyeofterror.sg:GoToState("arrive", player)
    else
        eyeofterror:PushEvent("arrive", player)
    end

    eyeofterror:PushEvent("set_spawn_target", player)
end

local function hedgehounds(inst, player) --蔷薇陷阱
    circular(player,math.random(2,3),math.random(2,6),{"hedgehound_bush"},function(inst, target)
        if target ~= nil and inst.components.combat then
            inst.components.combat:SuggestTarget(target) --仇恨
        end
    end)
    circular(player,math.random(6,7),math.random(4,8),{"hedgehound_bush"},function(inst, target)
        if target ~= nil and inst.components.combat then
            inst.components.combat:SuggestTarget(target) --仇恨
        end
    end)

    circular(player,math.random(4,5),math.random(6,10),{"hedgehound"},function(inst, target)
        if target ~= nil and inst.components.combat then
            inst.components.combat:SuggestTarget(target) --仇恨
        end
    end)

    circular(player,math.random(8,9),math.random(8,12),{"hedgehound"},function(inst, target)
        if target ~= nil and inst.components.combat then
            inst.components.combat:SuggestTarget(target) --仇恨
        end
    end)
end

local NO_REMOVE = {"player","INLIMBO","ignorewalkableplatforms","irreplaceable","shadowcreature","farm_plant","_combat",
                 "locomotor","boat","FX","NOBLOCK","NOCLICK","multiplayer_portal" }

local function removeitems(inst, player) --清理物品
    local x,y,z = player.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z,10,nil,NO_REMOVE)
    if ents ~= nil then
        for k,v in pairs(ents) do
            v:Remove()
        end
    end
end

return {
	gift = gift, -- 钓到鸟类
    grotto_pool_small = grotto_pool_small, -- 钓到了岩石水池
	klaus = klaus, -- 钓到克劳斯
    stalker_atrium = stalker_atrium, -- 钓到织影者
	weatherchanged = weatherchanged, -- 阴晴不定
	rockcircle = rockcircle, -- 岩石怪圈
	campfirecircle = campfirecircle, -- 营火晚会
	monstercircle = monstercircle, -- 生物怪圈
    maxwellcircle = maxwellcircle, -- 犬牙陷阱圈
    chest = chest, -- 钓到箱子了
    lightningTarget = lightningTarget, -- 天雷陷阱
    celestialfury = celestialfury, -- 天体陷阱
    teachyou = teachyou, -- 教你做人
    doubletrap = doubletrap, -- 双倍快乐
    sporebombs = sporebombs, --真假孢子
    shadowtentacle = shadowtentacle, -- 触手鞭打
    floods = floods, --  水火相融
    ghostcir = ghostcir, -- 一圈灵魂
    giveitem = giveitem, --  给大幅装备
    bonerain = bonerain, -- 扎不扎你
    giveitemtopigspider, -- 给猪鱼人蜘蛛装备
    eyecircle = eyecircle, --眼球圈
    luckybounce = luckybounce, -- 幸运弹弹弹
    virtualshadow = virtualshadow, -- 追踪虚影子
    clumsyimitation = clumsyimitation, -- 拙略模仿
    radiationtentacle = radiationtentacle, --辐射触手
    pigelite = pigelite, -- 狠狠地打
    mushroombomb1 = mushroombomb1, -- 蘑菇炸弹
    moonspiderspike = moonspiderspike, -- 整不死你
    moonspiderspikes = moonspiderspikes, -- 整不死你们
    gunpowdercircle = gunpowdercircle, -- 火药陷阱
    getplayer = getplayer, --钓起个角色
    oasislake = oasislake, --钓湖泊时
    onAddHun = onAddHun, -- 啜食
    onAddSan = onAddSan, -- 降智
    onAddHp = onAddHp, -- 流血
    shadow_level = shadow_level, -- 暗影陷阱
    healthlink = healthlink, -- 单向生命链接
    caveinobstacle = caveinobstacle, -- 柱！柱！柱！
    sporecloud = sporecloud, -- 多重孢子云
    hedgehounds = hedgehounds, --蔷薇陷阱
    fengguncaobao = fengguncaobao,--风滚草包
    fengguncao=fengguncao, -- 风滚草
    geminimagiceye = geminimagiceye, -- 双子魔眼
    getbuilds = getbuilds, -- 获得农场
}