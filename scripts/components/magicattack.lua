local MagicAttack = Class(function(self, inst)
    self.inst = inst

    self.herald_spawn_table =
    {
    	self.SpawnNightmares,
    	self.SpawnGhosts,
    	self.SpawnFrogRain,
    	self.SpawnFireRain
	}

end)

function MagicAttack:SpawnRandomInRange(prefab, min_count, max_count, radius, offset_y, inst)
	local objs = {}
	offset_y = offset_y or 0

	local pt = Vector3(inst.Transform:GetWorldPosition())

	local count = math.random(min_count, max_count)

	local function getrandomoffset()
	    local theta = math.random() * 2 * PI
		local offset = FindWalkableOffset(pt, theta, radius, 12, true)
		if offset then
			return pt+offset
		end
	end

	for i=1, count do
		local spawn_pt = getrandomoffset()
		if spawn_pt then
			if offset_y then
				spawn_pt.y = spawn_pt.y + offset_y
			end

			local obj = nil
			if type(prefab) == "table" then
				obj = SpawnPrefab(prefab[math.random(1, #prefab)])
			else
				obj = SpawnPrefab(prefab)
			end

			if obj.Physics then
				obj.Physics:Teleport(spawn_pt:Get())
			else
				obj.Transform:SetPosition(spawn_pt.x, spawn_pt.y, spawn_pt.z)
			end

			if obj.components.combat then
                local START_FACE_DIST = 30
                local player =  GetClosestInstWithTag("player", inst, START_FACE_DIST)
				obj.components.combat:SuggestTarget(player)
			end

			table.insert(objs, obj)
		end
	end

	return objs
end

function MagicAttack:SpawnNightmares(inst)
    self:SpawnRandomInRange({ "nightmarebeak", "crawlingnightmare"}, 1, 2, 10, 0, inst)
end

function MagicAttack:SpawnGhosts(inst)
	self:SpawnRandomInRange("ghost", 4, 6, 10, 0, inst)
end

function MagicAttack:SpawnFrogRain(inst)
	local function cancelrain()
		if self.frograintask then
			self.frograintask:Cancel()
			self.frograintask = nil
		end
	end

	cancelrain()

	local count = 0
	local max = 1

	self.frograintask = self.inst:DoPeriodicTask(0.2, function(inst)
        local objs = self:SpawnRandomInRange("frog", 1, 4, 8, 35, inst)

        for k, v in pairs(objs) do
            v.sg:GoToState("fall")
        end

        count = count + 1
        if count >= max then
            cancelrain()
        end
	end)
end

function MagicAttack:SpawnFireRain(inst)
	local objs = self:SpawnRandomInRange("ts_firerain", 1, 4, 6, 0, inst)

	for k,v in pairs(objs) do
		v.StartStep(v, math.random() * 2)
	end
end

function MagicAttack:HeraldSpawnAttack(inst)
	local fn = self.herald_spawn_table[math.random(1, #self.herald_spawn_table)]
	fn(self, inst)
end

return MagicAttack
