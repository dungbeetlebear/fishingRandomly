local basalt_assets =
{
	Asset("ANIM", "anim/rock_basalt.zip"),
}

local prefabs =
{
    "rocks",
    "goldnugget",
    "flint"
}

SetSharedLootTable( 'basalt',
{
    {'rocks',  0.50},
    {'flint',  0.50},
})

local function OnWork(inst, worker, workleft)
    if workleft <= 0 then
        local pt = inst:GetPosition()
        SpawnPrefab("rock_break_fx").Transform:SetPosition(pt:Get())
        -- inst.components.lootdropper:DropLoot(pt)

        if inst.showCloudFXwhenRemoved then
            local fx = SpawnPrefab("collapse_small")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end

		if not inst.doNotRemoveOnWorkDone then
	        inst:Remove()
		end
    else
        inst.AnimState:PlayAnimation(
            (workleft < TUNING.ROCKS_MINE / 3 and "low") or
            (workleft < TUNING.ROCKS_MINE * 2 / 3 and "med") or
            "full"
        )
    end
end

local function baserock_fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 1)

    inst.MiniMapEntity:SetIcon("rock.png")

    inst:AddTag("boulder")

	inst.AnimState:SetBank("rock_basalt")
	inst.AnimState:SetBuild("rock_basalt")
	inst.AnimState:PlayAnimation("full")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetChanceLootTable('basalt')

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.MINE)
    inst.components.workable:SetWorkLeft(TUNING.ROCKS_MINE)
    inst.components.workable:SetOnWorkCallback(OnWork)

    local color = 0.5 + math.random() * 0.5
    inst.AnimState:SetMultColour(color, color, color, 1)

    inst:AddComponent("inspectable")
    inst.components.inspectable.nameoverride = "ROCK"

    MakeSnowCovered(inst)
    MakeHauntableWork(inst)

    return inst
end

return Prefab("rock_basalt", baserock_fn, basalt_assets, prefabs)
