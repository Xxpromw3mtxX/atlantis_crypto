ESX = nil
local playersProcessingCrypto = {}

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('atlantis_crypto:farmingCrypto')
AddEventHandler('atlantis_crypto:farmingCrypto', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	ESX.SetTimeout(Config.Delays.Farming, function()
		if xPlayer.canCarryItem(Config.CryptoCoin, 1) then
			xPlayer.addInventoryItem(Config.CryptoCoin, 1)
		end
	end)
end)

RegisterServerEvent('atlantis_crypto:ProcessCrypto')
AddEventHandler('atlantis_crypto:ProcessCrypto', function(rest)
    local cryptoSelected = Config.ProcessedCoin[rest]

	if not playersProcessingCrypto[source] then
		local _source = source

		playersProcessingCrypto[_source] = ESX.SetTimeout(Config.Delays.Processing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCrypto = xPlayer.getInventoryItem(Config.CryptoCoin)

			if xCrypto.count >= 10 then
				if xPlayer.canSwapItem(Config.CryptoCoin, 10, cryptoSelected, 1) then
					xPlayer.removeInventoryItem(Config.CryptoCoin, 10)
					xPlayer.addInventoryItem(cryptoSelected, 1)    
				else
					xPlayer.showNotification(_U('processingfull'))
				end
			else
				xPlayer.showNotification(_U('processingenough', _U('crypto'), 10))
			end

			playersProcessingCrypto[_source] = nil
		end)
	else
		print(('atlantis_crypto: %s attempted to exploit Crypto processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingCrypto[playerID] then
		ESX.ClearTimeout(playersProcessingCrypto[playerID])
		playersProcessingCrypto[playerID] = nil
	end
end

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)