ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterServerEvent("exelds:updateOnlineTime")
AddEventHandler("exelds:updateOnlineTime", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
    MySQL.Sync.execute('UPDATE users SET onlinesure = onlinesure + @onlinesure WHERE identifier = @identifier',
                {
                    ['@onlinesure'] = 1,
                    ['@identifier'] = xPlayer.identifier
                })
    end            
end)

RegisterServerEvent("exelds:getOnlineTime")
AddEventHandler("exelds:getOnlineTime", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT onlinesure FROM users WHERE identifier = @identifier',{['@identifier'] = xPlayer.identifier},
    function(result)
    local onlinesure = result[1].onlinesure
    local saat = 0
    if onlinesure >= 60 then
        while onlinesure >= 60 do
        saat =  saat + 1
        onlinesure = onlinesure - 60
        end
    end
    if saat > 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Toplam sunucuda geçirdiğin süre: '..saat..' saat '..onlinesure..' dakika', length = 6000, style = { ['background-color'] = '#00CC00', ['color'] = '#000000' } })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Toplam sunucuda geçirdiğin süre: '..onlinesure..' dakika', length = 6000, style = { ['background-color'] = '#00CC00', ['color'] = '#000000' } })
    end
    end)
end)