ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = string.gsub(identity['playerName'], "_", " "),
			dateofbirth = identity['dateofbirth'],
		}
	else
		return nil
	end
end

AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len("/")) ~= "/" then
		CancelEvent()
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessage", -1, source, "(" .. source .. ") mige", message)
	else
		TriggerClientEvent("chatMessage", source, "[SYSTEM]", {255, 0, 0}, "^0Dastor ^3" .. string.sub(message, 1, string.find(message, " ")) .. "^0 vojod nadarad.")
	end
	CancelEvent()
end)

TriggerEvent('es:addCommand', 's', function(source, args, user)
	local name = getIdentity(source)
	if args[1] then
	TriggerClientEvent("sendProximityMessageShout", -1, source, "(" .. source .. ") Faryad Mizanad", table.concat(args, " "))
	end
end)

RegisterServerEvent('mpCommand')
AddEventHandler('mpCommand', function(message)
	xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent("sendProximityMessageMP", -1, source, "(" .. source .. ") Bolandgo Police", message)
	end
end)

RegisterServerEvent('proxevent')
AddEventHandler('proxevent', function(message)
	local name =  GetPlayerName(source)
	TriggerClientEvent("sendProximityMessageProxevent", -1, source, "[SYSTEM]", '^1'..name..' ^0'..message)
end)

TriggerEvent('es:addCommand', 'do', function(source, args, user)
	TriggerClientEvent("sendProximityMessageDo", -1, source, table.concat(args, " "))
end)

TriggerEvent('es:addCommand', 'aooc', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 1 then
		local name =  GetPlayerName(source)
		TriggerClientEvent("sendProximityMessageMe", -1, source, "^1Admin | " .. name, "^*" .. table.concat(args, " "))
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma admin nistid!")
	end
end, {help = 'admin chat ooc'})

TriggerEvent('es:addCommand', 'ab', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 1 then
		local name =  GetPlayerName(source)
		TriggerClientEvent("sendProximityMessageMe", -1, source, "^1Admin | " .. name, "^*" .. table.concat(args, " "))
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma admin nistid!")
	end
end, {help = 'admin chat ooc'})

TriggerEvent('es:addCommand', 'tas', function(source, args, user)
	if not args[1] then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat adad chizi vared nakardid!")
		return
	end
	if not tonumber(args[1]) then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat tedad tas faghat mitavanid adad vared konid!")
		return
	end
	local count = tonumber(args[1])
	if (count >= 5) then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Nemitavanid bishtar az 3 tas hamzaman bendazid!")
		return
	end

	local text = math.random(1,6)
	for i = 2,count do
		text = text .. ', ' .. math.random(1,6)
	end
	TriggerClientEvent("sendRollThatShit", source)
	TriggerClientEvent("sendTasMessage", -1, source, "^1Tas(^3" .. tostring(source) .. "^1)", text)
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end


RegisterCommand("ooc", function(source, args, rawCommand)
	local playerName = GetPlayerName(source)
	local msg = rawCommand:sub(5)
	local ped = GetPlayerPed(source)
	local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
	TriggerClientEvent("sendProximityMessageIB", -1, source, playerName, msg, ped_NETWORK)
end, false)

RegisterCommand("b", function(source, args, rawCommand)
	local playerName = GetPlayerName(source)
	local msg = rawCommand:sub(2)
	local ped = GetPlayerPed(source)
	local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
	TriggerClientEvent("sendProximityMessageIB", -1, source, playerName, msg, ped_NETWORK)
end, false)

RegisterCommand('f', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "government" then
        if not args[1] then
            return
        end
        local job = xPlayer.job.name
        local jobGrade = xPlayer.job.grade_label
        local name = string.gsub(xPlayer.name, "_", " ")
        local message = table.concat(args, " ")

        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers do
            local tplayer = ESX.GetPlayerFromId(xPlayers[i])
            if tplayer.job.name == job or tplayer.job.name == "off" .. job then
                TriggerClientEvent('chat:addMessage', xPlayers[i], {
                    template = '<div class="chat-message server"><b>{0}</b> {1}</div>',
                    args = { "Radio OOC - "..jobGrade.." | ".. name, message }
                })
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
    end
end)

RegisterCommand("dep", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job.name
    if xJob == "police" or xJob == "ambulance" or xJob == "government" then
        if not args[1] then
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid payam khali befrestid!")
            return
        end

        local name = string.gsub(xPlayer.name, "_", " ")
        local job  = string.upper(xJob)
        local message = table.concat(args, " ", 1)
        local xPlayers = ESX.GetPlayers()

        for i=1, #xPlayers do
            local tplayer = ESX.GetPlayerFromId(xPlayers[i])
            local tJob = tplayer.job.name
            if tJob == "police" or tJob == "ambulance" or tJob == "dadgostari" then
                TriggerClientEvent('chat:addMessage', tplayer.source, {
                    template = '<div class="chat-message server"><b>{0}</b> {1}</div>',
                    args = { "Department - "..job.." - ".. name, ": " .. message }
                })
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
    end
end, false)