if not maphl2config  then maphl2config = {} end
print("Loaded maphl2config rp_an_city17 config.")

maphl2config["rp_an_city17"] = {

Spawn1=Vector(-627.209167, 3149.145996, -14.884352),

Spawn2=Vector(1331.555908, 4597.237793, 226.908478),

JailExit=Vector(-390.589233, 3729.531738, 32.031250),

JailExitAngle= Angle( 68.456367, 6.110536, 0.000000),

Broadcast=Vector(8978.990234, 3489.741455, 6912.031250),

RationPos=Vector(),

RemoveArmor=true,

RemovePhysProps=false,

RationDispPos = Vector(1424.016113, -1872.031250, -399.968750), 

RationCPDispPos = Vector(1424.016113, -1872.031250, -399.968750), 

RemoveObjByPos={

Vector(-410, -2241, 821),

Vector(-352, -2242, 821)

},

ButtonTable =  {
   
--[[{

id = 2061,

check = function(p)

if p:IsCP() or p:IsAdmin() then
    if LastPressJw and LastPressJw + 15 > CurTime() then return false end
    if not LastJw and LastJw + 300 <= CurTime() or p:IsAdmin() then
		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
            if not jw or jw == false then
                jw = true
		        p:notify("Judgement Waiver Acivated.")
                SetGlobalBool("jw",true)
                LastPressJw=CurTime()
            return true
            end
            elseif jw == true then
                jw = false
                p:notify("Judgement Waiver Deacivated.")
                SetGlobalBool("jw",false)
                LastJw=CurTime()
            return true
            end
		else

		    p:notify("Access denied to Judgment Waiver Controls")

		return false
		end

	end

end
    
},
--]]

{

id = 2537,

check = function(p)

	if p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

	p:notify("Access granted to broadcast system")

	return true

	else

	p:notify("Access denied to broadcast system")

	return false

	end

end

}


},
BioZones={

["Plaza"]={Vector(2588.503662, 5556.446289, 74.702499),Vector(4361.179199, 1747.260620, 748.094360)},

["Sector 1"]={Vector (4412.997559, 5380.319336, 20.320614), Vector (5872.878418, 8608.007813, 141.703094) },

["Sector 2"]={Vector (4580.531250, 1633.957764, 142.486710), Vector (-6349.416992, -2439.546387, 762.275818) },

["Trainstation"]={Vector (-618.052307, 3159.958008, 8.901978), Vector (1341.148682, 4604.825684, 237.717590) },

["Citadel"]={Vector (5915.947754, 3647.206055, 50.925953), Vector (9340.593750, 538.566895, 62.281818) },

["Nexus Prison"]={Vector (7180.861328, 3933.315430, -111.008690), Vector (6267.358398, 3286.690186, -250.832916) },


},
CitadelPortal=Vector(-9025.842773, 7174.173340, 4307.405762),

AptData={
Vector(1791,2898,987),
Vector(1911,2898,987),
Vector(2717,2898,987),
Vector(2837,2898,987),
Vector(2837,2898,830),
Vector(2717,2898,830),
Vector(1911,2898,830),
Vector(1791,2898,830),
Vector(1791,2898,673),
Vector(1911,2898,673),
Vector(2717,2898,673),
Vector(2837,2898,673)

}

}