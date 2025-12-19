function mod.addArtemisBoons()
    game.OverwriteTableKeys(game.TraitData, {
        ElementalExtraCastBoon =
        {
            Name = "ElementalExtraCastBoon",
            IsElementalTrait = true,
            BlockInRunRarify = true,
            BlockMenuRarify = true,
            ExcludeFromRarityCount = true,
            CustomRarityName = "Boon_Infusion",
            CustomRarityColor = Color.BoonPatchElemental,
            InfoBackingAnimation = "BoonSlotUnity",
            UpgradeChoiceBackingAnimation = "BoonSlotUnity",
            Frame = "Unity",
            InheritFrom = {"UnityTrait"},
            Icon = "ReadEmAndWeepMoreElementalBoonsArtemis",
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
                    ChangeValue = 0.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponAnywhereCast",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 0.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastLob",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 0.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastProjectile",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 0.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastArm",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 0.5,
                    ChangeType = "Add",
                },
                {
                    WeaponName = "WeaponCastProjectileHades",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 0.5,
                    ChangeType = "Add",
                }
            },
            StatLines = {
                "ElementalExtraCastStatDisplay1"
            },
        },
    })
    table.insert(game.EnemyData.NPC_Artemis_Field_01.Traits, "ElementalExtraCastBoon")
end

HadesCastFixFile = rom.path.combine(rom.paths.Content(), 'Game/Weapons/PlayerWeapons.sjson')

local HadesCastFixOrder = {
  "Name",
  "InheritFrom",
  "Projectile",
  "ShowFreeAimLine",
  "AimLineAnimation",
  "AutoLock",
  "ManualAiming",
  "IgnoreUnitChargeMultiplier",
  "ActiveProjectileCap",
}

HadesCastFix = {
		Name = "WeaponCastProjectileHades",
		InheritFrom = "WeaponCastProjectile",
		Projectile = "ProjectileCastHades",
		ShowFreeAimLine = true,
		AimLineAnimation = "AuraAimLine",
		AutoLock = true,
		ManualAiming = false,
		IgnoreUnitChargeMultiplier = true,
        ActiveProjectileCap = 1,
	}
sjson.hook(HadesCastFixFile, function(data)
  for _, newWeaponText in ipairs(HadesCastFix) do
    table.insert(data.Texts, sjson.to_object(newWeaponText, HadesCastFixOrder))
  end
end)

mod.addArtemisBoons()