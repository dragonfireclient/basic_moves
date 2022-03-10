autofly={}
autofly.landing_distance=15
autofly.tpos=nil
autofly.etatime=-1


ws.rg('Fly3d','Movement','afly3d',function()
    if not poi.last_pos then return end
    local lp=ws.dircoord(0,0,0)
    local dst=vector.distance(lp,poi.last_pos)
    if dst > autofly.landing_distance then
        ws.aim(poi.last_pos)
    else
        minetest.settings:set_bool('afly3d',false)
    end
end,function()
    if not poi.last_pos or not poi.last_name then
        ws.dcm('Select a poi first.')
        return true
    end
    poi.set_hud_info("Fly3d")
    poi.display(poi.last_pos,poi.last_name )
end,function()
end,{'continuous_forward'})

ws.rg('Fly2d','Movement','afly2d',function()
    if not poi.last_pos then return end
    autofly.tpos=poi.last_pos
    local lp=ws.dircoord(0,0,0)
    local dst=vector.distance(lp,autofly.tpos)
    if dst > autofly.landing_distance then
        ws.aim(autofly.tpos)
    else
        return true
    end
end,function()
    if not poi.last_pos or not poi.last_name then
        ws.dcm('Select a poi first.')
        return true
    end
    poi.set_hud_info("Fly2d")
    local lp=ws.dircoord(0,0,0)
    autofly.tpos=vector.new(poi.last_pos.x,lp.y,poi.last_pos.z)
    minetest.settings:set_bool('continuous_forward',true)
    local tdst=vector.distance(autofly.tpos,poi.last_pos)
    poi.display(autofly.tpos,'Target ' .. tdst .. 'm above actual target.' )
end,function()

end,{'continuous_forward'})

ws.rg('FlyNRoof','Movement','aflynroof',function()
    if not poi.last_pos then return end
    local lp=ws.dircoord(0,0,0)
    local dst=vector.distance(lp,autofly.tpos)
    if dst > autofly.landing_distance then
        ws.aim(autofly.tpos)
        autofly.set_info(dst)
    else
        minetest.settings:set_bool('continuous_forward',false)
        minetest.settings:set_bool('alfynroof',false)
    end
end,function()
    if not poi.last_pos or not poi.last_name then
        ws.dcm('Select a poi first.')
        return true
    end
    poi.set_hud_info("FlyNroof")
    minetest.settings:set_bool('continuous_forward',true)
    autofly.tpos=vector.new(poi.last_pos.x / 8,lp.y,poi.last_pos.z / 8)
    poi.display(autofly.tpos,'Target for portal.' )
end,function()
end,{'continuous_forward'})

function autofly.warp(name)
    local pos=autofly.get_waypoint(name)
    if pos then
        if get_dimension(pos) == "void" then return false end
        minetest.localplayer:set_pos(pos)
        return true
    end
end
local function goto(pos,name,method)
    poi.last_pos=pos
    poi.last_name=name
    minetest.settings:set_bool(method,true)
end
poi.register_transport('Fly3D',function(pos,name)goto(pos,name,'afly3d') end)
poi.register_transport('Fly2D',function(pos,name) goto(pos,name,'afly2d') end)
--poi.register_transport('wrp',function(pos,name) goto(pos,name,'afly3d') end)
poi.register_transport('Nroof',function(pos,name) goto(pos,name,'aflynroof') end)
