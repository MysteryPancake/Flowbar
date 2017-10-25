CreateClientConVar( "flowbar", "1", true, false )
CreateClientConVar( "flowbar_models", "crowbar stunstick", true, false )
local flowbar = GetConVar( "flowbar" )
local models = GetConVar( "flowbar_models" )

hook.Add( "DoAnimationEvent", "Flowbar", function( ply )

	if not flowbar:GetBool() then return end

	local vm = ply:GetViewModel()
	if not IsValid( vm ) then return end

	local found = false
	for _, model in ipairs( string.Explode( " ", models:GetString() ) ) do
		if string.find( vm:GetModel(), model ) then
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
		panel:CheckBox( "Enabled", "flowbar" )
		panel:TextEntry( "Model List", "flowbar_models" )
	end )
end )
