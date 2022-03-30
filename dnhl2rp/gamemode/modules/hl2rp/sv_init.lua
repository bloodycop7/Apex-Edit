function GM:ShowSpare1(p)
if not p:IsCP() then return false end
if not p.CMDCDC then
p.CMDCDC = CurTime()
end
if p.CMDCDC and p.CMDCDC > CurTime() then return end
local j = string.match(p:Nick(),"SPEAR")
local cc = string.match(p:Nick(),"GRID")
local a = string.match(p:Nick(),"KING")
local aa = string.match(p:Nick(),"SENTINEL")
local jj = string.match(p:Nick(),"NOVA")
if j and j=="SPEAR" then
p:SendLua("LoadNV(255,255,0)")
p:notify("You have toggled nightvision!")
p:EmitSound("buttons/blip1.wav")
p:ConCommand("say /me toggles nightvision.")
p.CMDCDC = CurTime() + 1
elseif cc and cc=="GRID" then
p:SendLua("LoadNV(66,158,244)")
p:notify("You have toggled nightvision!")
p:EmitSound("buttons/blip1.wav")
p:ConCommand("say /me toggles nightvision.")
p.CMDCDC = CurTime() + 1
elseif p:Team()==TEAM_OVERWATCH then

if a=="KING" or aa=="SENTINEL"  then

p:SendLua("LoadNV(255,0,0)")
p:EmitSound("buttons/blip1.wav")
p:ConCommand("say /me toggles nightvision.")
p.CMDCDC = CurTime() + 1
p:notify("You have toggled nightvision!")

elseif jj =="NOVA"  then

p:SendLua("LoadNV(255,255,0)")
p:notify("You have toggled nightvision!")
p:EmitSound("buttons/blip1.wav")
p:ConCommand("say /me toggles nightvision.")
p.CMDCDC = CurTime() + 1
else

p:SendLua("LoadNV(40,40,255)")
p:EmitSound("buttons/blip1.wav")
p:ConCommand("say /me toggles nightvision.")
p.CMDCDC = CurTime() + 1
p:notify("You have toggled nightvision!")

end

end




end



CPMenuPlyTable = CPMenuPlyTable or {}
OWMenuPlyTable = OWMenuPlyTable or {}

concommand.Add("rp_clearcpranks", function(ply)

	if not ply:IsSuperAdmin() then return end

						for k, v in pairs(player.GetAll()) do
							local SteamIDList = v:SteamID64()
								CPMenuPlyTable[plySteamID]["Division"] = 0;
								CPMenuPlyTable[plySteamID]["Rank"] = 0;
						end


end)

concommand.Add("rp_clearowranks", function(ply)

	if not ply:IsSuperAdmin() then return end

						for k, v in pairs(player.GetAll()) do
							local SteamIDList = v:SteamID64()
								OWMenuPlyTable[plySteamID]["Division"] = 0;
								OWMenuPlyTable[plySteamID]["Rank"] = 0;
						end


end)

concommand.Add("rp_clearration", function(ply)

if not ply:IsSuperAdmin() then return end

ply:SetDarkRPVar( "ration", "yes" )

end)

function teamChange(ply, oldTeam, newTeam)

if oldTeam == TEAM_OVERWATCH then
ply:SetHealth(100)
ply:SetArmor(0)
end

CPMenuPlyTable[ply:SteamID64()] = nil
OWMenuPlyTable[ply:SteamID64()] = nil

	ply:SetDarkRPVar("OWDivision", 0)
	ply:SetDarkRPVar("Division", 0)
	local plySteamID = ply:SteamID64()
	ply:SetDarkRPVar( "Rank", 0)
	ply:SetDarkRPVar("OWDivision", 0)
	
	if newTeam == TEAM_VORT then
		local id = math.random(100201, 990230)
		local name = "UU-BIOTIC-"..id
		DB.StoreRPName(ply, name)
	end
end
hook.Add( "OnPlayerChangedTeam", "OWSName", teamChange )

local function playerLeave(ply)



	ply:SetDarkRPVar("OWDivision", 0)
	ply:SetDarkRPVar("OWRank", 0)
	local plySteamID = ply:SteamID64()
	if IsValid(CPMenuPlyTable)then
		CPMenuPlyTable[plySteamID]["Division"] = 0;
		CPMenuPlyTable[plySteamID]["Rank"] = 0;
		OWMenuPlyTable[plySteamID]["OWDivision"] = 0;
		OWMenuPlyTable[plySteamID]["OWRank"] = 0;
	end

	ply:SetDarkRPVar( "Division", 0)
	ply:SetDarkRPVar( "Rank", 0)

