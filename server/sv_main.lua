Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
end)

Gevonden = {0}
Pakjes = {}

Citizen.CreateThread(function()

    while true do
        Pakjes = Zones
        Wait(30000)
    end

end)

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

found = 0


RegisterNetEvent("sp_presentfinder:cadeautje")
AddEventHandler("sp_presentfinder:cadeautje", function(id, loot)

    local xPlayer = ESX.GetPlayerFromId(source)

    if has_value(Gevonden, id) then
        return
    else
    
    found = found + 1

    xPlayer.showNotification("Good job! You found a present! There are "..found.."/"..Config.TotalPresents.." presents left.")

    table.insert(Gevonden, id)
    TriggerClientEvent("sp_presentfinder:gevonden", -1, Gevonden)

    identifier = xPlayer.identifier
    SendToDiscord(Config.DiscordWebhookMain, "Found Present", xPlayer.getName() .. ' found present with ID ' .. id .. ' and loot ID '..loot, 32768, identifier)

    -- Loot
    if loot == 1 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 2 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 3 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 4 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 5 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 6 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 7 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 8 then
         --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 9 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 10 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    elseif loot == 69 then
        --[[
            Put loot here
            For example, xPlayer.addAccountMoney or xPlayer.addIventoryItem
        ]]
    end

    local gevdata = serializeTable(Gevonden)
    
    SendToDiscord(Config.DiscordWebhookDevs, "Found Presents", "", 32768, gevdata)

end
end)

Citizen.CreateThread(function()
    while true do
        Wait(12000)
        TriggerClientEvent("sp_presentfinder:gevonden", -1, Gevonden)
    end
end)

function serializeTable(val, name, skipnewlines, depth)
    skipnewlines = skipnewlines or false
    depth = depth or 0

    local tmp = string.rep(" ", depth)

    if name then tmp = tmp .. name .. " = " end

    if type(val) == "table" then
        tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

        for k, v in pairs(val) do
            tmp =  tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
        end

        tmp = tmp .. string.rep(" ", depth) .. "}"
    elseif type(val) == "number" then
        tmp = tmp .. tostring(val)
    elseif type(val) == "string" then
        tmp = tmp .. string.format("%q", val)
    elseif type(val) == "boolean" then
        tmp = tmp .. (val and "true" or "false")
    else
        tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
    end

    return tmp
end


local date = os.date("%Y-%m-%d %H:%M:%S")

function SendToDiscord(Webhook, Name, Message, Color, Information)
    if Message == nil or Message == '' then
        return nil
    end
    local embeds = {
        {
            ["title"] = Message,
            ["type"] = "**".. Name .. "**",
            ["color"] = Color,
            ["footer"] = {
                ["text"] = Information,
            }
        }
    }
    PerformHttpRequest(Webhook, function(Error, Content, Hand) end, 'POST', json.encode({username = Name, embeds = embeds}), {['Content-Type'] = 'application/json'})
end


RegisterNetEvent("sp_presentfinder:vraaglocaties")
AddEventHandler("sp_presentfinder:vraaglocaties", function()
    source = source
    TriggerClientEvent("sp_presentfinder:ontvanglocaties", source, Pakjes)

end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    
    Wait(1000)

    TriggerClientEvent("sp_presentfinder:ontvanglocaties", -1, Pakjes)
    print("Alle zones verstuurtd")
end)


RegisterCommand("presentblips", function(source)

    local identifiers = GetPlayerIdentifiers(source)

    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            license = string.gsub(v, "license:", "")
            break
        end
    end

    if IsPlayerAceAllowed(source, Config.BlipAce) then
        TriggerClientEvent("sp_presentfinder:remove", source)
        Citizen.Wait(30)
        TriggerClientEvent("sp_presentfinder:blips", source)
    end

end)

AddEventHandler("sp_presentfinder:hotreload", function()
    TriggerClientEvent("sp_presentfinder:ontvanglocaties", -1, Pakjes)
end)


RegisterCommand("presents", function(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.showNotification(found.."/"..Config.TotalPresents.." have been found!")

end)