local newTraitBoonIconsData = {
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Hestia",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Hestia",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Zeus",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Zeus",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Poseidon",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Poseidon",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Hermes",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Hermes",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Hera",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Hera",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Hephaestus",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Hephaestus",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Demeter",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Demeter",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Ares",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Ares",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Apollo",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Apollo",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Aphrodite",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Aphrodite",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsAthena_Fire",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Athena_Fire",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Fire",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Athena_Fire",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsAthena_Earth",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Athena_Earth",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Earth",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Athena_Earth",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsAthena_Air",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Athena_Air",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Air",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Athena_Air",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsAthena_Water",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Athena_Water",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Athena_Water",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Athena_Water",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsImproved_Artemis",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Improved_Artemis",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsArtemis",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Artemis",
        Scale = 1.7
	},
    {
		Name = "ReadEmAndWeepMoreElementalBoonsDionysus",
		InheritFrom = "BoonIcon",
		FilePath = _PLUGIN.guid .. "BoonIcons\\Dionysus",
        Scale = 1.7
	},
}

local boonGUIFile =  rom.path.combine(rom.paths.Content(), "Game\\Animations\\GUI_Boons_VFX.sjson")

local newArtOrder = {
    "Name",
    "InheritFrom",
    "FilePath",
    "Scale",
    "Offset",
}

sjson.hook(boonGUIFile, function(data)
    for _, newBoonArt in ipairs(newTraitBoonIconsData) do
        table.insert(data.Animations, sjson.to_object(newBoonArt, newArtOrder))
    end
end)

modutil.mod.Path.Wrap("SetupMap", function(base)
	local packageName = _PLUGIN.guid .. "BoonIcons"
	game.LoadPackages({ Name = packageName })
	return base()
end)