--[[
    Run server startup file from another script due to NodeMCU getting out of memory when running
    server from init file.
]] 
dofile('startServer.lua')