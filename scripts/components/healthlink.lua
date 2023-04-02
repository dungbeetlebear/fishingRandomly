-----------------------------
-- 【单向生命链接状态】
-- 单向生命链接其他玩家, 简称：指向
-- 一个玩家可以被多人指向, 但只能指向另一个玩家
-- 已经指向了一个玩家, 那么无法被玩家指向
-- 被指向玩家,生命值变化时,反馈给发出指向的玩家, 反过来并不影响
-- 玩家死亡或离开时,断开全部指向
-- 单向生命链接状态结束方法,只有玩家死亡或等待结束

-----------------------------
-- local ROCKYS = GLOBAL.ROCKYS
local function OnDoDelta(inst,data)
    local self = inst.components.healthlink
    -- print("玩家实体删除了")
    for k,v in pairs(self.list) do
        if v ~= nil and v:IsValid() and v.components.healthlink then -- 存在且存活
            v.components.healthlink:DeleTarget(true) --断开链接, 但继续执行 -- 多人同时(也有先后)被断开 谁先谁不能被
        end
    end
    self.list = {} --应该可以没有, 按要求是已经全部要    
end

local LINKTIME = 60*4 -- 持续时间

local HealthLink = Class(function(self,inst)
	self.inst = inst
    self.list = {} -- 指向自己的玩家列表
    --self.timer = nil
    --self.target = nil -- 监听目标生命值变化
    -- 监听新增加链接目标的事件
    self.inst:ListenForEvent("addnewplayer_healthlink",function(inst,player) 
        -- print("新增加受自己影响玩家",player)
        if player ~= nil and self.list[player.userid] == nil then
            self.list[player.userid] = player
        end
    end)
    -- 监听删除链接目标的事件
    self.inst:ListenForEvent("deleteplayer_healthlink",function(inst,player)
        -- print("移除受自己影响玩家",player,self.list[player.userid]) 
        if player ~= nil and self.list[player.userid] ~= nil then
            self.list[player.userid] = nil
        end
    end)

    -- 监听自己的生命值变化 变化后 给全部其他监听自己的玩家
    self.inst:ListenForEvent("healthdelta",function(inst,data)
        -- print("生命值变化",self.inst,data.amount)
        for k,v in pairs(self.list) do
            if v ~= nil and v:IsValid() and
            not v:HasTag("playerghost") and
            v.components.health ~= nil and
            not v.components.health:IsDead() then -- 存在且存活
                v.components.health:DoDelta(data.amount)
            end
        end
    end)

    -- 如果自己死亡 断开链接 结束任务
    self.inst:ListenForEvent("death", function(inst,data) 
        -- print("玩家已死亡")
        self:StopTimer()
        for k,v in pairs(self.list) do
            if v ~= nil and v:IsValid() and v.components.healthlink then -- 存在且存活
                v.components.healthlink:DeleTarget(true) --断开链接, 但继续执行 -- 多人同时(也有先后)被断开 谁先谁不能被
            end
        end
        self.list = {} --应该可以没有, 按要求是已经全部要
    end)

    -- 关于自己复活时
    self.inst:ListenForEvent("respawnfromghost",function(inst,data)
    end)

    -- 玩家在当前世界移除时
    -- self.inst:ListenForEvent("ms_playerdespawn", OnDoDelta) --论玩家的绝望
    -- self.inst:ListenForEvent("ms_playerdespawnanddelete", OnDoDelta) --在播放器上展开并删除
    -- self.inst:ListenForEvent("ms_playerdespawnandmigrate", OnDoDelta) --关于玩家展开和迁移
    self.inst:ListenForEvent("onremove", OnDoDelta) --前面几个监听器已经会进行删除玩家角色的，这个里加一个防意外

end)
-- 停止任务
function HealthLink:StopTimer(continue)
    self:DeleTimer()
    self:DeleTarget(continue)
    self.inst:StopUpdatingComponent(self) --停止更新组件
    self.nolink = nil
    -- print("状态结束",self.target,self.timer)
