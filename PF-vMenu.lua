ConfigShared = {}
ConfigShared.EnablePFvMenuSupport = true 
SaveId = {}

Citizen.CreateThread(function()
TriggerServerEvent("pma-voice:joinedsrv")
end)




AddEventHandler("pma-voice:PF-vMenu", function(cb)
    cb(ConfigShared.EnablePFvMenuSupport)
end)

if gameVersion == 'fivem' then
    proximityEffectId = CreateAudioSubmix('proximity')
    SetAudioSubmixEffectRadioFx(proximityEffectId, 2)
    SetAudioSubmixEffectParamInt(proximityEffectId, 2, `default`, 1)
    SetAudioSubmixEffectParamFloat(proximityEffectId, 2, `o_freq_lo`, 350.0)
    SetAudioSubmixEffectParamFloat(proximityEffectId, 2, `o_freq_hi`, 6500.0)
    SetAudioSubmixEffectParamFloat(proximityEffectId, 2, `rm_mod_freq`, 0.5)
    SetAudioSubmixEffectParamFloat(proximityEffectId, 2, `rm_mix`, 0.16)
    SetAudioSubmixEffectParamFloat(proximityEffectId, 2, `fudge`, 7.5)
    SetAudioSubmixEffectParamFloat(proximityEffectId, 2, `freq_low`, 450.0)
    SetAudioSubmixEffectParamFloat(proximityEffectId, 2, `freq_hi`, 5500.0)
    AddAudioSubmixOutput(proximityEffectId, 2)
end

if GetConvar('voice_EnableBullhorn', 'false') == 'true' then
    RegisterKeyMapping("+bullhorn", "bullhorn key", "keyboard", "N")
    
    RegisterCommand("+bullhorn", function()
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
            if ((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) and GetVehicleClass(vehicle) == 18) then
                bullhornpressed = true
        
                setProximityState(75.0, true)
                TriggerServerEvent("pma-voice:bullhorn", true)
            end
    end)
    RegisterCommand("-bullhorn", function()
            bullhornpressed = false
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        if ((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) and GetVehicleClass(vehicle) == 18) then
            local voiceModeData = Cfg.voiceModes[mode]
            setProximityState(voiceModeData[1], false)
            TriggerServerEvent("pma-voice:bullhorn", false)
        end
    end)
    
    Citizen.CreateThread(function()
        while bullhornpressed do
            local ped = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn(ped, false)
            if not ((GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) and GetVehicleClass(vehicle) == 18) then
                TriggerServerEvent("pma-voice:bullhorn", false)
                bullhornpressed = false
            end
            Citizen.Wait(1)
        end
    end)
    
    AddEventHandler("pma-voice:setBullhorn")
    RegisterNetEvent("pma-voice:setBullhorn", function(client, bool)
        if bool then
        MumbleSetSubmixForServerId(client, proximityEffectId)
       else
        MumbleSetSubmixForServerId(client, -1)
       end
    end)
end