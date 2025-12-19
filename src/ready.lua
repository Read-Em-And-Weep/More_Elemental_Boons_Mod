local order = {
  "Id",
  "InheritFrom",
  "DisplayName",
  "Description"
}

local newData = {
    {
        Id = "ElementalFireDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Strategic Flare",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.AllElementsBoonHack}, than {!Icons.WaterNoTooltip}, {!Icons.EarthNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.AirNoTooltip}, you deal more damage.",
    },
    {
        Id = "ElementalEarthDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Strategic Quake",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.EarthNoTooltip}, than {!Icons.AllElementsBoonHack}, {!Icons.WaterNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.AirNoTooltip}, you deal more damage.",
    },
    {
        Id = "ElementalAirDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Strategic Gale",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.AirNoTooltip}, than {!Icons.AllElementsBoonHack}, {!Icons.WaterNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.EarthNoTooltip}, you deal more damage.",
    },
    {
        Id = "ElementalWaterDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Strategic Flood",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.WaterNoTooltip}, than {!Icons.AllElementsBoonHack}, {!Icons.EarthNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.AirNoTooltip}, you deal more damage.",
    },
    {
        Id = "ElementalExtraCastBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Loaded Quiver",
        Description = "While you have at least {$TraitData.ElementalExtraCastBoon.ActivationRequirements.1.Value}{$Keywords.AllElementsWithCount}, gain an {#ItalicFormat}additional {#Prev} use of your {$Keywords.CastSet}.",
    },
    {
      Id = "ElementalExtraCastStatDisplay1",
      InheritFrom = "BaseStatLine",
      DisplayName = "{!Icons.Bullet}{#PropertyFormat}Additional Casts Gained:",
      Description = "{#UpgradeFormat}+1",
    },
    {
        Id = "ImprovedElementalFireDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Dominant Flare",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.AllElementsBoonHack}, than {!Icons.WaterNoTooltip}, {!Icons.EarthNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.AirNoTooltip}, you deal more damage.",
    },
    {
        Id = "ImprovedElementalEarthDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Dominant Quake",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.EarthNoTooltip}, than {!Icons.AllElementsBoonHack}, {!Icons.WaterNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.AirNoTooltip}, you deal more damage.",
    },
    {
        Id = "ImprovedElementalAirDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Dominant Gale",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.AirNoTooltip}, than {!Icons.AllElementsBoonHack}, {!Icons.WaterNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.EarthNoTooltip}, you deal more damage.",
    },
    {
        Id = "ImprovedElementalWaterDominanceBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Domiant Flood",
        Description = "While you have {#BoldFormatGraft}more {#Prev}{!Icons.WaterNoTooltip}, than {!Icons.AllElementsBoonHack}, {!Icons.EarthNoTooltip}, {#ItalicFormat}and {#Prev}{!Icons.AirNoTooltip}, you deal more damage.",
    },
    {
        Id = "ImprovedElementalExtraCastBoon",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Bursting Quiver",
        Description = "While you have at least {$TraitData.ElementalExtraCastBoon.ActivationRequirements.1.Value}{$Keywords.AllElementsWithCount}, gain an {#ItalicFormat}additional {#Prev} use of your {$Keywords.CastSet}.",
    },
    {
      Id = "ImprovedElementalExtraCastStatDisplay1",
      InheritFrom = "BaseStatLine",
      DisplayName = "{!Icons.Bullet}{#PropertyFormat}Additional Casts Gained:",
      Description = "{#UpgradeFormat}+2",
    },
    {
      Id = "ImprovedElementalDamageFloorBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Air Purity",
      Description = "While you have at least {$TraitData.ElementalDamageFloorBoon.ActivationRequirements.1.Value}{!Icons.CurseAir}, you can never deal less damage than the limit.",
    },
    {
      Id = "ImprovedElementalRarityUpgradeBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Royal Upbringing",
      Description = "While you have at least {$TraitData.ElementalRarityUpgradeBoon.ActivationRequirements.1.Value}{$Keywords.AllElementsWithCount}, your {$Keywords.GodBoonPluralNoTooltip} gain {$Keywords.Rarity}."
    },
    {
      Id = "ImprovedElementalRarityStatDisplay",
      InheritFrom = "BaseStatLine",
      DisplayName = "{!Icons.Bullet}{#PropertyFormat}Rarity Gained:",
      Description = "{#EpicFormat}Epic",
    },
    {
      Id = "ImprovedElementalHealthBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Flooded Fitness",
      Description = "Gain {!Icons.HealthUp} for each {!Icons.CurseWater} you have.",
    },
    {
      Id = "ImprovedElementalRallyBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Self Resurrection",
      Description = "While you have at least {$TraitData.ElementalRallyBoon.ActivationRequirements.1.Value}{!Icons.CurseFire}, whenever you take damage, restore some {!Icons.Health}.",
    },
    {
      Id = "ImprovedElementalDodgeBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Windy Wiles",
      Description = "Gain a chance to {$Keywords.Dodge} for each {!Icons.CurseAir} you have.",
    },
    {
      Id = "ImprovedElementalDamageCapBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Arctic Veneer",
      Description = "While you have at least {$TraitData.ElementalDamageCapBoon.ActivationRequirements.1.Value}{!Icons.CurseWater}, whenever you would take at least {$TraitData.ElementalDamageCapBoon.ActivatedDamageReductionThreshold} damage, take less.",
    },
    {
      Id = "ImprovedElementalBaseDamageBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Deep Cooker",
      Description = "Your {$Keywords.AttackSet} and {$Keywords.SpecialSet} gain {$Keywords.BaseDamage} the more {!Icons.CurseFire} you have.",
    },
    {
      Id = "ImprovedElementalDamageBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Militant Art",
      Description = "Your {$Keywords.Attack} and {$Keywords.Special} deal more damage for each {!Icons.CurseEarth} you have.",
    },
    {
      Id = "ImprovedElementalOlympianDamageBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Rallying Shriek",
      Description = "While you have at least {$TraitData.ElementalOlympianDamageBoon.ActivationRequirements.1.Value}{!Icons.CurseEarth}, any of your damaging effects from Olympians are stronger.",
    },
    {
      Id = "ImprovedElementalUnifiedBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Taller Order",
      Description = "While you have at least {#BoldFormatGraft}{$TraitData.ElementalUnifiedBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.EarthNoTooltip}, {#BoldFormatGraft}{$TraitData.ElementalUnifiedBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.WaterNoTooltip}, {#BoldFormatGraft}{$TraitData.ElementalUnifiedBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.AirNoTooltip}, {#ItalicFormat}or {#Prev}{#BoldFormatGraft}{$TraitData.ElementalUnifiedBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.AllElementsBoonHack}, you deal more damage.",
    },
    {
      Id = "ElementalImprovementBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Exclusive Vintage",
      Description = "While you have at least {#BoldFormatGraft}{$TraitData.ElementalImprovementBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.EarthNoTooltip}, {#BoldFormatGraft}{$TraitData.ElementalImprovementBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.WaterNoTooltip}, {#BoldFormatGraft}{$TraitData.ElementalImprovementBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.AirNoTooltip}, {#ItalicFormat}or {#Prev}{#BoldFormatGraft}{$TraitData.ElementalImprovementBoon.ActivationRequirements.[1].Value}{#Prev}{!Icons.AllElementsBoonHack}, your {#BoldFormatGraft} current Olympian {#Prev} {#ElementalFormat} Infusion {#Prev} {$Keywords.GodBoonPluralNoTooltip} have greater potency.",
    },
    {
      Id = "ElementalImprovementStatDisplay",
      InheritFrom = "BaseStatLine",
      DisplayName = "{!Icons.Bullet}{#PropertyFormat}Increased Olympian {#ElementalFormat} Infusion {#Prev} Potency:",
      Description = "{#UpgradeFormat}+50%",
    },
     {
      Id = "ElementalExtraSummonsBoon",
      InheritFrom = "BaseBoonMultiline",
      DisplayName = "Loyalty of the Dead",
      Description = "For every {$Keywords.AllElementsWithCount} you have more than {#BoldFormatGraft}{$TraitData.ElementalExtraSummonsBoon.ActivationRequirements.[1].Value} {#Prev} of, revive a killed enemy as a servant to aid you.",
    },
    {
      Id = "ElementalExtraSummonStatDisplay",
      InheritFrom = "BaseStatLine",
      DisplayName = "{!Icons.Bullet}{#PropertyFormat}Servants raised per {!Icons.EarthNoTooltip}{!Icons.WaterNoTooltip}{!Icons.AirNoTooltip}{!Icons.FireNoTooltip} above {#BoldFormatGraft}{$TraitData.ElementalExtraSummonsBoon.ActivationRequirements.[1].Value}{#Prev}:",
      Description = "{#UpgradeFormat}+1",
    },
}

