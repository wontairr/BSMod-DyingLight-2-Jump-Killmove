
--This adds to a list of entities that can be killmovable (highlighted blue) when taking damage
--ValveBipeds by default are on this list so use this only for entities with different bone structures such as headcrabs

--Make sure the entity you're checking for in the killmove function below is added to this list, you can add as many as you want

timer.Simple(0, function()
	if killMovableEnts then
		
		--These are commented out because we won't be using them in this example, feel free to uncomment them if you want to add more non ValveBiped npcs to be killmovable
		
		--[[if !table.HasValue(killMovableEnts, "npc_strider") then
			table.insert( killMovableEnts, "npc_strider" )
		end
		if !table.HasValue(killMovableEnts, "npc_headcrab") then
			table.insert( killMovableEnts, "npc_headcrab" )
		end]]
	end
end)

--This is the hook for custom killmoves

--IMPORTANT: Make sure to change the UniqueName to something else to avoid conflicts with other custom killmove addons
hook.Add("CustomKillMoves", "dyinglight2jumpwontairr", function(ply, target, angleAround)
	
	--Setup some values for custom killmove data
	
	local plyKMModel = nil
	local targetKMModel = nil
	local animName = nil
	local plyKMPosition = nil
	local plyKMAngle = nil
	
	local kmData = {1, 2, 3, 4, 5} --We'll use this at the end of the hook
	
	plyKMModel = "models/weapons/c_limbs_dyingwontairr.mdl" --We set the Players killmove model to the custom one that has the animations
	
	--Use these checks for angle specific killmoves, make sure to keep the brackets when using them
	if (angleAround <= 45 or angleAround > 315) then
		--print("in front of target")
	elseif (angleAround > 45 and angleAround <= 135) then
		--print("left of target")
	elseif (angleAround > 135 and angleAround <= 225) then
		--print("behind target")
	elseif (angleAround > 225 and angleAround <= 315) then
		--print("right of target")
	end
	
	--For this example we'll add some custom Zombie killmoves
	
	if target:LookupBone("ValveBiped.Bip01_Spine") and !ply:OnGround() and (angleAround > 135 and angleAround <= 225) then --Check if the Target is a Zombie and that the Player is on the ground
		
		targetKMModel = "models/bsmodimations_dyinglight.mdl" --Set the Targets killmove model 
		
		if target:GetClass() == "npc_combine_s" then
			animName = "dyinglight2jumpbighead" --Set the name of the animation that will play for both the Player and Target model
		else
			animName = "dyinglight2jump" --Set the name of the animation that will play for both the Player and Target model
		end
	end
	
	--Positioning the player for different killmove animations
		
	if animName == "dyinglight2jump" then
		plyKMPosition = target:GetPos() + (-target:GetForward() * 20 )  --Position the player in front of the Target and x distance away
	elseif animName == "dyinglight2jumpbighead" then
		plyKMPosition = target:GetPos() + (-target:GetForward() * 20 )  --Position the player in front of the Target and x distance away
	end
	
	--IMPORTANT: Make sure not to duplicate the rest of the code below, it isn't nessecary and can cause issues, just keep them at the bottom of this function
	kmData[1] = plyKMModel
	kmData[2] = targetKMModel
	kmData[3] = animName
	kmData[4] = plyKMPosition
	kmData[5] = plyKMAngle
	
	if animName != nil then return kmData end --Send the killmove data to the main addons killmove check function

end)
--This is the hook for custom killmove effects and sounds (Other particles include: blood_advisor_puncture_withdraw, blood_advisor_pierce_spray_c, and blood_advisor_pierce_spray_b) 	{ event AE_CL_CREATE_PARTICLE_EFFECT 23 "blood_advisor_puncture follow_attachment anim_attachment_head" }	{ event AE_CL_STOP_PARTICLE_EFFECT 30 "blood_advisor_puncture 1" }	

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