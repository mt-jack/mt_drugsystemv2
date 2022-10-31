ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("mt_opium:Pickup")
AddEventHandler("mt_opium:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
         	if xPlayer.getInventoryItem('opium').count >= Config.maxpickableopium then
				TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
			else
				xPlayer.addInventoryItem('opium', math.random(Config.MinopiumPickUP,Config.MaxopiumPickUP)) 
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupopium'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.opiumPickup, function(err, text, headers) end, 'POST', json.encode({username = "MT_DRUGSYSTEM - opium", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
            end			
end)


RegisterServerEvent('mt_opium:ProcessItems')
AddEventHandler('mt_opium:ProcessItems', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('opium').count >= 3 then
		xPlayer.removeInventoryItem('opium', 3)
		xPlayer.addInventoryItem('opium_pooch', 1) 	
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocessopium'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
			PerformHttpRequest(Config.opiumProcess, function(err, text, headers) end, 'POST', json.encode({username = "MT_DRUGSYSTEM - opium", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, _U('nomoreopium'))	
		end
	end)
