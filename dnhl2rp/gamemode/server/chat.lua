local ChatCommands = {}

function AddChatCommand(cmd, callback, delay)

	local detour = function(ply, arg, ...)
		if ply.DarkRPUnInitialized then
			GAMEMODE:Notify(ply, 1, 4, "Your data has not been loaded yet. Please wait.")
			GAMEMODE:Notify(ply, 1, 4, "If this persists, try rejoining or contacting an admin.")
			return ""
		end
		return callback(ply, arg, ...)
	end

	ChatCommands[string.lower(cmd)] = {
		cmd = cmd,
		callback = detour,
		delay = delay
	}
end

function removeChatCommand(cmd)
	ChatCommands[string.lower(cmd)] = nil
end

function getChatCommand(cmd)
	return ChatCommands[string.lower(cmd)]
end

local function RP_PlayerChat(ply, text)
	DB.Log(ply:Nick().." ("..ply:SteamID().."): "..text )
	local callback = ""
	local DoSayFunc
	local tblCmd = ChatCommands[string.lower( string.Explode(" ", text )[1] )];
	if tblCmd then
		callback, DoSayFunc = tblCmd.callback( ply, string.sub( text, string.len( tblCmd.cmd ) + 2, string.len( text ) ) );
		if( callback == "") then
			return "", "", DoSayFunc;
		end
		text = string.sub(text, string.len(tblCmd.cmd) + 2, string.len(text))
	end
	if( callback != "") then
		callback = ( callback || "").." "
	end
	return text, callback, DoSayFunc;
end

local function RP_ActualDoSay(ply, text, callback)
	callback = callback or ""
	if text == "" then return "" end
	local col = team.GetColor(ply:Team())
	local col2 = Color(255,255,255,255)
	if not ply:Alive() then
		col2 = Color(255,200,200,255)
		col = col2
	end

	if GAMEMODE.Config.alltalk then
		for k,v in pairs(player.GetAll()) do
			GAMEMODE:TalkToPerson(v, col, callback..ply:Name(), col2, text, ply)
		end
	else
			if (ply:IsCP() and ply:Team() != TEAM_ADMINISTRATOR) then
				text2 = hook.Call("CPTalk", nil, ply, text)
				if text2 then text = text2; end
				text = "<:: "..text.." ::>";
			end

		GAMEMODE:TalkToRange(ply, callback..ply:Name().." says", text, 250)
	end
	return ""
end

GM.OldChatHooks = GM.OldChatHooks or {}
function GM:PlayerSay(ply, text, teamonly, dead) -- We will make the old hooks run AFTER DarkRP's playersay has been run.
	local text2 = (not teamonly and "" or "/g ") .. text
	local callback

	for k,v in pairs(self.OldChatHooks) do
		if type(v) ~= "function" then continue end

		if type(k) == "Entity" or type(k) == "Player" then
			text2 = v(k, ply, text, teamonly, dead) or text2
		else
			text2 = v(ply, text, teamonly, dead) or text2
		end
	end

	text2, callback, DoSayFunc = RP_PlayerChat(ply, text2)
	if tostring(text2) == " " then text2, callback = callback, text2 end

	if game.IsDedicated() then
		ServerLog("\""..ply:Nick().."<"..ply:UserID()..">" .."<"..ply:SteamID()..">".."<"..team.GetName(ply:Team())..">\" say \""..text.. "\"\n" .. "\n")
	end

	if DoSayFunc then DoSayFunc(text2) return "" end
	RP_ActualDoSay(ply, text2, callback)

	hook.Call("PostPlayerSay", nil, ply, text2, teamonly, dead)
	return ""
end

function GM:ReplaceChatHooks()
	if not hook.GetTable().PlayerSay then return end
	for k,v in pairs(hook.GetTable().PlayerSay) do -- Remove all PlayerSay hooks, they all interfere with DarkRP's PlayerSay
		self.OldChatHooks[k] = v
		hook.Remove("PlayerSay", k)
	end
	for a,b in pairs(self.OldChatHooks) do
		if type(b) ~= "function" then
			self.OldChatHooks[a] = nil
		end
	end

	table.sort(self.OldChatHooks, function(a, b)
		if type(a) == "string" and type(b) == "string" then
			return a > b
		end

		return true
	end)
end

function ConCommand(ply, _, args)
	if not args[1] then for k,v in pairs(ChatCommands) do print(k) end return end

	local cmd = string.lower(args[1])
	local arg = table.concat(args, ' ', 2)
	local tbl = ChatCommands[cmd]
	local time = CurTime()

	if not tbl then return end

	ply.DrpCommandDelays = ply.DrpCommandDelays or {}

	if tbl.delay and ply.DrpCommandDelays[cmd] and ply.DrpCommandDelays[cmd] > time - tbl.delay then
		return
	end

	ply.DrpCommandDelays[cmd] = time

	tbl.callback(ply, arg)
end
concommand.Add("darkrp", ConCommand)
