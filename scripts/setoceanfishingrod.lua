-- 一般
local loots = HARVEST or require("loots")
-- 特殊情况
local especiallys = require("especiallys")

-- 换皮肤
local function SetSpellCB(target,player)
    if not target:IsValid() then return false end
    player = player or target.components.inventorytarget.owner
    local target_types = {}
    if PREFAB_SKINS[target.prefab] ~= nil then
        for _,target_type in pairs(PREFAB_SKINS[target.prefab]) do
            if TheInventory:CheckClientOwnership(player.userid, target_type) then
                table.insert(target_types,target_type)
            end
        end
    end
    if #target_types<=0 then
        return false
    end
    TheSim:ReskinEntity( target.GUID, target.skinname, target_types[math.random(#target_types)], nil, player.userid ) --玩家有的随机物品皮肤
end

local function Reward(inst, fisher, target)  --用于自定义 空军时的奖励执行逻辑
    -- 这是直接抄鱼的碰撞
    local SWIMMING_COLLISION_MASK   = COLLISION.GROUND
                                    + COLLISION.LAND_OCEAN_LIMITS
                                    + COLLISION.OBSTACLES
                                    + COLLISION.SMALLOBSTACLES
    local PROJECTILE_COLLISION_MASK = COLLISION.GROUND

    local today = TheWorld.state.cycles  --世界天数
    local playerage = fisher.components.age:GetAgeInDays() or 0 --玩家天数

    local isfullmoon = TheWorld.state.isfullmoon -- 满月
    local isnewmoon = TheWorld.state.isnewmoon -- 新月

    local CUSTOMARY = nil   -- 记录原碰撞组
    local Mass = nil        -- 记录原自由落体
    local NoPhysics = nil   -- 不存在物理
    local Fn_hit = nil      -- 记录原投掷结束方法
    local Fn_launch = nil   -- 记录原投掷开始方法
    local Fn = nil          -- 记录投掷结束要执行方法

    local function setoption(default,item)
        local v = item
        if default then
            v.build = v.build == nil and default.build or v.build
            v.sleeper = false
            v.hatred = v.hatred == nil and default.hatred or v.hatred
            v.announce = v.announce == nil and default.announce or v.announce
        end      
        return v
    end

    -- 重组钓起物表
    local function recombination()
        local probably_loot = {}
        local loots_ = deepcopy(loots)
        local extras = deepcopy(TUNING.OCEANFISHINGROD_R)
        for name, child in pairs(loots_ and type(loots_) == "table" and loots_ or {}) do
            for k, v in ipairs(child and type(child) == "table" and child or {}) do
                if name == "giants" then 
                    if playerage <= 3 then -- 前几天,不让玩家钓到boss
                        break
                    end
                    v.chance = v.chance * math.min(playerage/22 + 1, 5) -- 1~5 随天数增加
                end
                if name == "builds" then
                    v.chance = v.chance * math.min(today/40 + 1,5) --
                end

                table.insert(probably_loot, setoption(child.default, v))
            end
        end      
        for name, extra in pairs(extras and type(extras) == "table" and extras or {}) do
            for k, v in ipairs(extra and type(extra) == "table" and extra or {}) do
                table.insert(probably_loot, setoption(extra.default, v))
            end
        end
        return probably_loot
    end
    local function OnProjectileLand(inst)
        -- 重启脑子
        inst:RestartBrain()
        -- 延迟执行，给玩家时间，避免被卡建筑
        inst:DoTaskInTime(1,function(inst)
            inst.Physics:SetCollisionMask(CUSTOMARY or SWIMMING_COLLISION_MASK) --WORLD
            inst.Physics:SetMass(Mass or 0)
        end)
        -- 投掷
        if Fn_hit == nil then
            inst:RemoveComponent("complexprojectile")
        else
            inst.components.complexprojectile:SetOnHit(Fn_hit)
            inst.components.complexprojectile:SetOnLaunch(Fn_launch or nil)
        end
        -- 物理学
        if NoPhysics then
            RemovePhysicsColliders(inst) -- 移除物理
        end
        -- 溺水
        if inst.components.drownable then
            inst.components.drownable.enabled = true
        end
        -- 清醒
        if inst.components.sleeper then
            inst.components.sleeper:WakeUp()
        end
        -- 记住家
        if inst.components.knownlocations then 
            inst.components.knownlocations:RememberLocation("spawnpoint", inst:GetPosition(), false) -- 重新记住
        end

        if Fn ~= nil then
            Fn(inst, fisher)
        end
    end
    local function SpawnLoot(loot)
        local item = SpawnPrefab(type(loot.item) == "table" and loot.item[math.random(#loot.item)] or loot.item)
        if item == nil then return end -- 保险
        SetSpellCB(item,fisher) --随机皮肤
        item:StopBrain() -- 大脑停止
        -- 是否宣告
        if loot.announce or loot.name then
            local fisher_name = fisher and fisher:GetDisplayName() or "???"
            local item_name = loot.name or item:GetDisplayName() or item
            TheNet:Announce(fisher_name .. " 钓到了 " .. item_name)
        end

        if item.Physics then
            -- 设置质量，建筑为0，默认 1 物品
            Mass = item.Physics:GetMass() 
            item.Physics:SetMass(loot.build and 0 or 1)

            -- 设置碰撞组，不会碰海岸、船、玩家等
            CUSTOMARY = item.Physics:GetCollisionMask()
            item.Physics:SetCollisionMask(PROJECTILE_COLLISION_MASK)  -- WORLD    
        else
            NoPhysics = true
            MakeInventoryPhysics(item) -- 添加物理
            item.Physics:SetCollisionMask(PROJECTILE_COLLISION_MASK)
            --print("状态2",NoPhysics)
        end

        -- 要有 Physics，才能添加 complexprojectile
        if item.components.complexprojectile == nil then
            item:AddComponent("complexprojectile")
        else -- 投掷类物品
            Fn_hit = item.components.complexprojectile.onhitfn
            Fn_launch = item.components.complexprojectile.onlaunchfn
        end
        -- 设置投掷结束和开始时执行方法
        item.components.complexprojectile:SetOnHit(OnProjectileLand)
        item.components.complexprojectile:SetOnLaunch(nil)

        -- 防溺水，蜘蛛猪人等
        if item.components.drownable then
            item.components.drownable.enabled = false
        end 

        -- 设置睡眠
        if item.components.sleeper and not loot.sleeper then
            item.components.sleeper:GoToSleep(0)
        end

        -- 设置仇恨
        if item.components.combat and not loot.hatred then
            item.components.combat:SuggestTarget(fisher)
        end

        --受难 有67%概率随机耐久随机新鲜值
        if math.random() > 0.67 then 
            if item.components.fueled then
                item.components.fueled:SetPercent(math.random()) --随机燃料值
            end
            if item.components.finiteuses then
                item.components.finiteuses:SetPercent(math.random()) --随机耐久
            end
            if item.components.perishable then
                item.components.perishable:SetPercent(math.random()) --随机新鲜值
            end
        end

        -- 在钓起时执行
        if loot.eventF ~= nil and type(loot.eventF) == "function" then
            loot.eventF(item, fisher)
        end

        -- 在投掷到地面时执行
        if loot.eventA ~= nil and type(loot.eventA) == "function" then
            Fn = loot.eventA
        end

        if item.components and item.components.health ~= nil and (not item:HasTag("soulless")) and (not item:HasTag("epic"))then
            item:AddTag("soulless")
        end


        local itemname = loot.name or item:GetDisplayName() or item

        -- itemname == "minotaur" 远古守护者就不加了，容易挤到海上
        if itemname == "石虾" or itemname == "皮弗娄牛" or itemname == "发条战车" or itemname == "损坏的发条战车" then
            -- 弹道长一点，防止在海上
            local targetpos = inst.components.oceanfishingrod:CalcCatchDest(target:GetPosition(), fisher:GetPosition(), 4)
            local startpos = target:GetPosition()
            inst.components.oceanfishingrod:_LaunchFishProjectile(item, startpos, targetpos-(startpos - targetpos)/2)
        else
            -- 弹道
            local targetpos = inst.components.oceanfishingrod:CalcCatchDest(target:GetPosition(), fisher:GetPosition(), 4)
            local startpos = target:GetPosition()
            inst.components.oceanfishingrod:_LaunchFishProjectile(item, startpos, targetpos)
        end
    end

    -- 根据世界情况来选择
    local loot = nil

    loot = isfullmoon and WeightRandom(especiallys.fullmoon) or nil 
    loot = loot or (isnewmoon and WeightRandom(especiallys.newmoon) or nil)
    loot = loot or WeightRandom(recombination())
    
    if loot == nil and loot.item == nil then return end -- 保险
    -- 生成
    SpawnLoot(loot)
end

local function OnDoneFishing(inst, reason, lose_tackle, fisher, target) --自己、原因、  、钓鱼的人、 目标
    if inst.components.container ~= nil and lose_tackle then
        inst.components.container:DestroyContents()
    end

    if inst.components.container ~= nil and fisher ~= nil and inst.components.equippable ~= nil and inst.components.equippable.isequipped then
        inst.components.container:Open(fisher)
    end

    local function AddSum()
        -- 记录玩家 钓鱼次数
        local data = TheWorld.components.worldstate.data
        if data.new_fishing == nil then
            data.new_fishing = {}
        end
        data.new_fishing[fisher.userid] = data.new_fishing[fisher.userid] and data.new_fishing[fisher.userid] + 1 or 1
        -- print(fisher:GetDisplayName().." 钓鱼次数",data.new_fishing[fisher.userid])
        if data.new_fishing[fisher.userid]%200 == 0 and data.new_fishing[fisher.userid] > 0 then
            fisher.components.inventory:GiveItem(SpawnPrefab("poop")) 
            TheNet:Announce(fisher:GetDisplayName() .. " 钓了 " .. data.new_fishing[fisher.userid] .. "次".."  奖励一坨大便")
        end       
    end

    -- 空军情况 
    if reason == "reeledin" and fisher ~= nil and fisher:HasTag("player") then
        if inst.Reward then -- 可以执行你的方法
            inst.Reward(inst, fisher, target) 
        else
            Reward(inst, fisher, target) -- 海竿，钓鱼人，目标
        end
        AddSum()
    end
    -- 钓起鱼
    if reason == "success" and fisher ~= nil and fisher:HasTag("player") then
        AddSum()
    end
end


AddPrefabPostInit("oceanfishingrod",function(inst)
    if TheWorld.ismastersim then
        if inst.components.oceanfishingrod then
            inst.components.oceanfishingrod.ondonefishing = OnDoneFishing  -- 钓鱼完毕 
        end
        -- inst.Reward = function() --用于自定义 空军时的奖励执行逻辑
    end
end)

-- reason: 有这种情况
-- 1 reeledin ...\scripts\actions.lua 的 ACTIONS.OCEAN_FISHING_STOP 表示 空军
-- 2 success ...\scripts\components\oceanfishingrod.lua 的 CatchFish 表示 捕鱼成功
-- 3 linesnapped ...\scripts\components\oceanfishingrod.lua 的 Reel 表示 线断了
-- 4 interupted ...\scripts\components\oceanfishingrod.lua 的 OnUpdate 表示 钓鱼行为 被打断
-- 5 linetooloose ...\scripts\components\oceanfishingrod.lua 的 OnUpdate 表示 线太松
-- 6 nil ...\scripts\components\oceanfishingrod.lua 的 OnUpdate 表示 钓鱼人没了
