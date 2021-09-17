ESX = nil
local isFarming, isProcessing = false, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

-- Farming Zone
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

        if GetDistanceBetweenCoords(coords, Config.CryptoStation.Farming, true) < 1 then
            if not isFarming then
				ESX.ShowHelpNotification(_U('farmprompt'))
			end

            if IsControlJustPressed(0, 38) and not isFarming then
                FarmCrypto()
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function FarmCrypto()
	isFarming = true

	TriggerServerEvent('atlantis_crypto:farmingCrypto')

    animation(Config.Delays.Farming)
	exports['progressBars']:startUI(Config.Delays.Farming, _U('farming'))
	Citizen.Wait(Config.Delays.Farming)
	
	isFarming = false
end

-- Processing Zone
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CryptoStation.Processing, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('processprompt'))
			end

			if IsControlJustPressed(0, 38) and not isProcessing then
                ProcessCrypto()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessCrypto()
	isProcessing = true

    local randomV = math.fmod(math.random(10000),2)
    
	TriggerServerEvent('atlantis_crypto:ProcessCrypto', randomV)

    animation(Config.Delays.Processing)
	exports['progressBars']:startUI(Config.Delays.Processing, _U('processing'))
	Citizen.Wait(Config.Delays.Processing)

	isProcessing = false
end

-- Function Animation
function animation(wai)
    if not IsAnimated then
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()

			ESX.Streaming.RequestAnimDict('anim@heists@prison_heiststation@cop_reactions', function()
				TaskPlayAnim(playerPed, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 5.0, 1.5, 1.0, 1, 0.0, 0, 0, 0)
				IsAnimated = false
                Citizen.Wait(wai)
				ClearPedTasks(playerPed)
			end)
		end)
	end
end

-- Disable some ped action
Citizen.CreateThread(function()
    while true do
        if isFarming or isProcessing then
            DisableControlAction(0, 32) -- W
			DisableControlAction(0, 34) -- A
			DisableControlAction(0, 31) -- S
			DisableControlAction(0, 30) -- D
			DisableControlAction(0, 22) -- Jump
			DisableControlAction(0, 44) -- Cover
            Wait(0)
        else
            Wait(250)
        end
    end
end)