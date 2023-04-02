local LOOT_GL = 0.4
local SOUL_GL = 0.33
AddComponentPostInit("lootdropper", function(self, inst)
    self.DropLoot = function(self, pt) -- 只好覆盖原方法
        local prefabs = self:GenerateLoot()
        if self.inst:HasTag("burnt")
        or (self.inst.components.burnable ~= nil and
        self.inst.components.burnable:IsBurning() and
        (self.inst.components.fueled == nil or self.inst.components.burnable.ignorefuel)) then
            
            local isstructure = self.inst:HasTag("structure")
            for k, v in pairs(prefabs) do
                if TUNING.BURNED_LOOT_OVERRIDES[v] ~= nil then
                    prefabs[k] = TUNING.BURNED_LOOT_OVERRIDES[v]
                elseif PrefabExists(v.."_cooked") then
                    prefabs[k] = v.."_cooked"
                elseif PrefabExists("cooked"..v) then
                    prefabs[k] = "cooked"..v
                elseif (not isstructure and not self.inst:HasTag("tree")) or self.inst:HasTag("hive") then 
                    prefabs[k] = "ash"
                end
            end
        end
        for k, v in pairs(prefabs) do
            if v == "meat" or v == "monstermeat" or v == "steelwool" or v == "phlegm" 
            or v == "mosquitosack" or v == "stringer" or v == "houndstooth" or
            v == "slurtle_shellpieces" then
                if math.random() < 0.3 then -- 就这里添加一下概率 每次掉落时判断一下
                    self:SpawnLootPrefab(v, pt)
                end
            else
                self:SpawnLootPrefab(v, pt)
            end

        end
        if IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST) then
            local prefabname = string.upper(self.inst.prefab)
            local num_decor_loot = self.GetWintersFeastOrnaments ~= nil and self.GetWintersFeastOrnaments(self.inst) or TUNING.WINTERS_FEAST_TREE_DECOR_LOOT[prefabname] or nil
            if num_decor_loot ~= nil then
                for i = 1, num_decor_loot.basic do
                    self:SpawnLootPrefab(GetRandomBasicWinterOrnament(), pt)
                end                         
                if num_decor_loot.special ~= nil then
                    self:SpawnLootPrefab(num_decor_loot.special, pt)
                end
            elseif not TUNING.WINTERS_FEAST_LOOT_EXCLUSION[prefabname] and (self.inst:HasTag("monster") or self.inst:HasTag("animal")) then
                local loot = math.random()
                if loot < 0.005 then
                    self:SpawnLootPrefab(GetRandomBasicWinterOrnament(), pt)
                elseif loot < 0.20 then
                    self:SpawnLootPrefab("winter_food"..math.random(NUM_WINTERFOOD), pt)
                end
            end
        end
        
        TheWorld:PushEvent("entity_droploot", { inst = self.inst })
    end
end)
--[[
]]


AddPrefabPostInit("wortox_soul_spawn", function(inst)
    -- 击杀生物时有33%概率掉落灵魂
    -- inst:DoTaskInTime(0,function(inst)
    --     if math.random() > SOUL_GL then
    --         inst:Remove()
    --     end
    -- end)
end)

-- 移除boss之间的仇恨
local function CombatPostInit(inst)

	local old_CanTarget = inst.CanTarget
	local old_CanAttack = inst.CanAttack
	local old_DoAttack = inst.DoAttack
	local old_DoAreaAttack = inst.DoAreaAttack
	
	function inst:CanTarget(target)
		if target and self.inst and target:HasTag("epic") and self.inst:HasTag("epic") then
			return false
		end
		return old_CanTarget(self, target)
	end
	
	function inst:CanAttack(target)
		if target and self.inst and target:HasTag("epic") and self.inst:HasTag("epic") then
			return false
		end
		return old_CanAttack(self, target)
	end
	
	function inst:DoAttack(targ, weapon, projectile, stimuli, instancemult)
		if targ and self.inst and targ:HasTag("epic") and self.inst:HasTag("epic") then
			SpawnPrefab("stalker_shield").Transform:SetPosition(targ.Transform:GetWorldPosition())
			return false
		end
		return old_DoAttack(self, targ, weapon, projectile, stimuli, instancemult)
	end
	
	function inst:DoAreaAttack(target, range, weapon, validfn, stimuli, excludetags)
		local hitcount = 0
		local x, y, z = target.Transform:GetWorldPosition()
		local ents = TheSim:FindEntities(x, y, z, range, AREAATTACK_MUST_TAGS, excludetags)
		for i, ent in ipairs(ents) do
			if ent ~= target and ent ~= self.inst and self:IsValidTarget(ent) and  (validfn == nil or validfn(ent, self.inst)) then
				self.inst:PushEvent("onareaattackother", { target = ent, weapon = weapon, stimuli = stimuli })
				if ent:HasTag("epic") and self.inst:HasTag("epic") then
					SpawnPrefab("stalker_shield").Transform:SetPosition(ent.Transform:GetWorldPosition())
				else
					ent.components.combat:GetAttacked(self.inst, self:CalcDamage(ent, weapon, self.areahitdamagepercent), weapon, stimuli)
				end
				hitcount = hitcount + 1
            end
        end
        return hitcount
	end
end

AddComponentPostInit("combat",CombatPostInit)
