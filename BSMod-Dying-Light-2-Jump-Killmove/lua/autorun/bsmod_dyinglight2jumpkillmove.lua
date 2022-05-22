if SERVER then
	CreateConVar('bsmod_wontairr_dl2_jumpkillmove_chance', 3, FCVAR_ARCHIVE, '', 0, 4)
end

hook.Add("CustomKillMoves", "dyinglight2jumpwontairr", function(ply, target, angleAround)
	
	--Setup some values for custom killmove data
	
	local plyKMModel = nil
	local targetKMModel = nil
	local animName = nil
	local plyKMPosition = nil
	local plyKMAngle = nil
	
	local kmData = {1, 2, 3, 4, 5}
	
	plyKMModel = "models/weapons/c_limbs_dyingwontairr.mdl"
	
	if target:LookupBone("ValveBiped.Bip01_Spine") and !ply:OnGround() and (angleAround > 135 and angleAround <= 225) and math.random(1,4) <= GetConVar('bsmod_wontairr_dl2_jumpkillmove_chance'):GetFloat() then --Check if the Target is a Zombie and that the Player is on the ground
		
		targetKMModel = "models/bsmodimations_dyinglight.mdl" --Set the Targets killmove model 
		
		if target:GetClass() == "npc_combine_s" then
			animName = "dyinglight2jumpbighead"
		else
			animName = "dyinglight2jump" 
		end
	end
		
	if animName == "dyinglight2jump" then
		plyKMPosition = target:GetPos() + (-target:GetForward() * 20 )  
	elseif animName == "dyinglight2jumpbighead" then
		plyKMPosition = target:GetPos() + (-target:GetForward() * 20 ) 
	end
	
	kmData[1] = plyKMModel
	kmData[2] = targetKMModel
	kmData[3] = animName
	kmData[4] = plyKMPosition
	kmData[5] = plyKMAngle
	
	if animName != nil then return kmData end 

end)

hook.Add("CustomKMEffects", "dyinglight2jumpwontairr", function(ply, animName, targetModel) 
	local targetHeadBone = nil
		
	if IsValid (targetModel) then targetHeadBone = targetModel:GetHeadBone() end
	
	if animName == "dyinglight2jump" or animName == "dyinglight2jumpbighead" then --Check the killmove animation names
		
		--Set a timer for effects, you can add more timers for more sounds
		timer.Simple(0.01 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			PlayRandomSound(ply, 6 --[[min]], 8 --[[max]], "playerw/body_impact_0" --[[path to the sound]])
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				
				--You can also specify which bone you want the effect to be positioned to
				--effectdata:SetOrigin(targetModel:GetBonePosition(targetModel:LookupBone("ValveBiped.Bip01_Spine")))
				
				util.Effect("nothing", effectdata)	
			end
		end)
		
		timer.Simple(0.25 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			PlayRandomSound(ply, 5 --[[min]], 5 --[[max]], "player/killmove/km_hit" --[[path to the sound]])
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
			end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			PlayRandomSound(ply, 1 --[[min]], 1 --[[max]], "playerw/goresound0" --[[path to the sound]])
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
							end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)							end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)							end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)							end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)							end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
											end
		end)
		
		timer.Simple(0.85 --[[delay]], function()
			if !IsValid(targetModel) then return end --Check if the Target still exists to avoid script errors
			
			--This function will play random sounds. for example: here are 2 sound files killmovesound1 and killmovesound2, using this function with min being 1 and max being 2, it will choose a random one of those between that range to play.
			
			
			if targetHeadBone != nil then
				
				--This will emit a blood effect at the target's head bone
				
				local effectdata = EffectData()
				effectdata:SetOrigin(targetModel:GetBonePosition(targetHeadBone))
				util.Effect("BloodImpact", effectdata)
			end
		end)
	end
end)
