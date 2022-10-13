RegisterServerEvent('gl-halloween:getSurprise', function() -- all sv edited by katakume
	local xPlayer = ESX.GetPlayerFromId(source)
	local niespodzianka = Config.Items[math.random(#Config.Items)]
	local szescie = math.random(1, 2)

	if szescie <= 1 then
		xPlayer.addInventoryItem(niespodzianka, Config.Amount)
	else
		TriggerClientEvent('Astro-NotifySystem:Notify', source, 'error', 'Osoba nie ma cukierkow ale w ramach rekompensaty dostales troche szmalu')
		xPlayer.addMoney(szescie)
	end
end)
