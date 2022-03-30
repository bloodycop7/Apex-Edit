hook.Add("HUDPaint", "staff", function()
	local ply = LocalPlayer()
	if (ply:IsAdmin() and ply:Alive() and ply:GetMoveType() == MOVETYPE_NOCLIP and !ply:InVehicle()) then
		for k, v in pairs(player.GetAll()) do
			if (v != client) then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText(v:Name(), "Impulse-Elements19", x,y, team.GetColor(v:Team()), TEXT_ALIGN_CENTER)
			end
		end

		for k, v in pairs(ents.GetAll()) do
			if v:GetClass():match("gunpowder") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("Gunpowder", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			elseif v:GetClass():match("iron") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("Metal Plate", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			elseif v:GetClass():match("wood") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("Piece of Wood", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			elseif v:GetClass():match("cp_npc") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("CP Ranking Officer", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			elseif v:GetClass():match("ow_npc") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("OTA Ranking Officer", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			elseif v:GetClass():match("ammo") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("Ammo Crate", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			elseif v:GetClass():match("health") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("Health Charger", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			elseif v:GetClass():match("armor") then
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("Armor Charger", "Impulse-Elements19", x,y, nil, TEXT_ALIGN_CENTER)
			end
		end


		rebelcount = 0 or "NONE"
		IsRebel = false
		function GAMEMODE:DrawPhysgunBeam(ply, physgun, enabled, target, bone, hitPos)
			if (ply:GetMoveType() == MOVETYPE_NOCLIP) then
				return false
			else
				return true
			end
		end
	
		function GAMEMODE:PrePlayerDraw(ply)
			if (ply:GetMoveType() == MOVETYPE_NOCLIP and !ply:InVehicle()) then
				return true
			else
				return false
			end
		end

		

		for k, v in pairs(player.GetAll()) do
			if v:GetModel():match("group03") and v:Alive() then
				rebelcount = rebelcount + 1
				IsRebel = true
				local pos = v:LocalToWorld(v:OBBCenter()):ToScreen()
				local x, y = pos.x, pos.y

				draw.DrawText("Rebel", "Impulse-Elements19", x,y, Color(119,46,46), TEXT_ALIGN_CENTER)
			end
		end


		surface.SetDrawColor(80,44,44, 190)
		surface.DrawRect(0,0,200,300)
		draw.DrawText("Players online: " .. #player.GetAll(), "Impulse-Elements18",0,0,Color(255,255,255))
		draw.DrawText("City Code:", "Impulse-Elements18",0,20,nil)
		if GetGlobalBool("civil", true) == true then
			draw.DrawText("CIVIL", "Impulse-Elements18",75,20,Color(51,255,0))
		elseif GetGlobalBool("cu", false) == true then
			draw.DrawText("CIVIL UNREST", "Impulse-Elements18",75,20,Color(255,157,0))
		elseif GetGlobalBool("jw", false) == true then
			draw.DrawText("JUDGMENT WAIVER", "Impulse-Elements18",75,20,Color(255,0,0))
		end
		draw.DrawText("Rebels: " .. rebelcount, "Impulse-Elements18",0,40,Color(255,255,255))
		draw.DrawText("Citizens + CWU: " .. #team.GetPlayers(TEAM_CITIZEN)+#team.GetPlayers(TEAM_CWU), "Impulse-Elements18",0,80,Color(255,255,255))
		draw.DrawText("Combine: " .. #team.GetPlayers(TEAM_CP)+#team.GetPlayers(TEAM_OVERWATCH), "Impulse-Elements18",0,60,Color(255,255,255))
	end
end)