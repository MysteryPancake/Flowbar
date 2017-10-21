hook.Add( "DoAnimationEvent", "Flowbar", function( ply )

	local vm = ply:GetViewModel()
	if not string.find( vm:GetModel(), "crowbar" ) then return end

	local seq = vm:GetSequence()
	local act = vm:GetSequenceActivity( seq )

	if act == ACT_VM_HITCENTER then
		local miss = vm:SelectWeightedSequence( ACT_VM_MISSCENTER )
		vm:SendViewModelMatchingSequence( miss )
	end

end )
