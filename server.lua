local QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateCallback('getBanList', function(source, cb)
    local banList = {}
    local result = MySQL.Sync.fetchAll('SELECT * FROM bans', {})

    for _, ban in ipairs(result) do
        table.insert(banList, {
            id = ban.id,
            name = ban.name,
            license = ban.license,
            discord = ban.discord,
            ip = ban.ip,
            reason = ban.reason,
            expire = ban.expire,
            bannedby = ban.bannedby
        })
    end

    cb(banList)
end)

RegisterNetEvent('moon-db:server:removeBan')
AddEventHandler('moon-db:server:removeBan', function(banId)
    local src = source
    if banId then
        MySQL.Async.execute('DELETE FROM bans WHERE id = @id', {['@id'] = banId}, function(affectedRows)
            if affectedRows > 0 then
                TriggerClientEvent('QBCore:Notify', src, 'Ban lifted successfully.', 'success')
            else
                TriggerClientEvent('QBCore:Notify', src, 'Failed to lift the ban.', 'error')
            end
        end)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Invalid Ban ID.', 'error')
    end
end)

QBCore.Commands.Add('unban', 'Opens The Unban Context', {}, false, function(source)
    local src = source
    TriggerClientEvent('moon-unban:client:unban', src)
end, 'admin')