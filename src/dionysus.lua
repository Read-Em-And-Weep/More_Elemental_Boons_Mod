modutil.mod.Path.Wrap("UpdateHeroTraitDictionary", function(base, source, args)
    base(source, args)
    if HeroHasTrait("ImprovedElementalDamageFloorBoon") then
        CurrentRun.Hero.FirstTraitWithPropertyCache.ActivatedDamageFloor = game.TraitData.ImprovedElementalDamageFloorBoon
        CurrentRun.Hero.FirstTraitWithPropertyCache.ActivatedDamageFloor.ActivatedDamageFloor = 75
    elseif HeroHasTrait("ElementalDamageFloorBoon") then
        CurrentRun.Hero.FirstTraitWithPropertyCache.ActivatedDamageFloor = game.TraitData.ElementalDamageFloorBoon
        CurrentRun.Hero.FirstTraitWithPropertyCache.ActivatedDamageFloor.ActivatedDamageFloor = 50
    else
        CurrentRun.Hero.FirstTraitWithPropertyCache.ActivatedDamageFloor = nil
    end
end)

modutil.mod.Path.Wrap("UpgradeAllCommon", function(base, args, origTraitData)
        local sourceTraitData = nil
        local traitDictionary = {}
        local upgradableTraits = {}
        local upgradedTraits = {}
        if args.RarityUpgrade == "Synergy" then
            mod.DionysusImprovement()
            return
        end
        base(args, origTraitData)
        if args.RarityUpgrade == "Epic" then
            local delay = args.PresentationDelay
            mod.DionysusImprovement()
            for i, traitData in ipairs(CurrentRun.Hero.Traits) do
                if AreTraitsIdentical(origTraitData, traitData) then
                    sourceTraitData = CurrentRun.Hero.Traits[i]
                elseif not traitDictionary[traitData.Name] and IsGodTrait(traitData.Name, { ForShop = true }) and TraitData[traitData.Name] and not traitData.BlockInRunRarify and traitData.Rarity == "Rare" then
                    table.insert(upgradableTraits, traitData)
                    traitDictionary[traitData.Name] = true
                end
            end

            while not IsEmpty(upgradableTraits) do
                local traitData = RemoveRandomValue(upgradableTraits)
                if traitData.Name == "BoonDecayBoon" then
                    -- Kludge to make space for BoonDecayBoon's CreditMissingStacks presentation
                    delay = delay + 1.5
                end
                upgradedTraits[traitData.Name] = true
                local numOldTrait = GetTraitCount(CurrentRun.Hero, { TraitData = traitData })
                RemoveTrait(CurrentRun.Hero, traitData.Name, { SkipActivatedTraitUpdate = true, SkipExpire = true })
                local persistentValues = {}
                for i, key in pairs(PersistentTraitKeys) do
                    persistentValues[key] = traitData[key]
                end

                local processedData = GetProcessedTraitData({ Unit = CurrentRun.Hero, StackNum = numOldTrait, TraitName =
                traitData.Name, Rarity = args.RarityUpgrade or "Epic" })
                for i, key in pairs(PersistentTraitKeys) do
                    processedData[key] = persistentValues[key]
                end
                processedData = AddTraitToHero({ TraitData = processedData, SkipActivatedTraitUpdate = true, SkipSetup = true })

                if processedData.OnLevelOrRarityChangeFunctionName then
                    thread(CallFunctionName, processedData.OnLevelOrRarityChangeFunctionName, processedData, traitData, 1)
                end
            end
            sourceTraitData.Rarity = args.RarityUpgrade or "Epic"
            thread(IncreasedTraitRarityPresentation, upgradedTraits, delay)
            if sourceTraitData and args.ActivatedValues then
                for name, data in pairs(args.ActivatedValues) do
                    sourceTraitData[name] = DeepCopyTable(data)
                    if CurrentRun.Hero.HeroTraitValuesCache then
                        CurrentRun.Hero.HeroTraitValuesCache[name] = nil
                    end
                end
            end
            if HeroHasTrait("CommonGlobalDamageBoon") then
                local trait = GetHeroTrait("CommonGlobalDamageBoon")
                if not trait.Activated then
                    CheckActivatedTraits(CurrentRun.Hero, { OnlyCheckTraitName = trait.Name })
                end
            end
        else
        end
    end
)

