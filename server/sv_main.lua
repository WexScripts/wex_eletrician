ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("wex_eletrician:GetReward")
AddEventHandler("wex_eletrician:GetReward", function(hash, id, item, count)
    local xPlayer = ESX.GetPlayerFromId(id)
    local hash = hash
    if hash == "WEXBrrsda5" then
        exports.ox_inventory:AddItem(id, item, count)
        sendToDiscord(3288624, "Eletrician", "Player "..xPlayer.getName().." Get Money", "Wex Logs")
    else
        print("CHEATER!")
        sendToDiscord(3288624, "Eletrician", "Player "..xPlayer.getName().." is cheater", "Wex Logs")
    end
end)



function sendToDiscord(color, name, message, footer)
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = footer,
              },
          }
      }
  
    PerformHttpRequest(Webhook.Main, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end