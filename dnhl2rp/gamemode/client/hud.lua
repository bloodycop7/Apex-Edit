
local AdminTell = function() end
function tell(msg)
	local Message = msg:ReadString()

	AdminTell = function()
		draw.RoundedBox(4, 10, 10, ScrW() - 20, 100, Color(0, 0, 0, 200))
		draw.DrawText(DarkRP.getPhrase("listen_up"), "GModToolName", ScrW() / 2 + 10, 10, Color(255, 255, 255, 255), 1)
		draw.DrawText(Message, "ChatFont", ScrW() / 2 + 10, 80, Color(200, 30, 30, 255), 1)
	end

	timer.Simple(10, function()
		AdminTell = function() end
	end)
end

usermessage.Hook("AdminTell", tell)


local function drawstuff()
    local client = LocalPlayer()
	local hp = client:Health()
    local job = client:getDarkRPVar("job") or "None"
    local money = client:getDarkRPVar("money") or 0
	local xp = client:GetNetworkedInt( "Xp" ) or 0
	local money = client:getDarkRPVar("money") or "0"
    local lastBodygroups = {}
    local lastModel = ""
    local lastSkin = ""
    local lastTeam = 99
	local CMB_OVERLAY_COLS = {
		Color(65, 120, 200), -- universal
		Color(75, 155, 45), -- squad
		Color(255, 150, 0), -- command
		Color(210, 55, 50), -- danger
		Color(150, 150, 150) -- respond
	}

    if client:getDarkRPVar("Energy") then
		energy = math.Round(client:getDarkRPVar("Energy")) or 0
	else
		energy = 0
	end
    local mats = {
     --[[1--]]   Material("icon16/user.png"),
      --[[2--]]  Material("icon16/shield.png"),
        --[[3--]]Material("icon16/group.png"),
        --[[4--]]Material("icon16/heart.png"),
        --[[5--]]Material("icon16/money.png"),
        --[[6--]]Material("icon16/hourglass.png"),
        --[[7--]]Material("icon16/exclamation.png"),
        --[[8--]]Material("icon16/group_link.png")
    }

	hl2rp.util = hl2rp.util or {}
    
    
    surface.SetDrawColor(51,51,51,190)
    surface.DrawRect(10, ScrH() - 150, 310, 132)
    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Material("icon16/user.png"))
    surface.DrawTexturedRect(23,ScrH() - 140, 15, 15)
    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(mats[4])
    surface.DrawTexturedRect(23,ScrH() - 120, 15, 15)
    surface.SetMaterial(mats[2])
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(23,ScrH() - 100, 15, 15)
    surface.SetMaterial(mats[6])
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(23,ScrH() - 80, 15, 15)
	surface.SetMaterial(mats[5])
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(23,ScrH() - 60, 15, 15)
	surface.SetMaterial(mats[8])
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(23,ScrH() - 40, 15, 15)
    
    draw.DrawText("".. client:Name(), "Impulse-ChatLarge", 40, ScrH() - 140, team.GetColor(client:Team()))
    draw.DrawText("Health: " .. client:Health(), "Impulse-Elements19", 40, ScrH() - 120, nil)
    draw.DrawText("Armor: " .. client:Armor(), "Impulse-Elements19", 40, ScrH() - 100, nil)
    draw.DrawText("Hunger: " .. energy, "Impulse-Elements19", 40, ScrH() - 80, nil)
	draw.DrawText("Money: " .. money, "Impulse-Elements19", 40, ScrH() - 60, nil)
	draw.DrawText("XP: " .. xp, "Impulse-Elements23", 40,ScrH() - 40, team.GetColor(client:Team()))
 
	if (client:IsCP() and client:Alive()) then
		local add = 0
		local offset = 0
		local medCol = Color(255, 228, 0)
		local pos = LocalPlayer():GetPos()
		local grid = math.Round(pos.x / 100).."/"..math.Round(pos.y / 100)
		draw.SimpleText("<:: BIOZONE GRID: "..grid, "BudgetLabel", ScrW() - 200, 79, CMB_OVERLAY_COLS[3])
		if hp < 51 then
			add = add + 14
			draw.SimpleText("<:: WARNING: LOCAL UNIT REQUIRES VIAL RESTORE! ::>", "BudgetLabel", ScrW() - 8, 160 + add + offset, medCol, TEXT_ALIGN_RIGHT)
		end
		if (GetGlobalBool("civil", true) == true) then
		draw.DrawText("<:: CITY CODE: CIVIL" , "BudgetLabel", ScrW() - 200, 140,CMB_OVERLAY_COLS[2])
		elseif (GetGlobalBool("cu", false) == true) then
			draw.DrawText("City Code: CIVIL UNREST" , "BudgetLabel", ScrW() - 200, 140,CMB_OVERLAY_COLS[3])
		elseif (GetGlobalBool("jw", false) == true) then
			draw.DrawText("City Code: JUDGMENT WAIVER" , "BudgetLabel", ScrW() - 200, 140,CMB_OVERLAY_COLS[4])
		end
		local function DrawLowAmmo(offset)
			draw.SimpleText("<:: WARNING: LOW AMMO COUNT DETECTED ::>", "BudgetLabel", ScrW() - 8, 220 + add + offset, medCol, TEXT_ALIGN_RIGHT)
		end
		local wep = client:GetActiveWeapon()
		if wep and IsValid(wep) then
			local clip = wep:Clip1()
			local maxClip = wep:GetMaxClip1()
	
			if maxClip > 0 and clip < maxClip * 0.2 then
				DrawLowAmmo(offset)
			end
		end
		if hp >= 51 then
			draw.DrawText("<:: LOCAL VIALS: " .. hp, "BudgetLabel", ScrW() - 200, 100, CMB_OVERLAY_COLS[2])
		elseif hp <= 50 then
			draw.DrawText("<:: LOCAL VIALS: " .. hp, "BudgetLabel", ScrW() - 200, 100, CMB_OVERLAY_COLS[3])
		end
		if client:Armor() >= 51 then
			draw.DrawText("<:: LOCAL AP: " .. client:Armor(), "BudgetLabel", ScrW() - 200, 120, CMB_OVERLAY_COLS[2])
		elseif client:Armor() <= 50 then
			draw.DrawText("<:: LOCAL AP: " .. client:Armor(), "BudgetLabel", ScrW() - 200, 120, CMB_OVERLAY_COLS[3])
		end
		if client:Health() <= 25 and (not nextCheck or nextCheck < CurTime()) then

			local ub = math.Clamp(hp, 1, 25)
			local ubi = math.random(1, ub)
	  
			if ubi == ub then
				nextFlicker = CurTime() + math.Rand(0.1, 1)
				surface.PlaySound("ambient/levels/prison/radio_random"..math.random(1,13)..".wav")
			else
				nextCheck = CurTime() + 0.1
				offset = math.random(10, 80)
			end
		end
		local modeNames = {
			[0] = "Grounded",
			[1] = "Grounded",
			[2] = "Pacify",
			[3] = "Active"
		}
		local function DrawBatonStatus(baton, offset)
			
			local mode = baton:GetMode() or 1
			draw.SimpleText("BATON STATUS:\n"..modeNames[mode], "BudgetLabel", ScrW() * 0.52, ScrH() * 0.45 + offset, CMB_OVERLAY_COLS[1])
		end	
		local wep = client:GetActiveWeapon()

        if wep and IsValid(wep) and wep:GetClass() == "ls_stunstick" and client:isWepRaised() == true then
            DrawBatonStatus(wep, offset)
        end	

	end

    function hl2rp.util.getMaterial(materialPath)
		-- Cache the material.
		hl2rp.util.cachedMaterials = hl2rp.util.cachedMaterials or {}
		hl2rp.util.cachedMaterials[materialPath] = hl2rp.util.cachedMaterials[materialPath] or Material(materialPath)
	
		return hl2rp.util.cachedMaterials[materialPath]
	end
	
	function hl2rp.util.drawBlur(panel, amount, passes)
		local blur = hl2rp.util.getMaterial("pp/blurscreen")
		-- Intensity of the blur.
		amount = amount or 5
	
		if (useCheapBlur) then
			surface.SetDrawColor(50, 50, 50, amount * 20)
			surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		else
			surface.SetMaterial(blur)
			surface.SetDrawColor(255, 255, 255)
	
			local x, y = panel:LocalToScreen(0, 0)
	
			for i = -(passes or 0.2), 1, 0.2 do
				-- Do things to the blur material to make it blurry.
				blur:SetFloat("$blur", i * amount)
				blur:Recompute()
	
				-- Draw the blur material over the screen.
				render.UpdateScreenEffectTexture()
				surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
			end
		end
	end
	
	function hl2rp.util.drawBlurAt(x, y, w, h, amount, passes)
		local blur = hl2rp.util.getMaterial("pp/blurscreen")
		-- Intensity of the blur.
		amount = amount or 5
	
		if (useCheapBlur) then
			surface.SetDrawColor(30, 30, 30, amount * 20)
			surface.DrawRect(x, y, w, h)
		else
			surface.SetMaterial(blur)
			surface.SetDrawColor(255, 255, 255)
	
			local scrW, scrH = ScrW(), ScrH()
			local x2, y2 = x / scrW, y / scrH
			local w2, h2 = (x + w) / scrW, (y + h) / scrH
	
			for i = -(passes or 0.2), 1, 0.2 do
				blur:SetFloat("$blur", i * amount)
				blur:Recompute()
	
				render.UpdateScreenEffectTexture()
				surface.DrawTexturedRectUV(x, y, w, h, x2, y2, w2, h2)
			end
		end
	end

