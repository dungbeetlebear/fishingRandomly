local function tofullmoon(inst, player)
	TheWorld:PushEvent("moonphasechanged2", {moonphase = "full", waxing = true})
end
local function tonewmoon(inst, player)
	TheWorld:PushEvent("moonphasechanged2", {moonphase = "new", waxing = true})
end

local function shadow(inst, player)
	for k,v in pairs({"shadow_rook","shadow_bishop","shadow_knight"}) do
		local item = SpawnPrefab(v)
		item.Transform:SetPosition(player.Transform:GetWorldPosition())
		item.components.combat:SuggestTarget(player)
	end
end

local function pigman(inst, player)
	inst.components.werebeast:TriggerDelta(4) --变疯猪
end

local especiallys = {}
-- 月圆
especiallys.fullmoon = {
    {chance = 0.1, item = "pigman", sleeper = true, eventF = pigman},--猪人疯猪
    {chance = 0.001, item = "moonbase", announce = true, build = build},--月亮石
    {chance = 0.001, item = "statueglommer", announce = true, build = build},--格罗姆雕像
    {chance = 0.1, item = "glommerfuel"},--格罗姆黏液
	{chance = 0.004, item = "yellowstaff", announce = true},--唤星者法杖
	{chance = 0.1, item = "krampus", sleeper = true},--小偷
	-- 变月黑
	--{chance = 0.01, item = "fishingsurprised", name = "变月黑", eventF = tonewmoon},
}
-- 新月
especiallys.newmoon = {
	{chance = 0.01, item = "fishingsurprised", name = "暗影三兄贵", eventA = shadow},-- 暗影三基佬
	-- {chance = 0.1, item = "krampus", sleeper = true},--小偷
    {chance = 0.1, item = "crawlinghorror"},--暗影爬行怪
    {chance = 0.05, item = "terrorbeak"},--尖嘴暗影怪
	{chance = 0.05, item = "nightmarefuel"},-- 噩梦燃料
	-- 变月圆
	{chance = 0.01, item = "fishingsurprised", name = "变月圆", eventF = tofullmoon}, 
}


return especiallys