end
hook.Add( "PlayerDisconnected", "PlayerLeave", playerLeave )


concommand.Add("event_citadel_start_b210", function(ply)
if ply:IsUserGroup( "superadmin" ) or ply:IsUserGroup( "developer" ) then
	local ent = ents.Create("prop_dynamic")
	ent:SetPos(Vector(-5704.839355, 8033.179199, 784.155212))
	ent:SetModel("models/props_combine/combine_citadelcloudcenter.mdl")
	ent:Spawn()
	ent:Activate()

	local ent = ents.Create("prop_dynamic")
	ent:SetPos(Vector(-5704.839355, 8033.179199, 784.155212))
	ent:SetModel("models/props_combine/combine_citadelcloud001c.mdl")
	ent:Spawn()
	ent:Activate()
                util.ScreenShake( Vector( 0, 0, 0 ), 200, 30, 10, 5000 )
                ply:notify("You have started an event.")
                for _, ply in pairs(player.GetAll()) do
                ply:ConCommand( "play wind_light02_loop.wav" )
                ply:ConCommand( "play ol01_portalblast.wav" )
                ply:ChatPrint( "Dispatch: All Citizens, Head to Plaza immediately.")
				timer.Simple( 1, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_alert.wav" ) end )
                ply:ScreenFade(SCREENFADE.IN, color_white, 3, 0)
	timer.Create( "GroundShakeTime", 10, 0, function() util.ScreenShake( Vector( 0, 0, 0 ), 5, 5, 10, 5000 ) end )
	timer.Simple( 5, function() ply:ConCommand( "play ambient/outro/thunder07.wav" ) end )
	timer.Simple( 8, function() ply:ConCommand( "play ambient/outro/thunder05.wav" ) end )
	timer.Simple( 10, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_corereprogramming1.wav" ) end )
	timer.Simple( 10, function() ply:ScreenFade( SCREENFADE.IN, color_white, 2, 0 ) end )
	timer.Simple( 11, function() local bigstorm = ents.Create("prop_dynamic")
		bigstorm:SetPos(Vector(-5704.839355, 8033.179199, 784.155212))
		bigstorm:SetModel("models/props_combine/combine_citadelcloudlight001a.mdl")
		bigstorm:Spawn()
		bigstorm:Activate() end )
	timer.Simple( 20, function() ply:ConCommand( "play ambient/outro/circleexplosion01.wav" ) end )
	timer.Simple( 30, function() ply:ConCommand( "play ambient/levels/citadel/citadel_5sirens.wav" ) end )
	timer.Simple( 40, function() ply:ConCommand( "play ambient/outro/circleexplosion01.wav" ) end )
	timer.Simple( 45, function() ply:ConCommand( "play ambient/levels/citadel/citadel_5sirens2.wav" ) end )
	timer.Simple( 52, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_restrictorsdisengaged.wav" ) end )
	timer.Simple( 60, function() ply:ConCommand( "play music/vlvx_song23.mp3" ) end )
	timer.Simple( 190, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_alert.wav" ) end )
	timer.Simple( 200, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_alert.wav" ) end )
	timer.Simple( 250, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_alert.wav" ) end )
	timer.Simple( 300, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_alert.wav" ) end )
	timer.Simple( 330, function() ply:ConCommand( "play ambient/levels/citadel/fcitadel_alert.wav" ) end )
	timer.Simple( 360, function() ply:ScreenFade( SCREENFADE.IN, color_white, 1000, 0 ) end )
 	timer.Simple( 360, function() ply:ConCommand( "play ambient/outro/citadelfinale.wav" ) end )
end
end
end)
	


local colYellow = Color( 246, 60, 3, 255 )

local portalPos = {
	Vector(4731.023926, 2303.414795, 1900.036133),  // Construction
	Vector(306.599792, 3515.020508, 1641.384521), // Plaza
	Vector(10026.125000, 11622.543945, 3000.813721) // Shell Beach
}


concommand.Add("event_portal_start", function(ply)
if ply:IsUserGroup( "superadmin" ) or ply:IsUserGroup( "developer" ) then
	local ent = ents.Create("prop_dynamic")
	ent:SetPos(table.Random(portalPos)) // table.Random(deathSounds)
	ent:SetModel("models/props_combine/combine_citadelcloudcenter.mdl")
                ent:SetColor( colYellow )
	ent:Spawn()
	ent:Activate()
                ply:notify("You have started an event.")
                for _, ply in pairs(player.GetAll()) do
                ply:ConCommand( "play ol01_portalblast.wav" )
                ply:notify("The portal event has started.")
                ply:ScreenFade(SCREENFADE.IN, color_white, 3, 0)
                ply:notify("Please listen to admins, OOC may be disabled.")
                ply:notify("Do not go out of character.")
                ply:ChatPrint( "The portal event has started. Listen to admins and have fun.")
 	timer.Simple( 10, function() ply:ConCommand( "play ol01portal_loop_stage01.wav" ) end )
	timer.Create( "GroundShakeTime2", 5, 0, function() util.ScreenShake( Vector( 0, 0, 0 ), 2, 2, 5, 5000 ) end )
end
end
end)

concommand.Add("event_advisor_start", function(ply)
if ply:IsUserGroup( "superadmin" ) or ply:IsUserGroup( "developer" ) then

	local ent = ents.Create("prop_dynamic")
	ent:SetPos(Vector(-1492.901123, 4110.057617, 125.058563))
                ent:SetAngles(Angle(6.339, -8.979, -0.703))
	ent:SetModel("models/advisorpod_crash/advisor_pod_crash.mdl")
	ent:Spawn()
	ent:Activate()
	local ent = ents.Create("prop_dynamic")
	ent:SetPos(Vector(-1515.022217, 3991.507568, 99.378838))
                ent:SetAngles(Angle(2.051, -124.238, -1.367))
	ent:SetModel("models/props_debris/concrete_debris256pile001a.mdl")
	ent:Spawn()
	ent:Activate()
	local ent = ents.Create("prop_dynamic")
	ent:SetPos(Vector(-1485.877563, 4210.941895, 104.672493))
                ent:SetAngles(Angle(0.616, -104.282, -1.047))
	ent:SetModel("models/props_debris/concrete_debris256pile001a.mdl")
	ent:Spawn()
	ent:Activate()
                util.ScreenShake( Vector( 0, 0, 0 ), 5, 5, 10, 5000 )
                ply:notify("You have started an event.")
                for _, ply in pairs(player.GetAll()) do
                ply:ConCommand( "play ambient/explosions/exp2.wav" )
                ply:notify("The advisor event has started.")
                ply:notify("Please listen to admins, OOC may be disabled.")
                ply:notify("Do not go out of character.")
                ply:ChatPrint( "The advisor event has started. Listen to admins and have fun.")
                timer.Simple( 7, function() ply:ConCommand( "play over_barn.wav" ) end)
                timer.Simple( 34.34, function() ply:ConCommand( "play ambient/alarms/city_siren_loop2.wav" ) end)
	timer.Create( "PortalMovey", 4.34, 0, function() util.ScreenShake( Vector( 0, 0, 0 ), 3, 3, 10, 5000 ) end)
end
end
end)

concommand.Add("getspos", function(ply)
if ply:IsUserGroup( "superadmin" ) or ply:IsUserGroup( "developer" ) then
	ply:notify(tostring(ply:GetPos()))

end
end)

local vPoint = Vector( -590.564209, 728.484009, 1317.318481 )




concommand.Add("event_citadel_stop", function(ply)
if ply:IsUserGroup( "superadmin" ) or ply:IsUserGroup( "developer" ) then

	for k, v in pairs( ents.FindByClass( "prop_dynamic" ) ) do

		if v:GetModel() == "models/props_combine/combine_citadelcloudcenter.mdl" or v:GetModel() == "models/props_combine/combine_citadelcloud001c.mdl" then
			SafeRemoveEntity(v)
                                                ply:notify("You have stopped an event.")
		end

	end

for _, ply in pairs(player.GetAll()) do
ply:ConCommand( "play ol12a_portalclose.wav" )
ply:notify("The Citadel event is over. Thank you for participating.")
ply:notify("Got any feedback for future events? Goto https://thewheatfields.mistforums.com")
ply:ScreenFade(SCREENFADE.IN, color_white, 3, 0)
ply:ChatPrint( "The citadel event is over. Thank you for participating.")
timer.Remove("GroundShakeTime")
end

end
end)

concommand.Add("event_portal_stop", function(ply)
if ply:IsUserGroup( "superadmin" ) or ply:IsUserGroup( "developer" ) then

	for k, v in pairs( ents.FindByClass( "prop_dynamic" ) ) do

		if v:GetModel() == "models/props_combine/combine_citadelcloudcenter.mdl" then
			SafeRemoveEntity(v)
                                                ply:notify("You have stopped an event.")
		end

	end

for _, ply in pairs(player.GetAll()) do
ply:ConCommand( "play ol12a_portalclose.wav" )
ply:notify("The Portal event is over. Thank you for participating.")
ply:notify("Got any feedback for future events? Goto https://thewheatfields.mistforums.com")
ply:ScreenFade(SCREENFADE.IN, color_white, 3, 0)
ply:ChatPrint( "The portal event is over. Thank you for participating.")
timer.Remove("GroundShakeTime2")
timer.Remove("PortalMovey")
end

end
end)

concommand.Add("event_advisor_stop", function(ply)
if ply:IsUserGroup( "superadmin" ) or ply:IsUserGroup( "developer" ) then

	for k, v in pairs( ents.FindByClass( "prop_dynamic" ) ) do

		if v:GetModel() == "models/advisorpod_crash/advisor_pod_crash.mdl" or v:GetModel() == "models/props_debris/concrete_debris256pile001a.mdl" then
			SafeRemoveEntity(v)
                                                ply:notify("You have stopped an event.")
		end

	end

for _, ply in pairs(player.GetAll()) do
ply:ConCommand( "stopsound" )
ply:notify("The Advisor event is over. Thank you for participating.")
ply:notify("Got any feedback for future events? Goto https://thewheatfields.mistforums.com")
ply:ChatPrint( "The advisor event is over. Thank you for participating.")
timer.Remove("AlarmShakeTime")
end

end
end)

function PlayerFootstep(client, position, foot, soundName, volume)
	if (client:isRunning()) then
		if (client:Team() == TEAM_CP) then
			client:EmitSound("npc/metropolice/gear"..math.random(1, 6)..".wav", volume * 90)

			return true
		elseif (client:Team() == TEAM_OVERWATCH or client:Team() == TEAM_OVERWATCHELITE or client:Team() == TEAM_OVERWATCHPRISONGUARD) then
			client:EmitSound("npc/combine_soldier/gear"..math.random(1, 6)..".wav", volume * 100)

			return true
		end
	end

	if (hl2rp.anim.getModelClass(client:GetModel())== "vort") then
			client:EmitSound("npc/vort/vort_foot"..math.random(1, 4)..".wav", volume * 120)
			return true
	end
end

hook.Add( "PlayerFootstep", "OWFootstep", PlayerFootstep )


concommand.Add( "rp_fcitopt", function( ply,command,args )
	if not (ply:IsSuperAdmin()) then return end

		ply:setOpt(ply, args[1])

end)

concommand.Add( "rp_citopt", function( ply,command,args )

CitOpt = {}
CitOpt[1] = "Normal Citizen"
CitOpt[2] = "Cook"
CitOpt[3] = "Black Market Dealer"
CitOpt[4] = "Medic"
CitOpt[5] = "Standard Worker"
CitOpt[6] = "Scientist"
function hasXP(ply, amount)

	if tonumber(ply:GetPData( "xp" )) >= amount then
		return true
	else
		return false
	end

end

function getOpts(num, team, max)
	local totalOpt = 0
for k, v in pairs(player.GetAll()) do
   if v:Team() == team and v:getDarkRPVar("citopt") and v:getDarkRPVar("citopt") == num then
   	totalOpt = totalOpt + 1
   end
end

if max <= totalOpt then
	return true
else
	return false
end

end

function setOpt(ply, num)
	ply:notify("You have changed what type of citizen you are to "..CitOpt[num]..".")
	ply:SetDarkRPVar("citopt", num)
	ply:SetDarkRPVar("LastCOSet", CurTime() )	
                if string.match( ply:GetModel(), "group01/male" ) then
                	medicModel = string.Replace( ply:GetModel(), "humans/group01/male", "player/jackathan/beta/medic" )
                elseif string.match( ply:GetModel(), "beta/ma" ) then
                	medicModel = string.Replace( ply:GetModel(), "player/jackathan/beta/male", "player/jackathan/beta/medic" )
                elseif string.match( ply:GetModel(), "bmscientistcits/p_male" ) then
                	cookModel = string.Replace( ply:GetModel(), "bmscientistcits", "player/jackathan/beta/medic" )             
				else
					medicModel = "models/player/jackathan/beta/medic_09.mdl"
				end
               
                if string.match( ply:GetModel(), "group01/male" ) then
                	cookModel = string.Replace( ply:GetModel(), "humans/group01", "player/jackathan/beta" )
                elseif string.match( ply:GetModel(), "medic" ) then
                	cookModel = string.Replace( ply:GetModel(), "player/jackathan/beta/medic", "player/jackathan/beta/male" )
                elseif string.match( ply:GetModel(), "bmscientistcits/p_male" ) then
                	cookModel = string.Replace( ply:GetModel(), "bmscientistcits", "player/jackathan/beta" )                	
				else
               		cookModel = "models/player/jackathan/beta/male_09.mdl"
				end
                
                if string.match( ply:GetModel(), "group01" ) then
                	scientistModel = string.Replace( ply:GetModel(), "humans/group01", "bmscientistcits" )
                elseif string.match( ply:GetModel(), "medic" ) then
                	scientistModel = string.Replace( ply:GetModel(), "player/jackathan/beta/medic", "bmscientistcits/male" )
               	elseif string.match( ply:GetModel(), "beta/ma" ) then
                	scientistModel = string.Replace( ply:GetModel(), "player/jackathan/beta", "bmscientistcits" )                  	
				else
               		scientistModel = "models/bmscientistcits/male_09.mdl"
				end

                if num == 2 then ply:SetModel(cookModel) end
                if num == 4 then ply:SetModel(medicModel) end
                if num == 5 then ply:SetModel("models/Humans/Group01/male_09.mdl") end
                if num == 6 then ply:SetModel(scientistModel) end
end


if ply:getDarkRPVar("inSpawn") == false then
	ply:notify("You are not in spawn..")
	return
end


if not ply:IsAdmin() then
	if ply:getDarkRPVar("LastCOSet") and 120 - (CurTime() - ply:getDarkRPVar("LastCOSet")) >= 0 then
		ply:notify("You have to wait ".. math.ceil(120 - (CurTime() - ply:getDarkRPVar("LastCOSet"))) .. " sec before changing.")
		return false
	end
end

	local num = args[1]
	if tonumber( num ) then
		local num = tonumber(num)
		if ply:getDarkRPVar("citopt") and ply:getDarkRPVar("citopt") == num then
			ply:notify("You are already a "..CitOpt[num]..".")
			return false
		end

-- 1 = Loyalist, 2 = Cook, 3 = Black Market, 4 = Medic
		if num == 1 and ply:Team() == TEAM_CITIZEN then
			setOpt(ply, num)
		elseif num == 2 and hasXP(ply, 10) and ply:Team() == TEAM_CWU then
			if getOpts(num, TEAM_CWU, 4) then
				ply:notify("The max limit for "..CitOpt[num].." is already reached.")
				return
			end
			setOpt(ply, num)
		elseif num == 3 and hasXP(ply, 80) and ply:Team() == TEAM_CITIZEN then
			if getOpts(num, TEAM_CITIZEN, 6) then
				ply:notify("The max limit for "..CitOpt[num].." is already reached.")
				return
			end
			setOpt(ply, num)
		elseif num == 4 and hasXP(ply, 35) and ply:Team() == TEAM_CWU then
			if getOpts(num, TEAM_CWU, 3) then
				ply:notify("The max limit for "..CitOpt[num].." is already reached.")
				return
			end
			setOpt(ply, num)
		elseif num == 6 and hasXP(ply, 100) and ply:Team() == TEAM_CWU then
			if not table.HasValue({"admin", "superadmin", "moderator", "vip", "developer"}, ply:GetNWString("usergroup")) then
				if getOpts(num, TEAM_CWU, 5) then
					ply:notify("The max limit for "..CitOpt[num].." is already reached.")
					return
				end
				return
				ply:notify("You can only become a scientist if you donate via the panel.")
			end
			setOpt(ply, num)
		elseif num == 5 and ply:Team() == TEAM_CWU then
			setOpt(ply, num)
		end
	end
end )

function plazaElevator (ply)

	if ply:IsCP() then
		--print(ply:Nick().." is CP.")
		for k, v in pairs (ents.FindInBox( Vector(1667.460205, 3390.747559, 151.531937), Vector(2058.854492, 3793.437988, 320.091736) ) ) do
			if ( IsValid(v) and v:IsPlayer() and v:SteamID() == ply:SteamID() and v:Alive() ) then
			for k, v in pairs(ents.FindByName("nexus_tunnel_elevator1")) do
				v:Fire("Open","",0)
			end
				ply:notify("The elevator has been called up.")
				DB.Log(ply:Nick().." ("..ply:SteamID()..") called the plaza elevator.", nil, Color(0, 255, 255))
				return
   			end
   		end
   		ply:notify("You need to be near the elevator to call it.")
	else
		ply:notify("Only Civil Protection can call that elevator up.")
	end

end

AddChatCommand("/plazaelevator", plazaElevator, 20)

function garageDoor (ply)

	if ply:IsCP() then
		if ply:Nick():find("GRID") then
			--print(ply:Nick().." is CP.")
			for k, v in pairs (ents.FindInBox( Vector(1750.827148, 3855.464844, 355.620728), Vector(1350.354980, 4536.534668, 150.099014) ) ) do
				if ( IsValid(v) and v:IsPlayer() and v:SteamID() == ply:SteamID() and v:Alive() ) then
				for k, v in pairs(ents.FindByName("nexus_garagedoor1")) do
					v:Fire("Open","",0)
				end
					ply:notify("The garage door has been opened.")
					DB.Log(ply:Nick().." ("..ply:SteamID()..") opened the garage door.", nil, Color(0, 255, 255))
					return
   				end
   			end
   			ply:notify("You need to be near the garage door to open it")
		else
			ply:notify("Only GRID units can open the garage door.")
		end
	end

end


function playerReward (ply)

if ply.CMDCD and ply.CMDCD > CurTime() then return end
ply.CMDCD = CurTime() + 200

if ply:IsUserGroup( "vip" ) or ply:IsAdmin() then
if ply:IsCP() then
if string.match( ply:Name(), "SeC" ) or string.match( ply:Name(), "CmD" ) or string.match( ply:Name(), "DvL" ) then

	local eyetrace = ply:GetEyeTrace()
	if eyetrace.Entity:IsValid() and eyetrace.Entity:IsPlayer() and eyetrace.Entity:Team() == TEAM_CWU then
                local targ = eyetrace.Entity

                ply:notify "You have rewarded this citizen with one ration unit."

                targ:notify "You have been rewarded by a CP with one ration unit."
                targ:SetDarkRPVar( "ration", "reward" )
                targ:notify "Your ration is ready. Collect it."

                else
                ply:notify "Look at the citizen you would like to reward, they must be CWU."

	end
end
else
ply:notify ( "You must be a CP to use this." )
end

else
ply:notify ( "This is a beta feature and requires VIP." )
end



end

AddChatCommand("/reward", playerReward, 4000)


local function Vinard(ply, cmd, args)

	if not ply:IsAdmin() then return end

	if ply:EntIndex() ~= 0 and not ply:HasPriv("rp_commands") then
		ply:PrintMessage(2, DarkRP.getPhrase("need_admin", "rp_unarrest"))
		return
	end

	local target = GAMEMODE:FindPlayer(args[1])

	if target then
                                oldmdl = target:GetModel()
                                                                                target:SetTeam( TEAM_CWU )
					 target:notify "You have set a player to vinard xd."
timer.Simple( 1, function()
					if string.match( ply:GetModel(), "fem" ) then
					suitedModel2 = string.Replace( ply:GetModel(), "group01/female_", "jackathan/beta/worker_" )
					elseif string.match( ply:GetModel(), "male" ) then
					suitedModel2 = string.Replace( ply:GetModel(), "group01/male_", "jackathan/beta/worker_" )
					end
					 target:SetModel(suitedModel2)
					 target:SetSkin(1)
                                                                                 target:Give ( "remotecontroller" )
                                                                                 target:Give ( "laserpointer" )
                                                                                 target:Give ( "stunstick" )
					 target:notify "An admin has set you to Vinard Industries."
					 target:notify "You must RP as a loyalist."
					 target:notify "You have been whitelisted to Vinard Industries."
				                 target:UpdateJob("Vinard Industries Employee")
                                                                                // doors
print "added owner to vinard door"
end)
	else
		if ply:EntIndex() == 0 then
			print(DarkRP.getPhrase("could_not_find", "player: "..tostring(args[1])))
		else
			ply:PrintMessage(2, DarkRP.getPhrase("could_not_find", "player: "..tostring(args[1])))
		end
		return
	end
end
concommand.Add("rp_vinard", Vinard)




--hack:AddRelationship( "npc_turret_floor D_HT 99" )

--

function InSpawn()
for k, ply in pairs(player.GetAll()) do
   	ply:SetDarkRPVar("inSpawn", false)
	for k, v in pairs (ents.FindInBox( GetConfig().Spawn1, GetConfig().Spawn2 ) ) do
		if ( IsValid(v) and v:IsPlayer() and v:SteamID() == ply:SteamID() and v:Alive() ) then
			ply:SetDarkRPVar("inSpawn", true)
   		end
   	end
end
end

timer.Create("InSpawn", 1, 0, InSpawn )








hook.Add("PlayerUse", "HL2RP-USECHCK", function(p,ent)
if not p.lasttime914 then

 p.lasttime914 = CurTime()

 end

	if CurTime() < p.lasttime914 then return false end

	p.lasttime914 = CurTime() + 0.3

for v,k in pairs(GetConfig().ButtonTable) do

if (k.pos and k.pos == ent:GetPos()) or (k.id and k.id == ent:MapCreationID())  then

if k.check(p,ent) == true then

return true



else

return false



end





end



end





end)


jw = false
aj = false

vortsnd = {
[1]='vo/outland_01/intro/ol01_vortcall01.wav',
[2]='vo/outland_01/intro/ol01_vortcall02c.wav',
[3]='vo/outland_01/intro/ol01_vortresp04.wav'
}


function playerVCh(ply,args)
if ply:Team()==TEAM_VORT then

if ply:GetModel()=='models/vortigaunt.mdl' then


	if args == "" then return "" end


ply:ConCommand("say /me calls vortigaunts.")
	local DoSay = function(text)
		if text == "" then return end
		for k,v in pairs(player.GetAll()) do
			if v:Team()==TEAM_VORT and v:GetModel()=='models/vortigaunt.mdl' then
			    v:ApexChat([[Color(172, 156, 11), "[VORT-CALL] ", Color(255,255,255), plyNAME, Color(255,0,255),": ", message]], ply, text)
			end

	        end
        end
        local ran = math.random(1,3)
        ply:EmitSound(vortsnd[ran])
	return args, DoSay


else
ply:notify('You must be un-shackled todo this.')

end

else


ply:notify('You must be a vort todo this.')

end

end

AddChatCommand("/vortcall", playerVCh,0.1)


hook.Add("OnPlayerChangedTeam","VORT-SETCOL", function(p)
p:SetColor(Color(255,255,255,255))
p:SetArmor(0)
p:SendLua([[hook.Remove('PreDrawHalos','Vortessence_Vision')]])

end)


hook.Add("GravGunPickupAllowed","STOPPICKINGUPMYFUCKINGSCANNER", function(p,e)
if e:GetClass()=="npc_cscanner" or e:GetClass()=="combine_mine" or e:GetClass()=="pill_hopper" or e:GetClass()=="npc_rollermine" or e:GetClass()=="aw2_manhack" or e:GetClass()=="npc_manhack" or e:GetClass()=="npc_clawscanner" then
return false
end

end)

local function checkEffect(p)
return p:IsAdmin()
end

hook.Add( "PlayerSpawnEffect", "EffectCheck", checkEffect )


timer.Create("DISABLE-CROSSHAIR",3,0,function()
	

for k,v in pairs(player.GetAll()) do
	v:CrosshairDisable()
end

end)

hook.Add('ZAPC_CheckAccess', "APEX-APC-CHECK", function(ply, mode, apc) 
    if mode == 'personal' then 
        if ply:IsCP() and ply:Nick():find("GRID") then
            return true
        else
            ply:notify("Only GRID units may enter the driver and gunner seat of the APC.")
            return false
        end
    end 

end)

local function PlayerAC(ply, args)
 if not ply:IsAdmin() then return "" end
	if args == "" then return "" end
	local DoSay = function(text)
		if text == "" then return end
		for k,v in pairs(player.GetAll()) do
    if v:IsAdmin() then
			   v:ApexChat([[Color(124,252,0), "[Admin Chat] ", prefixc, steamNAME, Color(124,252,0),": ", message]], ply, text)
    end
		end
	end
	return args, DoSay
end
AddChatCommand("/ac", PlayerAC)
AddChatCommand("/adminchat", PlayerAC)