Config = {}
Config.Debug = false
Config.NotifyType = "ox" -- ox/esx/okok/custom - shrared/cl_edit.lua


Config.Blips = {
    {
        Label = "Brigade - Eletrician",
        Coords = vector3(737.4587, 134.3658, 79.7240),
        Sprite = 802,
        Color = 28,
        Size = 1.0,
        AlwaysShow = true,
    },

}



Config.Eletrician = {
    pedModel = "a_m_m_bevhills_02",
    pedCoords = vec4(737.4587, 134.3658, 79.7240, 240.2952),
    jobCar = "burrito",
    carSpawn = vector3(741.65, 131.71, 79.24),
    carSpawnH = 32.0389,
    carDepos = vector3(741.65, 131.71, 79.24),
    maxJobs = 6,
    minMoney = 100,
    maxMoney = 500,
    boxsToRepair = {
        vector3(194.49, -800.97, 30.88),
        vector3(-120.75, -1306.93, 29.15),
        vector3(-107.82, -742.45, 34.53),
        vector3(387.22, 354.61, 102.52),
        vector3(-131.46, 215.44, 94.51),
        vector3(-285.82, 104.38, 68.38),
        vector3(-622.35, 209.30, 74.18)
    }
}

