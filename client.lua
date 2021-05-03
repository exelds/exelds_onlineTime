RegisterCommand('onlinesurem', function(source, args, raw)
    TriggerServerEvent('exelds:getOnlineTime')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        TriggerServerEvent('exelds:updateOnlineTime')
    end
end)