modutil.mod.Path.Wrap("FireRallyHeal", function(base, attacker, functionArgs, triggerArgs)
if HeroHasTrait("ImprovedElementalRallyBoon") then
    if triggerArgs.ManuallyTriggered then
		return
	end
	local rallyTraitData = GetHeroTrait("ImprovedElementalRallyBoon") 
	if rallyTraitData == nil or not IsGameStateEligible( rallyTraitData, rallyTraitData.ActivationRequirements ) then
		return
	end
	if not triggerArgs or not triggerArgs.DamageAmount or triggerArgs.DamageAmount <= 0 or triggerArgs.PureDamage then
		return
	end
	thread( FireRallyThread, functionArgs, triggerArgs )
else
    base(attacker, functionArgs, triggerArgs)
end
end)


function mod.AddDionysusBoons()
    game.OverwriteTableKeys(game.TraitData, {
        -- Elementals

        -- Hermes, all elements
        ImprovedElementalUnifiedBoon =
        {
            Name = "ImprovedElementalUnifiedBoon",
            IsElementalTrait = true,
            BlockStacking = true,
            BlockInRunRarify = true,
            BlockMenuRarify = true,
            ExcludeFromRarityCount = true,
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            Frame = "Unity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Hermes",
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "HighestBaseElementCount" },
                    Comparison = ">=",
                    Value = 8,
                },
            },
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "HighestBaseElementCount" },
                    Comparison = ">=",
                    Value = 4,
                },
            },
            AddOutgoingDamageModifiers =
            {
                GameStateMultiplier =
                {
                    BaseValue = 1.375,
                    SourceIsMultiplier = true,
                    IdenticalMultiplier =
                    {
                        Value = DuplicateMultiplier,
                    },
                },
                ReportValues =
                {
                    ReportedTotalDamageChange = "GameStateMultiplier",
                }
            },
            StatLines =
            {
                "GlobalDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalDamageChange",
                    ExtractAs = "TooltipTotalDamageBonus",
                    Format = "PercentDelta",
                },
            },
        },

        -- Hera, all elements
        ImprovedElementalRarityUpgradeBoon =
        {
            Name = "ImprovedElementalRarityUpgradeBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Hera",
            BlockStacking = true,
            DescriptionTextSymbolScale = 0.67,
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 1,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 2,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 2,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 2,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 2,
                },
            },
            OnActivationFunction =
            {
                Name = "UpgradeAllCommon",
                Args =
                {
                    PresentationDelay = 1.5,
                    RarityUpgrade = "Epic",
                    ActivatedValues =
                    {
                        RarityBonus =
                        {
                            GodLootOnly = true,
                            Epic = 1,
                        },
                    }
                }
            },
            StatLines =
            {
                "ImprovedElementalRarityStatDisplay",
            },
            ExtractValues =
            {
            }
        },

        -- Hephaestus, Earth
        ImprovedElementalDamageBoon =
        {
            Name = "ImprovedElementalDamageBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Hephaestus",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 2,
                },
            },
            ElementalMultipliers =
            {
                Earth = true,
            },
            RarityLevels =
            {
                Common =
                {
                    Multiplier = 1
                },
            },
            AddOutgoingDamageModifiers =
            {
                ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
                NonExMultiplier =
                {
                    BaseValue = 1.075,
                    SourceIsMultiplier = true,
                    MultipliedByElement = "Earth",
                    IdenticalMultiplier =
                    {
                        Value = DuplicateMultiplier,
                    },
                },
                ReportValues =
                {
                    ReportedTotalDamageChange = "NonExMultiplier",
                }
            },
            -- Display variable only! Match this with the above valid weapon multiplier!
            ReportedDamageChange =
            {
                BaseValue = 1.075,
                SourceIsMultiplier = true,
                IdenticalMultiplier =
                {
                    Value = DuplicateMultiplier,
                },
            },
            StatLines =
            {
                "EarthDamageStatDisplay1",
            },
            TrayStatLines =
            {
                "EarthTotalDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalDamageChange",
                    ExtractAs = "TooltipTotalDamageBonus",
                    SkipAutoExtract = true,
                    Format = "PercentDelta",
                },
                {
                    Key = "ReportedDamageChange",
                    ExtractAs = "TooltipDamageBonus",
                    Format = "PercentDelta",
                },
            },
        },

        -- Ares, Earth
        ImprovedElementalOlympianDamageBoon =
        {
            Name = "ImprovedElementalOlympianDamageBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Ares",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 4,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 8,
                },
            },
            AddOutgoingDamageModifiersArray =
            {
                {
                    ValidProjectiles = WeaponSets.OlympianProjectileNames,
                    ValidWeaponMultiplier = 1.75,
                    RequiredActivatedTraitName = "ImprovedElementalOlympianDamageBoon",
                    ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier" }
                },
                {
                    ValidEffects = WeaponSets.OlympianEffectNames,
                    ValidWeaponMultiplier = 1.75,
                    RequiredActivatedTraitName = "ImprovedElementalOlympianDamageBoon",
                }
            },
            ActivatedMissingEffectDamageIncrease =
            {
                TraitName = "ImprovedElementalOlympianDamageBoon",
                Amount = 0.75,
            },
            StatLines =
            {
                "EarthOlympianDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedMultiplier",
                    ExtractAs = "Multiplier",
                    Format = "PercentDelta",
                },
            }
        },

        -- Hestia, Fire
        ImprovedElementalBaseDamageBoon =
        {
            Name = "ImprovedElementalBaseDamageBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Hestia",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 2,
                },
            },
            ElementalMultipliers =
            {
                Fire = true,
            },
            RarityLevels =
            {
                Common =
                {
                    Multiplier = 1
                },
            },
            AddOutgoingDamageModifiers =
            {
                ValidWeapons = WeaponSets.HeroPrimarySecondaryWeapons,
                ValidBaseDamageAddition =
                {
                    BaseValue = 3,
                    MultipliedByElement = "Fire",
                },
                ReportValues =
                {
                    ReportedTotalDamageChange = "ValidBaseDamageAddition"
                },
            },
            -- Display variable only! Match this with the above valid change value!
            ReportedDamageChange =
            {
                BaseValue = 3,
                IdenticalMultiplier =
                {
                    Value = DuplicateMultiplier,
                },
            },
            StatLines =
            {
                "FireDamageStatDisplay1",
            },
            TrayStatLines =
            {
                "FireTotalDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalDamageChange",
                    ExtractAs = "TooltipTotalDamageBonus",
                    SkipAutoExtract = true,
                },
                {
                    Key = "ReportedDamageChange",
                    ExtractAs = "TooltipDamageBonus",
                },
            },
        },

        -- Apollo, Fire
        ImprovedElementalRallyBoon =
        {
            Name = "ImprovedElementalRallyBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Apollo",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 2,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 3,
                },
            },

            OnSelfDamagedFunction =
            {
                Name = "FireRallyHeal",
                FunctionArgs =
                {
                    Duration = 5,
                    Multiplier = { BaseValue = 0.45 },
                    --[[IdenticalMultiplier =
				{
					Value = DuplicateWeakMultiplier,
				},]]
                    ReportValues = { ReportedMultiplier = "Multiplier", ReportedDuration = "Duration" },
                }
            },
            StatLines =
            {
                "HealOverTimeStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedMultiplier",
                    ExtractAs = "TooltipMultiplier",
                    Format = "Percent",
                    HideSigns = true,
                },
                {
                    Key = "ReportedDuration",
                    ExtractAs = "TooltipDuration",
                    SkipAutoExtract = true
                },
            }
        },

        -- Zeus, Air
        ImprovedElementalDamageFloorBoon =
        {
            Name = "ImprovedElementalDamageFloorBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Zeus",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 3,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 5,
                },
            },
            ActivatedDamageFloor =
            {
                BaseValue = 75,
                AsInt = true,
                IdenticalMultiplier =
                {
                    Value = DuplicateWeakMultiplier,
                },
            },
            StatLines =
            {
                "DamageFloorStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ActivatedDamageFloor",
                    ExtractAs = "TooltipFloor",
                },
            }
        },

        -- Aphrodite, Air
        ImprovedElementalDodgeBoon =
        {
            Name = "ImprovedElementalDodgeBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = {"UnityTrait"},
		Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Aphrodite",
		GameStateRequirements = 
		{
			{
				Path = { "CurrentRun", "Hero", "Elements", "Air" },
				Comparison = ">=",
				Value = 2,
			},
		},
		ElementalMultipliers = 
		{
			Air = true,
		},		
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
		},
		PropertyChanges = 
		{
			{
				LifeProperty = "DodgeChance",
				BaseValue = 0.03,
				ChangeType = "Add",
				MultipliedByElement = "Air",
				DataValue = false,
				ReportValues = 
				{ 
					ReportedTotalDodgeBonus = "ChangeValue",
					ReportedDodgeBonus = "BaseValue",
				},
			},
		},
		StatLines =
		{
			"ElementalDodgeStatDisplay1",
		},
		TrayStatLines = 
		{
			"TotalDodgeChanceStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedTotalDodgeBonus",
				ExtractAs = "TooltipTotalDodgeBonus",
				Format = "Percent",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDodgeBonus",
				ExtractAs = "TooltipDodgeBonus",
				Format = "Percent",
			},
		},
        },

        -- Demeter, Water
        ImprovedElementalDamageCapBoon =
        {
            Name = "ImprovedElementalDamageCapBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Demeter",
            BlockStacking = true,
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 4,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 6,
                },
            },
            ActivatedDamageReductionThreshold = 20,
            ActivatedDamageReduction =
            {
                BaseValue = 15,
                AsInt = true,
                MinValue = -1,
                MinMultiplier = -2,
                IdenticalMultiplier =
                {
                    Value = -1,
                },
            },
            StatLines =
            {
                "DamageCapStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ActivatedDamageReductionThreshold",
                    ExtractAs = "TooltipCap",
                },
                {
                    Key = "ActivatedDamageReduction",
                    ExtractAs = "TooltipReduction",
                    SkipAutoExtract = true
                },
            }
        },

        -- Poseidon, Water
        ImprovedElementalHealthBoon =
        {
            Name = "ImprovedElementalHealthBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Poseidon",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 2,
                },
            },
            ElementalMultipliers =
            {
                Water = true,
            },
            RarityLevels =
            {
                Common =
                {
                    Multiplier = 1
                },
            },
            PropertyChanges =
            {
                {
                    LuaProperty = "MaxHealth",
                    BaseValue = 25,
                    ChangeType = "Add",
                    MaintainDelta = true,
                    MultipliedByElement = "Water",
                    ReportValues =
                    {
                        ReportedTotalHealthBonus = "ChangeValue",
                        ReportedHealthBonus = "BaseValue",
                    },
                },
            },
            StatLines =
            {
                "MaxLifeStatDisplay1",
            },
            TrayStatLines =
            {
                "TotalMaxLifeStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalHealthBonus",
                    ExtractAs = "TooltipTotalHealthBonus",
                    SkipAutoExtract = true,
                },
                {
                    Key = "ReportedHealthBonus",
                    ExtractAs = "TooltipDamageBonus",
                },
            },
        },
        ImprovedElementalFireDominanceBoon =
        {
            Name = "ImprovedElementalFireDominanceBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Fire",
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Fire",
                },
            },
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Fire",
                },
            },
            AddOutgoingDamageModifiers =
            {
                GameStateMultiplier =
                {
                    BaseValue = 1.375,
                    SourceIsMultiplier = true,
                    IdenticalMultiplier =
                    {
                        Value = DuplicateMultiplier,
                    },
                },
                ReportValues =
                {
                    ReportedTotalDamageChange = "GameStateMultiplier",
                }
            },
            StatLines =
            {
                "GlobalDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalDamageChange",
                    ExtractAs = "TooltipTotalDamageBonus",
                    Format = "PercentDelta",
                },
            },
        },
        ImprovedElementalEarthDominanceBoon =
        {
            Name = "ImprovedElementalEarthDominanceBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Earth",
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Earth",
                },
            },
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Earth",
                },
            },
            AddOutgoingDamageModifiers =
            {
                GameStateMultiplier =
                {
                    BaseValue = 1.375,
                    SourceIsMultiplier = true,
                    IdenticalMultiplier =
                    {
                        Value = DuplicateMultiplier,
                    },
                },
                ReportValues =
                {
                    ReportedTotalDamageChange = "GameStateMultiplier",
                }
            },
            StatLines =
            {
                "GlobalDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalDamageChange",
                    ExtractAs = "TooltipTotalDamageBonus",
                    Format = "PercentDelta",
                },
            },
        },
        ImprovedElementalAirDominanceBoon =
        {
            Name = "ImprovedElementalAirDominanceBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Air",
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Air",
                },
            },
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Air",
                },
            },
            AddOutgoingDamageModifiers =
            {
                GameStateMultiplier =
                {
                    BaseValue = 1.375,
                    SourceIsMultiplier = true,
                    IdenticalMultiplier =
                    {
                        Value = DuplicateMultiplier,
                    },
                },
                ReportValues =
                {
                    ReportedTotalDamageChange = "GameStateMultiplier",
                }
            },
            StatLines =
            {
                "GlobalDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalDamageChange",
                    ExtractAs = "TooltipTotalDamageBonus",
                    Format = "PercentDelta",
                },
            },
        },
        ImprovedElementalWaterDominanceBoon =
        {
            Name = "ImprovedElementalWaterDominanceBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Water",
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Water",
                },
            },
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "ExtraElementalBoonsDominantElementByCount" },
                    Comparison = "==",
                    Value = "Water",
                },
            },
            AddOutgoingDamageModifiers =
            {
                GameStateMultiplier =
                {
                    BaseValue = 1.375,
                    SourceIsMultiplier = true,
                    IdenticalMultiplier =
                    {
                        Value = DuplicateMultiplier,
                    },
                },
                ReportValues =
                {
                    ReportedTotalDamageChange = "GameStateMultiplier",
                }
            },
            StatLines =
            {
                "GlobalDamageStatDisplay1",
            },
            ExtractValues =
            {
                {
                    Key = "ReportedTotalDamageChange",
                    ExtractAs = "TooltipTotalDamageBonus",
                    Format = "PercentDelta",
                },
            },
        },
        ImprovedElementalExtraCastBoon =
        {
            Name = "ImprovedElementalExtraCastBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsImproved_Artemis",
            BlockStacking = true,
            DescriptionTextSymbolScale = 0.67,
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 1,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 3,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 3,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 3,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 3,
                },
            },
            ActivatedPropertyChanges = {
                {
                    WeaponName = "WeaponCast",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 1.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponAnywhereCast",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 1.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastLob",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 1.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastProjectile",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 1.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastArm",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 1.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastProjectileHades",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 1.5,
                    ChangeType = "Add",
                }
            },
            StatLines = {
                "ImprovedElementalExtraCastStatDisplay1"
            },
        },
        ElementalImprovementBoon = 
        {
            Name = "ElementalImprovementBoon",
            Frame = "Unity",
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            InheritFrom = { "UnityTrait" },
            Icon = "ReadEmAndWeepMoreElementalBoonsDionysus",
            BlockStacking = true,
            DescriptionTextSymbolScale = 0.67,
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 1,
                },
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 1,
                },
            },
            ActivationRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "HighestBaseElementCount" },
                    Comparison = ">=",
                    Value = 7,
                },
            },
            OnActivationFunction =
            {
                Name = "UpgradeAllCommon",
                Args =
                {
                    PresentationDelay = 1.5,
                    RarityUpgrade = "Synergy",
                    ActivatedValues =
                    {
                        RarityBonus =
                        {
                            GodLootOnly = true,
                            Epic = 1,
                        },
                    }
                }
            },
            StatLines =
            {
                "ElementalImprovementStatDisplay",
            },
            ExtractValues =
            {
            }
        },
    })

    -- adds in the restrictions so you can't get original infusion boons while having improved versions and gives Dionysus the infusion
    table.insert(game.EnemyData.NPC_Dionysus_01.Traits,"ElementalImprovementBoon")
    local originalTraits = { { "ElementalDodgeBoon", "ImprovedElementalDodgeBoon" }, { "ElementalRarityUpgradeBoon", "ImprovedElementalRarityUpgradeBoon" },
        { "ElementalHealthBoon", "ImprovedElementalHealthBoon" }, { "ElementalUnifiedBoon", "ImprovedElementalUnifiedBoon" },
        { "ElementalDamageBoon",     "ImprovedElementalDamageBoon" }, { "ElementalOlympianDamageBoon", "ImprovedElementalOlympianDamageBoon" },
        { "ElementalBaseDamageBoon", "ImprovedElementalBaseDamageBoon" }, { "ElementalRallyBoon", "ImprovedElementalRallyBoon" },
        { "ElementalDamageFloorBoon",   "ImprovedElementalDamageFloorBoon" }, { "ElementalDamageCapBoon", "ImprovedElementalDamageCapBoon" },
        { "ElementalFireDominanceBoon", "ImprovedElementalFireDominanceBoon" }, { "ElementalEarthDominanceBoon", "ImprovedElementalEarthDominanceBoon" },
        { "ElementalAirDominanceBoon", "ImprovedElementalAirDominanceBoon" }, { "ElementalWaterDominanceBoon", "ImprovedElementalWaterDominanceBoon" },
        { "ElementalExtraCastBoon",    "ImprovedElementalExtraCastBoon" } }
        for k, v in pairs(originalTraits) do
            table.insert(game.TraitData[v[1]].GameStateRequirements, {Path = { "CurrentRun", "Hero", "TraitDictionary", }, HasNone = {v[2]},})
        end
