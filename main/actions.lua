local AddAction = AddAction
GLOBAL.setfenv(1, GLOBAL)

--HAM Action = Class(function(self, data, priority, instant, rmb, distance, crosseswaterboundary, overrides_direct_walk)
--DST Action = Class(function(self, data, instant, rmb, distance, ghost_valid, ghost_exclusive, canforce, rangecheckfn)

local TS_ACTIONS = {
    SPECIAL_ACTION = Action({},nil, nil, 1.2),
    DIGDUNG = Action({mount_enabled=true}),
    MOUNTDUNG = Action({}),
    STOCK = Action({}),
    FIX = Action({}, nil, nil, 2),
    RANSACK = Action({},nil,nil, 0.5),
    BARK = Action({},nil,nil, 3),
}

for name, ACTION in pairs(TS_ACTIONS) do
    ACTION.id = name
    ACTION.str = "TS_ACTION"
    AddAction(ACTION)
end

ACTIONS.SPECIAL_ACTION.fn = function(act)
	if act.doer.special_action then
		act.doer.special_action(act)
		return true
	end
end

ACTIONS.DIGDUNG.fn = function(act)
	act.target.components.workable:WorkedBy(act.doer, 1)
end

ACTIONS.MOUNTDUNG.fn = function(act)
	act.doer.dung_target:Remove()
    act.doer:AddTag("hasdung")
    act.doer.dung_target = nil
end

ACTIONS.STOCK.fn = function(act)
	if act.target then
		act.target.restock(act.target,true)
		act.doer.changestock = nil
		return true
	end
end

ACTIONS.FIX.fn = function(act)
	if act.target then
		local target = act.target
		local numworks = 1
		target.components.workable:WorkedBy(act.doer, numworks)
	--	return target:fix(act.doer)
	end
end

ACTIONS.BARK.fn = function(act)
	return true
end

ACTIONS.RANSACK.fn = function(act)
	return true
end
