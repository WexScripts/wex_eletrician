ESX = exports["es_extended"]:getSharedObject()


function GetRandomPos(pos)
    local positions = pos
    local randomIndex = math.random(#positions)
    return positions[randomIndex] 
  end
  

  local blips = {}

  CreateThread(function()
      for name, v in pairs(Config.Blips) do
          local blip = AddBlipForCoord(v.Coords.x, v.Coords.y, v.Coords.z)
          SetBlipSprite(blip, v.Sprite)
          SetBlipDisplay(blip, 4)
          SetBlipScale(blip, v.Size)
          SetBlipColour(blip, v.Color)
          SetBlipAsShortRange(blip, v.AlwaysShow)
          BeginTextCommandSetBlipName('STRING')
          AddTextComponentSubstringPlayerName(v.Label and v.Label or name)
          EndTextCommandSetBlipName(blip)
          table.insert(blips, blip)
      end
  end)
  