end

mod.AddDionysusBoons()

function mod.DionysusImprovement()
    local improveableTraits = { { "ElementalDodgeBoon", "ImprovedElementalDodgeBoon" }, { "ElementalRarityUpgradeBoon", "ImprovedElementalRarityUpgradeBoon" },
        { "ElementalHealthBoon", "ImprovedElementalHealthBoon" }, { "ElementalUnifiedBoon", "ImprovedElementalUnifiedBoon" },
        { "ElementalDamageBoon", "ImprovedElementalDamageBoon" }, { "ElementalOlympianDamageBoon", "ImprovedElementalOlympianDamageBoon" },
        { "ElementalBaseDamageBoon",     "ImprovedElementalBaseDamageBoon" }, { "ElementalRallyBoon", "ImprovedElementalRallyBoon" },
        { "ElementalDamageFloorBoon",   "ImprovedElementalDamageFloorBoon" }, { "ElementalDamageCapBoon", "ImprovedElementalDamageCapBoon" },
        { "ElementalFireDominanceBoon", "ImprovedElementalFireDominanceBoon" }, { "ElementalEarthDominanceBoon", "ImprovedElementalEarthDominanceBoon" },
        { "ElementalAirDominanceBoon", "ImprovedElementalAirDominanceBoon" }, { "ElementalWaterDominanceBoon", "ImprovedElementalWaterDominanceBoon" },
        { "ElementalExtraCastBoon",    "ImprovedElementalExtraCastBoon" } }
    for k, v in pairs(improveableTraits) do
        if (game.HeroHasTrait(v[1])) then
            game.RemoveTrait(game.CurrentRun.Hero, v[1])
            game.AddTrait(game.CurrentRun.Hero, v[2], "Common")
        end
    end
end
