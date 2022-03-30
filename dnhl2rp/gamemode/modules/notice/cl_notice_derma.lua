surface.CreateFont( "NoticeFont", {
	font = "BITSTREAM VERA SANS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 16.2,
	weight = 2000,
	antialias = true
} )


local PANEL = {}

	function PANEL:Init()
		self:SetSize(256, 30)
		self:SetContentAlignment(5)
		self:SetExpensiveShadow(1, Color(34, 34, 34, 150))
		self:SetFont("Impulse-Elements18")
		self:SetTextColor(Color(255,255,255))
	end

	function PANEL:Paint(w, h)

		surface.SetDrawColor(82, 82, 82, 190)
		surface.DrawRect(0, 0, w, h )

		if (self.start) then
			local w2 = math.TimeFraction(self.start, self.endTime, CurTime()) * w

			surface.SetDrawColor(Color( 29, 28, 28, 190))
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(39,39,39))
			surface.DrawRect(w2, h-1, w - w2, 2)
		end

		surface.SetDrawColor(0, 0, 0, 45)
		surface.DrawOutlinedRect(0, 0, w, h )
	end
vgui.Register("DNotice", PANEL, "DLabel")