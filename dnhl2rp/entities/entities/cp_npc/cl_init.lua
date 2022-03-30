include('shared.lua') -- At this point the contents of shared.lua are ran on the client only.

local lc = LocalPlayer()

function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
		hook.Add("PreDrawHalos", "Halo", function()
			if LocalPlayer():Team() == TEAM_CP then
				halo.Add({ self }, Color(255, 0, 0), 0, 0, 10)
			end
		end)
	end
end

function NPCShopMenu()

	-- Small derma panel just for the example.
		CPMenu = vgui.Create("DFrame")
		CPMenu:SetSkin(GAMEMODE.Config.DarkRPSkin)
		CPMenu:SetSize(720, 670)
		CPMenu:Center()
		CPMenu:SetVisible( true )
		CPMenu:MakePopup()
		CPMenu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 36,31,31, 200) )
			draw.RoundedBox( 0, 0, 0, w, 25, Color(41, 35, 35, 190) ) -- Draw a red box instead of the frame



			draw.RoundedBox( 0, 20, 390, 350, 20, Color( 37,33,33, 220)) -- RANK

			draw.RoundedBox( 0, 20, 117, 350, 20, Color( 47,43,43, 220)) --DIVISION


		end
		CPMenu:SetTitle("Civil Protection")

		Rank = ""
		Division = ""

		RankLabel = vgui.Create( "DLabel", CPMenu )
			RankLabel:SetPos( 25, 420 )
		if not RankLabel:GetText() or RankLabel:GetText("Label") then
			RankLabel:SetText("")
		end
			RankLabel:SetSize(250, 360)
			RankLabel:SizeToContents()


		DivisionLabel = vgui.Create( "DLabel", CPMenu )
			DivisionLabel:SetPos( 20, 179 )
		if not DivisionLabel:GetText() or DivisionLabel:GetText("Label") then
			DivisionLabel:SetText("")
		end
			DivisionLabel:SetSize(250, 360)
			DivisionLabel:SizeToContents()

--Division Block XP Requirement

		DivisionXPLabel = vgui.Create( "DLabel", CPMenu )
			DivisionXPLabel:SetPos( 20, 360 )
		if not DivisionXPLabel:GetText() or DivisionXPLabel:GetText("Label") then
			DivisionXPLabel:SetText("XP Requirement: ")
		end
			DivisionXPLabel:SizeToContents()