end
-- 添加结束任务
function HealthLink:AddTimer(time)
    if self.timer ~= nil then return end
    -- print("创建计时器",self.inst)
    self.timer = self.inst:DoTaskInTime(time or LINKTIME, function(inst)
        self:StopTimer()
    end)
end
--删除结束任务
function HealthLink:DeleTimer()
    if self.timer ~= nil then
        self.timer:Cancel() --停用
        self.timer = nil
    end
end
-- 添加链接目标
function HealthLink:AddTarget(target,time) --添加到一个新玩家身上
    if target == nil then --说明需要重新找一个目标
        self:AddTimer(time)
        self.inst:StartUpdatingComponent(self)
        return
    end
    if self.target == target then return end
    self:DeleTarget() -- 如果已经链接 则断开
    self.nolink = true --不可链接
    self.target = target
    self.target:PushEvent("addnewplayer_healthlink",self.inst)
    -- print("链接成功",self.target)    
    local target_fx = SpawnPrefab("fishingsurprised")
    local inst_fx = SpawnPrefab("fishingsurprised")
    local r = math.random(1,255)/255
    local p = math.random(1,255)/255
    local c = math.random(1,255)/255
    target_fx.AnimState:SetMultColour(r, p, c, 1)
    inst_fx.AnimState:SetMultColour(r, p, c, 1)
    target_fx.Transform:SetPosition(target.Transform:GetWorldPosition())
    inst_fx.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
end
-- 断开链接目标
function HealthLink:DeleTarget(continue)
    if self.target ~= nil then
        self.target:PushEvent("deleteplayer_healthlink",self.inst)
        self.target = nil
    end
    if continue then
        -- print("目标失去，重新等待")
        self.nolink = nil -- 可以被链接 
        self.inst:StartUpdatingComponent(self) --重新找一个目标
    end
end

-- 没有可链接目标 边等时间结束 边查
function HealthLink:OnUpdate(dt)
    if #AllPlayers > 1 then --把自己排除在外
        for i, v in ipairs(AllPlayers) do --全部玩家
            if v:IsValid() and v ~= self.inst and --目标存在不为玩家
            not v:HasTag("playerghost") and -- 目标不是鬼魂状态
            v.components.health and not v.components.health:IsDead() and -- 目标没有死亡
            v.components.healthlink and not v.components.healthlink.nolink then -- 目标可以被链接
                self:AddTarget(v)
                self.inst:StopUpdatingComponent(self) --停止更新组件
            end
        end          
    end
    -- if ROCKYS ~= nil then
    --     for k,v in pairs(ROCKYS) do
    --         if v:IsValid() and v ~= self.inst and
    --         v.components.health and
    --         not v.components.health:IsDead() and
    --         v.components.healthlink and
    --         not v.components.healthlink.nolink then
    --             self:AddTarget(v)
    --             -- print("找到目标",self.inst,v)
    --             self.inst:StopUpdatingComponent(self) --停止更新组件
    --         end            
    --     end
    -- end
end


-----------------保存加载-----------------------
function HealthLink:OnSave()
    local time = self.timer and GetTaskRemaining(self.timer) or 0
    -- print("保存,剩余时间",time)
    return { time = time}
end

function HealthLink:OnLoad(data)
    -- print("加载数据",data.time)
    -- 重新加入游戏，应该被人链接才对
    self.inst:DoTaskInTime(1,function()
        self:AddTarget(nil,data.time)
    end)
end
-- 变猴子也继承
function HealthLink:TransferComponent(newinst)
    local data = self:OnSave()
    if data then
        local newcomponent = newinst.components.healthlink
        if not newcomponent then
            newinst:AddComponent("healthlink")
            newcomponent = newinst.components.healthlink
        end
        newcomponent:OnLoad(data)
    end
end

return HealthLink