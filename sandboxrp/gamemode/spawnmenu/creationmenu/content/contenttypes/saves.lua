
local HTML = nil

spawnmenu.AddCreationTab( "#spawnmenu.category.saves", function()

	HTML = vgui.Create( "DHTML" )
	JS_Language( HTML )
	JS_Workshop( HTML )
	HTML:OpenURL( "asset://garrysmod/html/saves.html" )
	HTML:Call( "SetMap( '" .. game.GetMap() .. "' );" )

	ws_save = WorkshopFileBase( "save", { "save" } )
	ws_save.HTML = HTML

	function ws_save:FetchLocal( offset, perpage )

	end


	function ws_save:DownloadAndLoad( id )
	end

	function ws_save:Load( filename ) end
	function ws_save:Publish( filename, imagename ) end

	return HTML

end, "icon16/disk_multiple.png", 200 )



hook.Add( "PostGameSaved", "OnCreationsSaved", function()

	if ( !HTML ) then return end

	HTML:Call( "OnGameSaved()" )

end )

