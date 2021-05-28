autofly={}
autofly.landing_distance=15
autofly.tpos=nil
ws.rg('Fly3d','Movement','afly3d',function()
    if not poi.last_pos then return end
    local lp=ws.dircoord(0,0,0)
    local dst=vector.distance(lp,poi.last_pos)
    if dst > autofly.landing_distance then
        ws.aim(poi.last_pos)
    else
        minetest.settings:set_bool('flytopoi',false)
    end
end,function()
    if not poi.last_pos or not poi.last_name then
        ws.dcm('Select a poi first.')
        return true
    end
    minetest.settings:set_bool('continuous_forward',true)
    poi.display(poi.last_pos,poi.last_name )
end,function()
    minetest.settings:set_bool('continuous_forward',true)
end)

ws.rg('Fly2d','Movement','afly2d',function()
    if not poi.last_pos then return end
    autofly.tpos=poi.last_pos
    local lp=ws.dircoord(0,0,0)
    local tpos=vector.new(poi.last_pos.x,lp.y,poi.last_pos.z)
    autofly.tpos=tpos
    local dst=vector.distance(lp,tpos)
    if dst > autofly.landing_distance then
        ws.aim(tpos)
    else
        minetest.settings:set_bool('flytopoi',false)
    end
end,function()
    if not poi.last_pos or not poi.last_name then
        ws.dcm('Select a poi first.')
        return true
    end
    minetest.settings:set_bool('continuous_forward',true)
    local tdst=vector.distance(autofly.tpos,poi.last_pos)
    poi.display(autofly.tpos,'Target ' .. tdst .. 'above actual target.' )
end,function()
    minetest.settings:set_bool('continuous_forward',true)
end)

ws.rg('FlyNRoof','Movement','aflynroof',function()
    if not poi.last_pos then return end
    local lp=ws.dircoord(0,0,0)
    local dst=vector.distance(lp,autofly.tpos)
    if dst > autofly.landing_distance then
        ws.aim(tpos)
    else
        minetest.settings:set_bool('flytopoi',false)
    end
end,function()
    if not poi.last_pos or not poi.last_name then
        ws.dcm('Select a poi first.')
        return true
    end
    minetest.settings:set_bool('continuous_forward',true)
    autofly.tpos=vector.new(poi.last_pos.x / 8,lp.y,poi.last_pos.z / 8)
    =tpos
    poi.display(autofly.tpos,'Target for portal.' )
end,function()
    minetest.settings:set_bool('continuous_forward',true)
end)

function autofly.warp(name)
    local pos=autofly.get_waypoint(name)
    if pos then
        if get_dimension(pos) == "void" then return false end
        minetest.localplayer:set_pos(pos)
        return true
    end
end

autofly.register_transport('Fly3D',function(pos,name) autofly.fly3d(pos,name) end)
autofly.register_transport('Fly2D',function(pos,name) autofly.fly2d(pos,name) end)
autofly.register_transport('wrp',function(pos,name) autofly.warp(name) end)