local traitTextFile = rom.path.combine(rom.paths.Content(), 'Game/Text/en/TraitText.en.sjson')


sjson.hook(traitTextFile, function(data)
  for _, newTraitText in ipairs(newData) do
    table.insert(data.Texts, sjson.to_object(newTraitText, order))
  end
end)

for enemyName, enemyData in pairs( EnemyData ) do
		enemyData.Name = enemyName
		ProcessDataInheritance( enemyData, EnemyData )
		if enemyData.TreatAsGodLootByShops and not IsEmpty( enemyData.Traits ) then
			FieldLootData[enemyData.Name] = 
				{ 
					Name = enemyData.Name,
					TraitIndex = ToLookup(enemyData.Traits),
					TreatAsGodLootByShops = enemyData.TreatAsGodLootByShops,
					IgnoreRestrictBoonChoices = enemyData.IgnoreRestrictBoonChoices,
					ExcludeFromLastRunBoon = enemyData.ExcludeFromLastRunBoon,
					GodLoot = enemyData.GodLoot,
				}
		end

		if enemyData.Traits ~= nil then
			ScreenData.BoonInfo.TraitDictionary[enemyData.Name] = {}
			for i, traitName in pairs( enemyData.Traits ) do
				ScreenData.BoonInfo.TraitDictionary[enemyData.Name][traitName] = true
			end
			ScreenData.BoonInfo.TraitSortOrder[enemyData.Name] = {}
			ScreenData.BoonInfo.TraitSortOrder[enemyData.Name] = ConcatTableValuesIPairs( ScreenData.BoonInfo.TraitSortOrder[enemyData.Name], enemyData.Traits )
		end

	end

  