end


hook.Add("HUDPaint", "apexhud", function()
	drawstuff()
end)


function box()
    local lp = LocalPlayer()
    local lastBodygroups = {}
    local lastModel = ""
    local lastSkin = ""
    local lastTeam = 99
    local iconLoaded = false
	if lp:Alive() then

		if not IsValid(PlayerIcon) then
			PlayerIcon = vgui.Create("asi")
			PlayerIcon:SetPos(150, ScrH() - 100)
			PlayerIcon:SetSize(64, 64)
			PlayerIcon:SetModel(LocalPlayer():GetModel(), LocalPlayer():GetSkin())

			timer.Simple(0, function()
				if not IsValid(PlayerIcon) then
					return
				end

				local ent = PlayerIcon.Entity

				if IsValid(ent) then
					for v,k in pairs(LocalPlayer():GetBodyGroups()) do
						ent:SetBodygroup(k.id, LocalPlayer():GetBodygroup(k.id))
					end
				end
			end)
		end
		
		local bodygroupChange = false

		if (nextBodygroupChangeCheck or 0) < CurTime() and IsValid(PlayerIcon) then
			local curBodygroups = lp:GetBodyGroups()
			local ent = PlayerIcon.Entity

			for v,k in pairs(lastBodygroups) do
				if not curBodygroups[v] or ent:GetBodygroup(k.id) != LocalPlayer():GetBodygroup(curBodygroups[v].id) then
					bodygroupChange = true
					break
				end
			end

			nextBodygroupChangeCheck = CurTime() + 0.5
		end

		if (lp:GetModel() != lastModel) or (lp:GetSkin() != lastSkin) or bodygroupChange == true or (iconLoaded == false and input.IsKeyDown(KEY_W)) and IsValid(PlayerIcon) then -- input is super hacking fix for SpawnIcon issue
			PlayerIcon:SetModel(lp:GetModel(), lp:GetSkin())
			lastModel = lp:GetModel()
			lastSkin = lp:GetSkin()
			lastTeam = lp:Team()
			lastBodygroups = lp:GetBodyGroups()

			iconLoaded = true
			bodygroupChange = false

			timer.Simple(0, function()
				if not IsValid(PlayerIcon) then
					return
				end

				local ent = PlayerIcon.Entity

				if IsValid(ent) then
					for v,k in pairs(LocalPlayer():GetBodyGroups()) do
						ent:SetBodygroup(k.id, LocalPlayer():GetBodygroup(k.id))
					end
				end
			end)
		end
	end
end

hook.Add("HUDPaint" , "apexbox", box)


