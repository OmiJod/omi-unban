local QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent('moon-unban:client:unban',function() 
    QBCore.Functions.TriggerCallback('getBanList', function(banList)
        local banOptions = {}

        if #banList == 0 then QBCore.Functions.Notify("Nobody is Banned", "error", 3500) return end

        for _, ban in pairs(banList) do
            local title = ban.name .. " - " .. ban.reason
            local description = "Banned by: " .. ban.bannedby .. "\nExpires: " .. (ban.expire or 'Never')
            
            table.insert(banOptions, {
                title = title,
                description = description,
                arrow = true,
                onSelect = function()
                    local confirmUnban = lib.alertDialog({
                        header = 'Confirm Unban',
                        content = 'Do you want to unban ' .. ban.name .. '?',
                        centered = true,
                        cancel = true
                    })

                    if confirmUnban == "cancel" then
                        QBCore.Functions.Notify("You cancelled the unban.", "error", 3500)
                        return
                    end

                    TriggerServerEvent('moon-db:server:removeBan', ban.id)
                end,
            })
        end

        lib.registerContext({
            id = 'ban_management',
            title = 'Manage Bans',
            options = banOptions
        })
        lib.showContext('ban_management')
    end)
end)