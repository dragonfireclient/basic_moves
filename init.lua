local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
dofile(modpath .. "/autofly.lua")
--dofile(modpath .. "/incremental_tp.lua")
poi.register_transport('TP',function(pos,name)
    minetest.send_chat_message("/teleport "..pos.x..","..pos.y..","..pos.z)
end)