--Rank XP Requirement Corner
		RankXPLabel = vgui.Create( "DLabel", CPMenu )
			RankXPLabel:SetPos( 25, 620 )
		if not RankXPLabel:GetText() or RankXPLabel:GetText("Label") then
			RankXPLabel:SetText("XP Requirement: ")
		end
			RankXPLabel:SizeToContents()

		local DRankBox = vgui.Create( "DDropListBox", CPMenu )
				DRankBox:SetSkin(GAMEMODE.Config.DarkRPSkin)
				DRankBox:SetTextColor( Color( 214, 214, 214, 200 ) )
				DRankBox:SetPos( 20, 390 )
				DRankBox:SetSize( 350, 20 )
				DRankBox:SetValue( "Choose a Rank" )
				DRankBox:AddChoice( "RCT", 1 )
				DRankBox:AddChoice( "04", 2 )
				DRankBox:AddChoice( "03", 3 )
				DRankBox:AddChoice( "02", 4 )
				DRankBox:AddChoice( "01", 5 )
				DRankBox:AddChoice( "OfC (Whitelist Required)", 6 )
				DRankBox:AddChoice( "SqL (Whitelist Required)", 7 )
				DRankBox:AddChoice( "DvL (Whitelist Required)", 8 )
				DRankBox:AddChoice( "DcO (Whitelist Required)", 9 )

				DRankBox.OnSelect = function( panel, index, value )
					Rank = value
					RankI = index or 1
					updateButton()
				end

		local DDivisionBox = vgui.Create( "DDropListBox", CPMenu )
				DDivisionBox:SetTextColor( Color( 214, 214, 214, 200) )
				DDivisionBox:SetPos( 20, 117 )
				DDivisionBox:SetSize( 350, 20 )
				DDivisionBox:SetValue( "Choose a Division" )
				DDivisionBox:AddChoice( "UNION", 1 )
				DDivisionBox:AddChoice( "HELIX", 2 )
				DDivisionBox:AddChoice( "GRID", 3 )
				DDivisionBox:AddChoice( "JURY", 4 )
				DDivisionBox:AddChoice( "SPEAR", 5 )
				DDivisionBox:AddChoice( "VICE", 6 )
				DDivisionBox:AddChoice( "COMMANDER (Whitelist Required)", 7 )
				DDivisionBox.OnSelect = function( panel, index, value )
					Division = value
					DivisionI = index or 1
					updateButton()
				end

		local icon = vgui.Create( "DModelPanel", CPMenu )
			icon:SetSize( 400, 300 )
			icon:SetPos( 270, 50)
			icon:SetModel( "models/player/police.mdl" )
			function icon.Entity:GetPlayerColor() return Vector (1, 0, 0) end
			function icon:LayoutEntity( Entity ) return end

		local Button = vgui.Create( "DButton", CPMenu )
			Button:SetFont("NameFont")
			Button:SetText( "Choose Rank and Division" )
			Button:SetTextColor( Color( 179, 179, 179, 200) )
			Button:SetPos( 10, 637 )
			Button:SetSize( 880, 30 )
			Button.Paint = function( self, w, h )
				surface.SetDrawColor(Color(0, 0, 0, 200))
				surface.DrawRect(160,0,500,35) -- Draw a blue button
			end

			Button.DoClick = function()
				if RankI and DivisionI then
					LocalPlayer():ConCommand( "rp_division "..RankI.." "..DivisionI )
--					print("Rank:"..RankI.." Div: "..DivisionI)
					CPMenu:Close()
				end
			end
			function updateButton()

				if not RankI then
					RankI = 1
					DivisionI = 1
				end

				RankText = CPRanks[RankI].description

				local RankShort = CPRanks[RankI].name
				RankLabel:SetText(RankText)
				RankLabel:SizeToContents()

				DivisionText = CPDivisions[DivisionI].description
				local DivisionXP = CPDivisions[DivisionI].xp
				icon:SetModel(CPDivisions[DivisionI].model)
				icon:RunAnimation()

				--Rank XP Requirement
				local RankXP = CPRanks[RankI].xp
				RankXPLabel:SetText("XP Requirement: "..RankXP)

				RankXPLabel:SizeToContents()

--Division XP Requirement
				DivisionXPLabel:SetText("XP Requirement: "..DivisionXP)

				DivisionLabel:SetText(DivisionText)
				DivisionLabel:SizeToContents()
				DivisionXPLabel:SizeToContents()

				if DivisionI == 7 then
				Button:SetText( "Choose Division" ..Division )
				else
				Button:SetText( "Choose Rank and Division" )
				end
			end
--icon.Entity:SetEyeTarget( headpos-Vector( -15, 0, 0 ) )
	updateButton()

end

usermessage.Hook("ShopNPCUsed", NPCShopMenu) --Hook to messages from the server so we know when to display the menu.







/*surface.CreateFont( "NPCName", {

    font = "Bebas Neue",

    size = 39,

    weight = 300,

    antialias = true,

} )



/*hook.Add("PostDrawOpaqueRenderables","CPNPCName",function()

		local LP = LocalPlayer()

		local LPos = LP:GetPos()

		local LPAng = LP:EyeAngles()

		for k,v in pairs(ents.FindByClass("cp_npc")) do



			local p = v:GetPos()
			if LPos:Distance(p) < 600 then
				cam.Start3D2D( p+Vector(0,0, 75), Angle(0, LPAng.y-90, 90), 0.18 )

					draw.SimpleText( "Commander", "NPCName", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				cam.End3D2D()

			end
	end

end)*/
