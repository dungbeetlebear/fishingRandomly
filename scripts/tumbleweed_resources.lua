local tumbleweed_resources_data = require("resources/tumbleweed_resources_list")--导入风滚草资源


TumbleweedResourcesCreate = Class(function(self)

end)

--初始化资源
function TumbleweedResourcesCreate:CreatResources(picker)
	
	--风滚草最基本资源
	local tumbleweed_resources =
	{
	}
	
	--加入主表(子表,倍率,幸运补偿)
	local function insertLoot(lootname,items_multiple,lucky_compensation)
		for k,v in ipairs(lootname) do
			table.insert(tumbleweed_resources, v)
		end
	end
	
	--加入资源
	if tumbleweed_resources_data then
		
			for i, v in pairs(tumbleweed_resources_data) do
				local multiple = v.multiple or 1--资源倍率
				if multiple>0 then
					local temporaryTable = deepcopy(v.resourcesList)
					insertLoot(temporaryTable)
				end
			end
	end	
	return tumbleweed_resources
end

return TumbleweedResourcesCreate