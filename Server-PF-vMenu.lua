PlayerJoinList = {}
AddEventHandler('playerJoining', function()
	TriggerClientEvent("pma-voice:serverdata", -1, source, GetPlayerIdentifiers(source)[1])
end)


AddEventHandler('pma-voice:joinedsrv')
RegisterNetEvent('pma-voice:joinedsrv', function()

	for _, playerId in ipairs(GetPlayers()) do
  	PlayerJoinList[playerId] = GetPlayerIdentifiers(playerId)[1]
	end
	
	TriggerClientEvent("pma-voice:Joined",  source, PlayerJoinList)

end)

AddEventHandler('pma-voice:bullhorn')
RegisterNetEvent('pma-voice:bullhorn', function(bool)
	print(source)
	TriggerClientEvent("pma-voice:setBullhorn", -1, source, bool)

end)
