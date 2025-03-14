lib.locale()

local duty = false
local done = 0
local show = false
local workdone = false

Eoptions = {
    {
        name = 'wex_eletrician:ELmainped',
        icon = 'fa-solid fa-person',
        label = locale("el_talk"),
        distance = 2,
        onSelect = function()
            if duty then
                duty = false
                done = done - done
                workdone = false
            else
                lib.progressCircle({
                    duration = 1000,
                    position = 'bottom',
                    label = locale("el_talkprogr"),
                    useWhileDead = false,
                    canCancel = false,
                    disable = {
                        car = true,
                        move = true,
                        combat = true,
                    },
                    anim = {
                        dict = 'missfbi3_party_d',
                        clip = 'stand_talk_loop_a_male1'
                    },
                })
                lib.registerContext({
                    id = 'wex_eletrician:ELmainmenu',
                    title = locale("el_menuTitle"),
                    options = {
                      {
                        title = locale("el_startJob"),
                        icon = 'box',
                        onSelect = function()
                            local coords = GetRandomPos(Config.Eletrician.boxsToRepair)
                            lib.progressCircle({
                                duration = 1000,
                                position = 'bottom',
                                label = locale("el_gettingJob"),
                                useWhileDead = false,
                                canCancel = false,
                                disable = {
                                    car = true,
                                    move = true,
                                    combat = true,
                                },
                                anim = {
                                    dict = 'missfbi3_party_d',
                                    clip = 'stand_talk_loop_a_male1'
                                },
                            })
                            local model = GetHashKey(Config.Eletrician.jobCar)
                            RequestModel(model)
                            while not HasModelLoaded(model) do
                                Wait(100)
                            end
                            local vehicle = CreateVehicle(model, Config.Eletrician.carSpawn.x, Config.Eletrician.carSpawn.y, Config.Eletrician.carSpawn.z, Config.Eletrician.carSpawnH, true, false)                    
                            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            duty = true
                            elroute()
                        end,
                      },
                    }
                  })
                  lib.showContext('wex_eletrician:ELmainmenu')
            end
            end      
    }}

 function elroute()
    local coords = GetRandomPos(Config.Eletrician.boxsToRepair)
    if done == Config.Eletrician.maxJobs then
        notify(locale("el_menuTitle"), locale("el_goback"), 1500, "success")
        SetNewWaypoint(Config.Eletrician.pedCoords)
        workdone = true
        print("uz ne")
    else
        notify(locale("el_menuTitle"), locale("el_fixNotify"), 1500, "success")
        SetNewWaypoint(coords)
        exports.ox_target:addSphereZone({
            coords = coords,
            name = "wex_eletrician:elBox",
            radius = 3,
            debug = Config.Debug,
            options = {
                label = locale("el_fix"),
                name = "wex_eletrician:elBoxTarget",
                icon = "fa-solid fa-wrench",
                distance = 3,
                onSelect = function()
                    TriggerEvent("Mx::StartMinigameElectricCircuit", '50%', '50%', '2.0', '30vmin','1.ogg', function()
                        done = done + 1
                        exports.ox_target:removeZone("wex_eletrician:elBox")
                        TriggerServerEvent("wex_eletrician:GetReward","WEXBrrsda5", cache.serverId, "money", math.random(Config.Eletrician.minMoney, Config.Eletrician.maxMoney))
                        elroute() 
                        marker:draw()
                        print("jestejo")
                    end)
                end
            }
        })
    end
end


 

    local SpawnedPeds = {}

    local function spawnPed()
        lib.requestModel(Config.Eletrician.pedModel)
    
        local createdPed = CreatePed(4, joaat(Config.Eletrician.pedModel), vector4(Config.Eletrician.pedCoords), false, false)
    
        SetBlockingOfNonTemporaryEvents(createdPed, true)
        SetPedDiesWhenInjured(createdPed, false)
        SetPedCanPlayAmbientAnims(createdPed, true)
        SetPedCanRagdollFromPlayerImpact(createdPed, false)
        SetEntityInvincible(createdPed, true)
        FreezeEntityPosition(createdPed, true)
        SetEntityAsMissionEntity(createdPed, true, true)
        TaskStartScenarioInPlace(createdPed, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
        SetModelAsNoLongerNeeded(joaat(Config.Eletrician.pedModel))
    
        SpawnedPeds[Config.Eletrician] = createdPed
        exports.ox_target:addLocalEntity(createdPed, Eoptions)
    end
    
    local function deletePeds()
        for k, v in pairs(SpawnedPeds) do
            DeletePed(v)
            SpawnedPeds[k] = nil
        end
    end
    
    AddEventHandler("onResourceStop", function(resource)
        if resource == GetCurrentResourceName() then
            deletePeds()
        end
    end)  

    
    RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function()
    spawnPed()
end)


    function inside(self)
        if duty and cache.vehicle then
            lib.showTextUI(locale("returnVeh"))
            if  IsControlJustReleased(0,  38) then
                DeleteEntity(cache.vehicle)
                lib.hideTextUI()
                notify(locale("el_menuTitle"),  locale("thxText"), 1500, "success")
                exports.ox_target:removeZone("wex_eletrician:elBox")
                duty = false
            end
        end
    end

    function onexit(self)
        lib.hideTextUI()
    end


  local sphere =  lib.zones.sphere({
        coords = Config.Eletrician.carDepos,
        radius = 5,
        inside = inside,
        onExit  = onexit,
        debug = Config.Debug
    })

