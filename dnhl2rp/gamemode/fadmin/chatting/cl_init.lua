usermessage.Hook("FAdmin_ReceiveAdminMessage", function(um)
	local FromPly = um:ReadEntity()
	local Text = um:ReadString()

	chat.AddText(Color(255,0,0,255), "[Report] ", team.GetColor(FromPly:Team()), FromPly:Nick()..": ", Color(255, 255, 255, 255), Text)
	surface.PlaySound("ambient/alarms/klaxon1.wav")
end)

FAdmin.StartHooks["Chatting"] = function()
	FAdmin.Commands.AddCommand("adminhelp", nil, "<text>")
	FAdmin.Commands.AddCommand("//", nil, "<text>")
end