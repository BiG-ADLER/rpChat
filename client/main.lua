ESX = nil
Citizen.CreateThread(function ()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	   PlayerData = ESX.GetPlayerData()
	end
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
  end)

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', name , {255, 0, 0}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', name , {255, 0, 0}, message)
  end
end)

RegisterNetEvent('sendProximityMessageradio')
AddEventHandler('sendProximityMessageradio', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    if myId ~= pid then
      TriggerEvent('chatMessage', name , {255, 0, 0}, message)
    end
  end
end)

RegisterNetEvent('sendRollThatShit')
AddEventHandler('sendRollThatShit', function()
	RequestAnimDict('mp_player_int_upperwank')
	if not HasAnimDictLoaded('mp_player_int_upperwank') then
		RequestAnimDict('mp_player_int_upperwank') 
		while not HasAnimDictLoaded('mp_player_int_upperwank') do 
			Citizen.Wait(1)
		end
	end
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 6.0, 'shake', 0.9)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 6.0, 'drop', 0.9)
	
	local playerPed = GetPlayerPed(-1)

	local animation = 'mp_player_int_wank_01_enter'
	local animation2 = 'mp_player_int_wank_01_exit'
	local flags = 8
	TaskPlayAnim(playerPed, 'mp_player_int_upperwank', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
	Citizen.Wait(650)
	TaskPlayAnim(playerPed, 'mp_player_int_upperwank', animation2, 8.0, -8, -1, flags, 0, 0, 0, 0)
	
end)

RegisterNetEvent('sendTasMessage')
AddEventHandler('sendTasMessage', function(id, name, message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	Citizen.Wait(1000)
	if pid == myId then
		TriggerEvent('chatMessage', name, {150, 150, 250}, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', name, {150, 150, 250},  message)
	end
end)

RegisterCommand('mp', function(source, args)

  local player = GetPlayerPed(-1)
  
  if PlayerData.job.name == "police" then 

    if (IsPedSittingInAnyVehicle(player)) then
        
      if contains(exports["esx_vehiclecontrol"]:GetVehicles(PlayerData.job.name), GetEntityModel(GetVehiclePedIsIn(player))) then
        
        if args[1] then
          TriggerServerEvent('mpCommand', table.concat(args," "))
        else
          ESX.ShowNotification('~r~~h~Shoma Hadeaghal bayad yek kalame type konid.')
        end

      else
        ESX.ShowNotification('~r~~h~Shoma Savar mashin police nistid!')
      end

    else
      ESX.ShowNotification('~g~~h~Baraye estefade az in command bayad dakhel mashin bashid')
    end

  else
    ESX.ShowNotification('~r~~h~Shoma Police nistid!')
  end

end, false)



RegisterNetEvent('sendProximityMessageShout')
AddEventHandler('sendProximityMessageShout', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
    if pid == myId then
      TriggerEvent('chatMessage',  name, {255, 0, 0}, message)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 30.0 then
      TriggerEvent('chatMessage', name, {255, 0, 0},  message)
    end
end)

RegisterNetEvent('sendProximityMessageMP')
AddEventHandler('sendProximityMessageMP', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage',  name, {0, 25, 255}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 40.0 then
    TriggerEvent('chatMessage', name, {0, 25, 255},  message)
  end
end)

RegisterNetEvent('sendProximityMessageProxevent')
AddEventHandler('sendProximityMessageProxevent', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage',  name, {255, 0, 0}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 40.0 then
    TriggerEvent('chatMessage', name, {255, 0, 0},  message)
  end
end)


RegisterNetEvent('sendProximityMessageMMe')
AddEventHandler('sendProximityMessageMMe', function(id, name, message)

        local myId = PlayerId()
        local pid = GetPlayerFromServerId(id)
        if pid == myId then
          TriggerEvent('chatMessage',  name, {250, 175, 214}, message)
        elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
          TriggerEvent('chatMessage', name, {250, 175, 214},  message)
        end

end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', name, {200, 200, 200}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', name, {200, 200, 200},  message)
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, message  .."  (( " .. tostring(id) .. " )) ")
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, message  .."  (( " .. tostring(id) .. " )) ")
  end
end)

RegisterNetEvent('sendProximityMessageIB')
AddEventHandler('sendProximityMessageIB', function(id, name, message)
  if not ESX then return end
  if ESX.Game.DoesPlayerExistInArea(id) then
    local pid = GetPlayerFromServerId(id)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(pid)), true) < 39.999 then
      TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message advert"><b>{0}</b> {1}</div>',
        args = { "OOC - " .. name, message }
      })
    end
  end
end)

function contains(table, val)
  for i=1,#table do
     if table[i] == val then 
      return true
     end
  end
  return false
end