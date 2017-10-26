local models = { "crowbar", "stunstick" }
for _, model in ipairs( models ) do
	CreateClientConVar( "flowbar_" .. model, "1", true, true )
end

local function CapitalizeFirst( str )
	return string.gsub( str, "^%l", string.upper )
end

hook.Add( "DoAnimationEvent", "Flowbar", function( ply )

	local vm = ply:GetViewModel()
	if not IsValid( vm ) then return end

	local found = false
	for _, model in ipairs( models ) do
		local enabled = tobool( ply:GetInfo( "flowbar_" .. model ) )
		if enabled and string.find( vm:GetModel(), model ) then
			found = true
		end
	end
	if not found then return end

	local seq = vm:GetSequence()
	local act = vm:GetSequenceActivity( seq )
	if act == ACT_VM_HITCENTER then
		local miss = vm:SelectWeightedSequence( ACT_VM_MISSCENTER )
		vm:SendViewModelMatchingSequence( miss )
	end

end )

hook.Add( "PopulateToolMenu", "FlowbarSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Player", "Flowbar_Options", "Flowbar", "", "", function( panel )
		panel:ClearControls()
		for _, model in ipairs( models ) do
			panel:CheckBox( CapitalizeFirst( model ), "flowbar_" .. model )
		end
	end )
end )
