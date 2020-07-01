print('Setting up WIFI...')

-- Set your WiFi configuration here
wifi.setmode(wifi.STATION)
wifi.sta.config({ssid='MY SSID',pwd='MY PASS',auto=true})

-- Create a non blocking loop/timer for checking connectivity
timer = tmr.create()
timer:alarm(1000, tmr.ALARM_AUTO, function()
	if wifi.sta.getip() == nil then
		print('Waiting for IP ...')
	else
		print('IP is ' .. wifi.sta.getip())
        timer:stop(1)
	end
end)

-- Load http libray, serving static files
dofile('httpServer.lua')

-- Set listen port for the http protocol
httpServer:listen(80)

-- Create our custom endpoints API

-- Get text/html
httpServer:use('/welcome', function(req, res)
	-- Catch url params
	 -- /welcome?name=lua
	local name = req.query.name or "No name"
	res:send('Hello ' .. name)
end)

-- Get file
httpServer:use('/doge', function(req, res)
	res:sendFile('doge.jpg')
end)

-- Get json
httpServer:use('/json', function(req, res)
	res:type('application/json')
	res:send('{"doge": "smile"}')
end)

-- Redirect
httpServer:use('/redirect', function(req, res)
	res:redirect('doge.jpg')
end)
