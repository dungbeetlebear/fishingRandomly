------对应的buff执行函数------
local function OnAddHp(inst)
    if inst:IsValid() and inst.components.health then
        inst.components.health:DoDelta(-5)
    end 
end

local function OnAddSan(inst)
    if inst:IsValid() and inst.components.sanity then
        inst.components.sanity:DoDelta(-5)
    end 
end

local function OnAddHun(inst)
    if inst:IsValid() and inst.components.hunger then
        inst.components.hunger:DoDelta(-5)
    end 
end
-----------------------------

local buffevent = {
    OnAddHp = OnAddHp,
    OnAddSan = OnAddSan,
    OnAddHun = OnAddHun,
}

local function OnStopTimer(inst, self, name)
    self:StopTimer(name)
end

local MODNewBuff = Class(function(self,inst)
	self.inst = inst
	self.timers = {}
end)

function MODNewBuff:StartTimer(name, time, initialtime_override, frequency, starttime)
	if not self.timers or self:GetNameBuff(name) or buffevent[name] == nil then return end --等待对应的buff,结束 或者 没有对应的buff
	self.timers[name] =
    {
        timer = self.inst:DoTaskInTime(time, OnStopTimer, self, name), -- 控制关闭
        buff = self.inst:DoPeriodicTask(frequency or 1, buffevent[name], starttime or 1), -- 执行方法
        timeleft = time,
        end_time = GetTime() + time,
        initial_time = initialtime_override or time,
    }
end

function MODNewBuff:GetNameBuff(name)
	return self.timers[name] ~= nil
end

function MODNewBuff:GetTimeLeft(name)
    if not self:GetNameBuff(name) then
        return 0
    else
        self.timers[name].timeleft = self.timers[name].end_time - GetTime()
    end
    return self.timers[name].timeleft
end

function MODNewBuff:StopTimer(name)
    if not self:GetNameBuff(name) then
        return
    end
    if self.timers[name].buff ~= nil then
        self.timers[name].buff:Cancel()
        self.timers[name].buff = nil
    end
    if self.timers[name].timer ~= nil then
        self.timers[name].timer:Cancel()
        self.timers[name].timer = nil
    end
    self.timers[name] = nil
end

-----------------保存加载-----------------------
function MODNewBuff:OnSave()
    local data = {}
    for k, v in pairs(self.timers) do
        data[k] =
        {
            timeleft = self:GetTimeLeft(k),
            initial_time = v.initial_time,
        }
    end
    return { timers = data }
end

function MODNewBuff:OnLoad(data)
    if data.timers ~= nil then
        for k, v in pairs(data.timers) do
            self:StopTimer(k)
            self:StartTimer(k, v.timeleft, v.initial_time)
        end
    end
end

-- 变猴子也继承
function MODNewBuff:TransferComponent(newinst)
    local data = self:OnSave()
    if data then
        local newcomponent = newinst.components.modnewbuff
        if not newcomponent then
            newinst:AddComponent("modnewbuff")
            newcomponent = newinst.components.modnewbuff
        end
        newcomponent:OnLoad(data)
    end
end

return MODNewBuff