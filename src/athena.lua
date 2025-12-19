function mod.addAthenaBoons()
    game.OverwriteTableKeys(game.TraitData, {
        ElementalFireDominanceBoon =
        {
            Name = "ElementalFireDominanceBoon",
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
            InheritFrom = {"UnityTrait"},
            Icon = "ReadEmAndWeepMoreElementalBoonsAthena_Fire",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Fire" },
                    Comparison = ">=",
                    Value = 5,
                },
            },
            ActivationRequirements =
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
                    BaseValue = 1.25,
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
        ElementalEarthDominanceBoon =
        {
            Name = "ElementalEarthDominanceBoon",
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
            InheritFrom = {"UnityTrait"},
            Icon = "ReadEmAndWeepMoreElementalBoonsAthena_Earth",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Earth" },
                    Comparison = ">=",
                    Value = 5,
                },
            },
            ActivationRequirements =
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
                    BaseValue = 1.25,
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
        ElementalAirDominanceBoon =
        {
            Name = "ElementalAirDominanceBoon",
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
            InheritFrom = {"UnityTrait"},
            Icon = "ReadEmAndWeepMoreElementalBoonsAthena_Air",
            GameStateRequirements =
            {
               {
                    Path = { "CurrentRun", "Hero", "Elements", "Air" },
                    Comparison = ">=",
                    Value = 5,
                },
            },
            ActivationRequirements =
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
                    BaseValue = 1.25,
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
        ElementalWaterDominanceBoon =
        {
            Name = "ElementalWaterDominanceBoon",
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
            InheritFrom = {"UnityTrait"},
            Icon = "ReadEmAndWeepMoreElementalBoonsAthena_Water",
            GameStateRequirements =
            {
                {
                    Path = { "CurrentRun", "Hero", "Elements", "Water" },
                    Comparison = ">=",
                    Value = 5,
                },
            },           
            ActivationRequirements =
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
                    BaseValue = 1.25,
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
    })
    table.insert(game.EnemyData.NPC_Athena_01.Traits, "ElementalFireDominanceBoon")
    table.insert(game.EnemyData.NPC_Athena_01.Traits, "ElementalWaterDominanceBoon")
    table.insert(game.EnemyData.NPC_Athena_01.Traits, "ElementalEarthDominanceBoon")
    table.insert(game.EnemyData.NPC_Athena_01.Traits, "ElementalAirDominanceBoon")
end

mod.addAthenaBoons()

modutil.mod.Path.Wrap("UpdateHeroTraitDictionary", function(base, source, args)
    base(source, args)
    CurrentRun.Hero.ExtraElementalBoonsDominantElementByCount = nil
    CurrentElementHighestCount = 0
    for element, count in pairs(CurrentRun.Hero.Elements) do
        if count == CurrentElementHighestCount then
            CurrentRun.Hero.ExtraElementalBoonsDominantElementByCount = nil
        elseif count > CurrentElementHighestCount then
            CurrentRun.Hero.ExtraElementalBoonsDominantElementByCount = element
            CurrentElementHighestCount = count
        end
    end
end)