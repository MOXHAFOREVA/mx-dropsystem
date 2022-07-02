ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Drops = setmetatable({}, {
    __tostring = function(self)
        return ESX.DumpTable(self)
    end,
    __add = function(self, newData)
        table.insert(self, newData)
        return self
    end,
    __sub = function(self, id)
        table.remove(self, id)
        return self
    end
})


RegisterNetEvent('esx:onPlayerDeath', function()
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src))
    local items = ESX.GetPlayerFromId(src).getInventory()
    if #items == 0 then return end
    Drops+= {
        coords = coords,
        items = items
    }
    TriggerClientEvent('mx-dropsystem:getInfos', -1, Drops)
end)

local function AddPlayerItems(items, player)
    for _,v in pairs(items) do
        player.addInventoryItem(v.name, v.count)
    end
end

RegisterNetEvent('mx-dropsystem:TakeItems', function(id)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    if Drops[id] then
        local data = Drops[id]
        CreateThread(function()
            AddPlayerItems(data.items, player)
        end)
        Drops-= id
        TriggerClientEvent('mx-dropsystem:getInfos', -1, Drops)
    else
        print('WAAAT???')
    end
end)
