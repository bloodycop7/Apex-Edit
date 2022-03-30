local function CreateEnt(ent, pos, ang )
	local ent = ents.Create(ent)
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function CreateLocker( pos, ang )
	local ent = ents.Create( "locker" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadLockers()
	for k, v in pairs( ents.FindByClass( "locker" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_lockers.txt", "DATA" ) ) then
		local lockers = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_lockers.txt" ) )
		for id, tab in pairs( lockers ) do
			CreateLocker( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Locker Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

local function CreateCCD( pos, ang )
	local ent = ents.Create( "citycode" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadCCD()
	for k, v in pairs( ents.FindByClass( "citycode" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_ccd.txt", "DATA" ) ) then
		local ccds = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_ccd.txt" ) )
		for id, tab in pairs( ccds ) do
			CreateCCD( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Locker Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

local function CreateTerminal( pos, ang )
	local ent = ents.Create( "combineterminal" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadTerminal()
	for k, v in pairs( ents.FindByClass( "combineterminal" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_terminals.txt", "DATA" ) ) then
		local term = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_terminals.txt" ) )
		for id, tab in pairs( term ) do
			CreateLocker( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Locker Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

local function CreateTrash( pos, ang )
	local ent2 = ents.Create( "trash_logic" )
	ent2:SetPos( pos )
	ent2:SetAngles( ang )
	ent2:Spawn()
	ent2:Activate()
	ent2:SetNoDraw( true )
end 

local function LoadTrash()
	for k, v in pairs( ents.FindByClass( "trash_logic" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_trash_logic.txt", "DATA" ) ) then
		local trash_logic = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_trash_logic.txt" ) )
		for id, tab in pairs( trash_logic ) do
			CreateTrash( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP TRASH Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_trash_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "trash_logic" ) ) do v:Remove() end
	LoadTrash()
end )

concommand.Add( "rp_trash_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "trash_logic" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_trash_logic.txt", util.TableToJSON( tableOfatms ) )
end )

concommand.Add( "rp_locker_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "locker" ) ) do v:Remove() end
	LoadLockers()
end )

concommand.Add( "rp_locker_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "locker" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_lockers.txt", util.TableToJSON( tableOfatms ) )
end )


concommand.Add( "rp_ccd_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "citycode" ) ) do v:Remove() end
	LoadTab()
end )

concommand.Add( "rp_ccd_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfccds = {}
	for k, v in pairs( ents.FindByClass( "citycode" ) ) do
		table.insert( tableOfccds, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_ccd.txt", util.TableToJSON( tableOfccds ) )
end )

concommand.Add( "rp_terminal_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "combineterminal" ) ) do v:Remove() end
	LoadTerminal()
end )

concommand.Add( "rp_terminal_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfterms = {}
	for k, v in pairs( ents.FindByClass( "combineterminal" ) ) do
		table.insert( tableOfterms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_terminals.txt", util.TableToJSON( tableOfatms ) )
end )

local function CreateCPNpc( pos, ang )
	local ent = ents.Create( "cp_npc" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadCPNpcs()
	for k, v in pairs( ents.FindByClass( "cp_npc" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_cpnpc.txt", "DATA" ) ) then
		local CPNpcs = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_cpnpc.txt" ) )
		for id, tab in pairs( CPNpcs ) do
			CreateCPNpc( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP CPNpc's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_cpnpc_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "cp_npc" ) ) do v:Remove() end
	LoadCPNpcs()
end )

concommand.Add( "rp_cpnpc_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "cp_npc" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_cpnpc.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )

local function CreateAmmoCrate( pos, ang )
	local ent = ents.Create( "ammo" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadAmmoCrates()
	for k, v in pairs( ents.FindByClass( "ammo" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_ammocrate.txt", "DATA" ) ) then
		local AmmoCrates = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_ammocrate.txt" ) )
		for id, tab in pairs( AmmoCrates ) do
			CreateAmmoCrate( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP AmmoCrate's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_ammocrate_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "ammo" ) ) do v:Remove() end
	LoadAmmoCrates()
end )

concommand.Add( "rp_ammocrate_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "ammo" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_ammocrate.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )

local function CreateOWNpc( pos, ang )
	local ent = ents.Create( "ow_npc" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadOWNpc()
	for k, v in pairs( ents.FindByClass( "ow_npc" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_ownpc.txt", "DATA" ) ) then
		local OWNpC = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_ownpc.txt" ) )
		for id, tab in pairs( OWNpC ) do
			CreateOWNpc( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Locker Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_ownpc_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "ow_npc" ) ) do v:Remove() end
	LoadOWNpc()
end )

concommand.Add( "rp_ownpc_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "ow_npc" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_ownpc.txt", util.TableToJSON( tableOfatms ) )
end )

local function CreateAC( pos, ang )
	local ent = ents.Create( "armor" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadAC()
	for k, v in pairs( ents.FindByClass( "armor" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_ac.txt", "DATA" ) ) then
		local armorcharger = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_ac.txt" ) )
		for id, tab in pairs( armorcharger ) do
			CreateAC( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Locker Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_ac_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "armor" ) ) do v:Remove() end
	LoadAC()
end )

concommand.Add( "rp_ac_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "armor" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_ac.txt", util.TableToJSON( tableOfatms ) )
end )

local function CreateHealthCharger( pos, ang )
	local ent = ents.Create( "healthcharger" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadHealthCharger()
	for k, v in pairs( ents.FindByClass( "healthcharger" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_healthcharger.txt", "DATA" ) ) then
		local HealthCharger = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_healthcharger.txt" ) )
		for id, tab in pairs( HealthCharger ) do
			CreateHealthCharger( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Health Charger's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_healthcharger_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "healthcharger" ) ) do v:Remove() end
	LoadHealthCharger()
end )

concommand.Add( "rp_healthcharger_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "healthcharger" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_healthcharger.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )

local function CreateATM( pos, ang )
	local ent = ents.Create( "atm_machine" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadATM()
	for k, v in pairs( ents.FindByClass( "atm_machine" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_atm.txt", "DATA" ) ) then
		local atm = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_atm.txt" ) )
		for id, tab in pairs( atm ) do
			CreateATM( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP ATM's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_atm_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "atm_machine" ) ) do v:Remove() end
	LoadATM()
end )

concommand.Add( "rp_atmm_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "atm_machine" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_atm.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )

local function CreateCT( pos, ang )
	local ent = ents.Create( "crafting_table" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadCT()
	for k, v in pairs( ents.FindByClass( "crafting_table" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_ct.txt", "DATA" ) ) then
		local CraftingTable = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_ct.txt" ) )
		for id, tab in pairs( CraftingTable ) do
			CreateCT( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Crafting Table's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_ct_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "crafting_table" ) ) do v:Remove() end
	LoadCT()
end )

concommand.Add( "rp_ct_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfcts = {}
	for k, v in pairs( ents.FindByClass( "crafting_table" ) ) do
		table.insert( tableOfcts, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_ct.txt", util.TableToJSON( tableOfcts ) )
--	MsgN("Saved CPNPC spawns")
end )

local function CreateRD( pos, ang )
	local ent = ents.Create( "ration" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadRD()
	for k, v in pairs( ents.FindByClass( "ration" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_rd.txt", "DATA" ) ) then
		local RationDispenser = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_rd.txt" ) )
		for id, tab in pairs( RationDispenser ) do
			CreateRD( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Ration Dispenser's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_rd_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "ration" ) ) do v:Remove() end
	LoadRD()
end )

concommand.Add( "rp_rd_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "ration" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_rd.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )

local function CreateNRD( pos, ang )
	local ent = ents.Create( "nexus_ration" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadNRD()
	for k, v in pairs( ents.FindByClass( "nexus_ration" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_nrd.txt", "DATA" ) ) then
		local NexusRationDispenser = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_nrd.txt" ) )
		for id, tab in pairs( NexusRationDispenser ) do
			CreateNRD( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Nexus Ration Dispenser's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_nrd_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "nexus_ration" ) ) do v:Remove() end
	LoadNRD()
end )

concommand.Add( "rp_nrd_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "nexus_ration" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_nrd.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )



local function LoadVending()
	for k, v in pairs( ents.FindByClass( "prop_dynamic" ) ) do

		if v:GetModel() == "models/props_interiors/vendingmachinesoda01a.mdl" then
			local pos = v:GetPos();
			local ang = v:GetAngles();
			CreateEnt("hl2rp_vendingm", pos, ang )
			SafeRemoveEntity(v)
		end

	end


end

timer.Simple( 2, function()
	LoadAmmoCrates() -- Ammo Crates
	LoadLockers() -- Rebel Lockers
	LoadCPNpcs() -- CP Rank Giver
	LoadOWNpc() -- OTA Rank Giver
	LoadAC() -- Ammo Charger
	LoadHealthCharger() -- Health Charger
	LoadATM() -- Doesn't work sadly :(
	LoadCT() -- Crafting Table
	LoadRD() -- Ration Machine
	LoadNRD() -- UU Ration Machine
	LoadTrash()
	LoadTerminal()
	LoadCT()
end )

timer.Simple( 4, function()
	LoadVending()
end )



