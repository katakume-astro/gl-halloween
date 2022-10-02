-- partial convert to ox_lib by katakume
local zone = 0
Citizen.CreateThread(function()
    for k, v in pairs(Config.Doors) do
        zone = zone + 1
        exports.qtarget:AddBoxZone(zone, v.coords, 2.0, 2.0, {
            name = "zone",
            heading = 0,
            debugPoly = false,
            minZ = v.z,
            maxZ = v.z + 10
        }, {
            options = {
                {
                    event = "astro:alerthallowen",
                    icon = "fas fa-door",
                    label = "Zapukaj do drzwi",
                },
            },
            distance = 3
        })
    end
end)


RegisterNetEvent('gl-halloween:knockOnDoor', function()
    for k, v in pairs(Config.Doors) do
        local dst = #(GetEntityCoords(PlayerPedId()) - v.coords)
        if dst < 3 and not v.looted then
            v.looted = true
            lib.requestAnimDict("timetable@jimmy@doorknock@", false)
            TaskPlayAnim(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle", 8.0, 1.0, -1, 17, 0, 0, 0, 0)
            Wait(3000)
            playAnim()
            break
        end
    end
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        lib.requestAnimDict(dict, false)
        Citizen.Wait(5)
    end
end

function playAnim()
    local hash = GetHashKey(Config.Peds[math.random(#Config.Peds)])
    if not HasModelLoaded(hash) then
        lib.requestModel(hash, false)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    local heading = GetEntityHeading(PlayerPedId())
    local playerPos = GetEntityCoords(PlayerPedId())
    local frontx = GetEntityForwardX(PlayerPedId())
    ped = CreatePed(5, hash, playerPos.x + (frontx), playerPos.y, playerPos.z - 1, (heading - 180), true, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    Wait(1000)
    lib.requestAnimDict("mp_safehouselost@", false)
    TaskPlayAnim(PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    TaskPlayAnim(ped, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    Wait(3000)
    DeleteEntity(ped)
    lib.setClipboard('https://imgur.com/gallery/SOKo5bE')
    TriggerServerEvent('gl-halloween:getSurprise')
    SetModelAsNoLongerNeeded(hash)
end

RegisterNetEvent('astro:alerthallowen', function()
    local alert = lib.alertDialog({
        header = 'Cukierek albo psikus',
        content = 'Czy napewno chcesz zapukac do tych drzwi?',
        centered = true,
        cancel = true
    })
    if alert == "confirm" then
        TriggerEvent('gl-halloween:knockOnDoor')
    end
end)
