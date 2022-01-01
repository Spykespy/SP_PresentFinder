Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
end)

Cadeautjes = {}

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


Gevonden = {0}
reload = false

RegisterNetEvent("sp_presentfinder:gevonden")
AddEventHandler("sp_presentfinder:gevonden", function(data)

	Gevonden = data
	reload = true
	Wait(0)
	reload = false
	StartAgain()

end)

cooldown = false
function StartCooldown()
	cooldown = true
	wait = Config.CooldownTimeMinutes * 10000 * 60
	Wait(wait)
	cooldown = false
	ESX.ShowNotification("Your cooldown is over!")
end


function StartAgain()
Citizen.CreateThread(function()
	while true do
		hint = "empty"
		g = 255
		b = 55

		Cadeautjes = Cadeautjes

		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Cadeautjes) do

			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then

				if has_value(Gevonden, v.id) then
					hint = "Present has been found!"
					hint2 = "❌"
					g = 0
					b = 0
				else
					hint = "Press [E] to claim your present!"
					hint2 = "🎁"
					g = 255
					b = 55
				end

				DrawM(hint, 30, v.x, v.y, v.z, g, b, hint2)
			end

			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then

			if IsControlJustReleased(0, Keys['E']) then
				if has_value(Gevonden, v.id) then
					ESX.ShowNotification("This present has already been found!")
				else
					if cooldown == false then				
				TriggerServerEvent("sp_presentfinder:cadeautje", v.id, v.loot)
				StartCooldown()
					else
						ESX.ShowNotification("You need to cool down "..Config.CooldownTimeMinutes.." minutes.")
					end
				end
			end

		end
		end

		if reload then
			break
		end

	end
return
end)
end


function DrawM(hint, type, x, y, z, g, b, hint2)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.2}, hint, 1.0)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1}, hint2, 8.0)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	TriggerServerEvent("sp_presentfinder:vraaglocaties")
end)

RegisterNetEvent("sp_presentfinder:ontvanglocaties")
AddEventHandler("sp_presentfinder:ontvanglocaties", function(Pakjes)
	Cadeautjes = Pakjes
	reload = true
	Wait(0)
	reload = false
	StartAgain()
	print("Locaties ontvangen")
end)

RegisterNetEvent("sp_presentfinder:blips")
AddEventHandler("sp_presentfinder:blips", function()

	for k,v in pairs(Cadeautjes) do

		if has_value(Gevonden, v.id) then

			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, 57)
			SetBlipColour(blip, 59)
			SetBlipScale(blip, 0.5)

		else

			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, 57)
			SetBlipColour(blip, 25)
			SetBlipScale(blip, 0.5)

		end
	
	end

end)

RegisterNetEvent("sp_presentfinder:remove")
AddEventHandler("sp_presentfinder:remove", function()
	RemoveBlip(blip)
end)