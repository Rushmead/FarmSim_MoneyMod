MoneyMod = {};

addModEventListener(MoneyMod);

function MoneyMod:registerActionEvent()
    if g_currentMission.player ~= nil then
        if not g_currentMission:getHasPlayerPermission("transferMoney") then
            return
        end
        if g_currentMission.player.farmId == FarmManager.SPECTATOR_FARM_ID then
            return
        end
    end
    InputBinding.registerActionEvent(g_inputBinding, "MoneyMod_ADDMILLION" , self, MoneyMod.handleAction, false ,true ,false ,true)
    InputBinding.registerActionEvent(g_inputBinding, "MoneyMod_TAKEMILLION" , self, MoneyMod.handleAction, false ,true ,false ,true)
    InputBinding.registerActionEvent(g_inputBinding, "MoneyMod_ADDHTHOUSAND" , self, MoneyMod.handleAction, false ,true ,false ,true)
    InputBinding.registerActionEvent(g_inputBinding, "MoneyMod_TAKEHTHOUSAND" , self, MoneyMod.handleAction, false ,true ,false ,true)
end

function MoneyMod.handleAction(self, actionName, keyStatus, arg4, arg5, arg6) 
    if not g_currentMission:getHasPlayerPermission("transferMoney") then
        return
    end
    if g_currentMission.player.farmId == FarmManager.SPECTATOR_FARM_ID then
        return
    end
    local switch = {
        ["MoneyMod_ADDMILLION"] = function()
            g_currentMission:addMoney(1000000, g_currentMission.player.farmId, "addMoney");
        end,
        ["MoneyMod_TAKEMILLION"] = function()
            g_currentMission:addMoney(-1000000, g_currentMission.player.farmId, "addMoney");
        end,
        ["MoneyMod_ADDHTHOUSAND"] = function()
            g_currentMission:addMoney(100000, g_currentMission.player.farmId, "addMoney");
        end,
        ["MoneyMod_TAKEHTHOUSAND"] = function()
            g_currentMission:addMoney(-100000, g_currentMission.player.farmId, "addMoney");
        end
    }
    local action = switch[actionName]
    if action then
        action()
    end
end

BaseMission.registerActionEvents = Utils.appendedFunction(BaseMission.registerActionEvents, MoneyMod.registerActionEvent)
print("MoneyMod has now loaded...")