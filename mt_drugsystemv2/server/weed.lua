ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("mt_weed:Pickup")
AddEventHandler("mt_weed:Pickup", function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('weed').count >= Config.maxpickableweed then
		TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
	else
		xPlayer.addInventoryItem('weed', math.random(Config.MinweedPickUP,Config.MaxweedPickUP))
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('haspickupweed'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
		PerformHttpRequest(Config.weedPickup, function(err, text, headers) end, 'POST', json.encode({username = "MT_DRUGSYSTEM - weed", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
	end
end)

RegisterServerEvent('mt_weed:ProcessItems')
AddEventHandler('mt_weed:ProcessItems', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('weed').count >= 4 then
		xPlayer.removeInventoryItem('weed', 4)
		xPlayer.addInventoryItem('weed_in_pooch', 1)
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocessweed'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
		PerformHttpRequest(Config.weedProcess, function(err, text, headers) end, 'POST', json.encode({username = "MT_DRUGSYSTEM - weed", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent('esx:showNotification', source, _U('nomoreweed'))
	end
end)


