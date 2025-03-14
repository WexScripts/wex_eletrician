

function notify(title, message, time, type)
    if Config.NotifyType == "ox" then
        lib.notify({
            title = title,
            description = message,
            duration = time,
            type = type
        })
    elseif Config.NotifyType == "esx" then
        ESX.ShowNotification(title, message, type, time)
    elseif Config.NotifyType == "okok" then
        exports['okokNotify']:Alert(title, message, time, type, true)
    elseif Config.NotifyType == "custom" then
        print("custom") -- change this to custom
    end
end
