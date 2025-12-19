function mod.AddHadesBoons()
    game.OverwriteTableKeys(game.TraitData, {
        ElementalExtraSummonsBoon =
        {
            Name = "ElementalExtraSummonsBoon",
            IsElementalTrait = true,
            BlockInRunRarify = true,
            BlockMenuRarify = true,
            ExcludeFromRarityCount = true,
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            Frame = "Unity",
            InheritFrom = { "UnityTrait" },
            Icon = "Boon_Hades_08",
            BlockStacking = true,
            DescriptionTextSymbolScale = 0.67,
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "HighestBaseElementCount" },
                    Comparison = ">=",
                    Value = 6,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "HighestBaseElementCount" },
                    Comparison = ">=",
                    Value = 8,
                },
            },
            OnEnemyDeathFunction = {
                Name = "RaiseKilledEnemy",
                FunctionArgs = {
                    Origin = "HadesElemental",
                    DamageMultiplier = 1,
                    PlayerMultiplier = 0.1,
                    ReportValues =
                    {
                        ReportedDamageBonus = "DamageMultiplier",
                    },
                }
            },
            StatLines =
            {
                "ElementalExtraSummonStatDisplay",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedDamageBonus",
                    ExtractAs = "DamageBonus",
                    Format = "PercentDelta",
                },
            },
        }
    })
    table.insert(game.EnemyData.NPC_Hades_Field_01.Traits, "ElementalExtraSummonsBoon")
end

mod.AddHadesBoons()

local HadesRaiseDeadFixFile = rom.path.combine(rom.paths.Content(), 'Game/Text/en/HelpText.en.sjson')

local HadesRaiseDeadFixOrder = {
  "Id",
  "DisplayName",
}

local HadesRaiseDeadFix = {
    {
		Id = "HadesRaiseDeadActivated",
        DisplayName = "{#CombatTextHighlightFormat}Loyalty of the Dead{#Prev}!"
    }
	}

sjson.hook(HadesRaiseDeadFixFile, function(data)
  for _, newText in ipairs(HadesRaiseDeadFix) do
    table.insert(data.Texts, sjson.to_object(newText, HadesRaiseDeadFixOrder))
  end
end)

function mod.HadesRaiseKilledEnemy(enemy, args)
    if (HeroHasTrait("RaiseDeadBoon") and not (MapState.RaiseDeadCount)) then
        return
    end
    MapState.HadesRaiseDeadCount = MapState.HadesRaiseDeadCount or 0
    
    EligibleDeadtoRaise = 0
    for element, count in pairs(CurrentRun.Hero.Elements) do
        if count >= 8 then
            EligibleDeadtoRaise = EligibleDeadtoRaise + 1
        end
    end


    if MapState.HadesRaiseDeadCount >= EligibleDeadtoRaise then
        return
    end

    local enemyName = enemy.Name
	local enemyData = EnemyData[enemyName]
	if enemyData and (( not enemyData.IsBoss and not enemyData.BlockRaiseDead ) or enemyData.ForceAllowRaiseDead ) then
		IncrementTableValue(MapState, "HadesRaiseDeadCount")
		local tempObstacle = SpawnObstacle({ Name = "BlankObstacle", DestinationId = enemy.ObjectId })
		local summonArgs = ShallowCopyTable( WeaponData.WeaponSpellSummon.SummonMultipliers )
		if args.DamageMultiplier then
			summonArgs.DamageMultiplier = args.DamageMultiplier
		end
		summonArgs.SpawnPointId = tempObstacle
		local newEnemy = CreateAlliedEnemy( enemyName, summonArgs)
		DestroyOnDelay({ tempObstacle }, 0.1)
		CurrentRun.CurrentRoom.DestroyAssistUnitOnEncounterEndId = newEnemy.ObjectId
		CurrentRun.CurrentRoom.AssistUnitName = enemyName
		mod.RaiseDeadPresentationHades(newEnemy) 

		if CurrentRun.CurrentRoom.Encounter ~= nil and CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap ~= nil then
			local activeCapWeight = newEnemy.ActiveCapWeight or 1
			CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap = math.min(ConstantsData.MaxActiveEnemyCount, CurrentRun.CurrentRoom.Encounter.ActiveEnemyCap + activeCapWeight)
		end
	end

end

function mod.RaiseDeadPresentationHades(newEnemy)
    PlaySound({ Name = newEnemy.IsAggroedSound, Id = newEnemy.ObjectId })
	thread( InCombatText, newEnemy.ObjectId, "HadesRaiseDeadActivated", 1.2, { PreDelay = 0.25, ShadowScaleX = 1.0, SkipFlash = true })
end


modutil.mod.Path.Wrap("RaiseKilledEnemy", function(base, enemy,args)
    if args.Origin then
        if args.Origin == "HadesElemental" then
            mod.HadesRaiseKilledEnemy(enemy,args)
        end
    else
        base(enemy,args)
    end
end)