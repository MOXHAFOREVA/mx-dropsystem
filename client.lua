local drops = {}

local playerped, playercoords

RegisterNetEvent('mx-dropsystem:getInfos', function(data)
    drops = data
end)

CreateThread(function()
    while true do
        playerped = PlayerPedId()
        playercoords = GetEntityCoords(playerped) + vec3(0, 0, 0.7)
        Wait(500)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1250
        if playercoords and #drops > 0 then
            for k,v in pairs(drops) do
                local dst = #(v.coords - playercoords)
                if dst <= 7 then
                    sleep = 0
                    DrawMarker(20, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false) 
                    if dst <= 3 then
                        DrawText3D(v.coords.x, v.coords.y, v.coords.z + 0.4, "~g~E~w~ Take the items")
                        if IsControlJustPressed(0, 38) then
                            TriggerServerEvent('mx-dropsystem:TakeItems', k)
                            Wait(100)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end