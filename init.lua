local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
dofile(modpath .. "/autofly.lua")
--dofile(modpath .. "/incremental_tp.lua")

poi.register_transport('CTP',function(pos,name)
    minetest.localplayer:set_pos(pos)
end)

poi.register_transport('STP',function(pos,name)
    minetest.send_chat_message("/teleport "..pos.x..","..pos.y..","..pos.z)
end)
