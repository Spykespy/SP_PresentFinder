startid = 0
RegisterCommand("create", function(source, args)
    local player = source
    local ped = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(ped)

    startid = startid + 1
    loot = args[1]
    zee = playerCoords.z - 0.85
    zet = round(zee, 2)
    ey = round(playerCoords.y, 2)
    ex = round(playerCoords.x, 2)
    line = "{x = "..ex..",   y = "..ey..", z = "..zet..", id = "..startid..", loot = "..loot.."}, \n    {}"

    local data = LoadResourceFile(GetCurrentResourceName(), '/server/sv_config.lua')

    print(data)
    --table.insert(data, line)
    data2 = string.gsub(data, "{}", line)

    print(data2)

    local bool = SaveResourceFile(GetCurrentResourceName(), '/server/sv_config.lua', data2)
    print(bool)

    local str = data2
    local cad = {}
    for i = 1, #str do
        cad[i] = str:sub(i, i)
    end

   TriggerEvent("sp_presentfinder:hotreload")

end)

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

RegisterCommand("startid", function(source, args)
    startid = args[1]
    print("startid = "..startid)
end)