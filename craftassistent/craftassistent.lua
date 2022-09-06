_craft_assistent = { 
    runing = false, 
    init = false, 
    selling = false 
} 

function _craft_assistent:start(craft_id, crafting_item_id, count) 
    _craft_assistent.craft_id = craft_id
    _craft_assistent.crafting_item_id = crafting_item_id
    _craft_assistent.count = count

    if _craft_assistent.init ~= true then 
        _craft_assistent:init() 
    end 
    
    if _craft_assistent.runing ~= true then 
        _craft_assistent.runing = true 
        _craft_assistent:craft()
    else 
        _craft_assistent:stop() 
    end 
end 

function _craft_assistent:init()
    _craft_assistent.frame = CreateFrame("Frame") 
    _craft_assistent.frame:SetScript("OnEvent", _craft_assistent.OnEvent) 
    _craft_assistent.frame:RegisterEvent("BAG_UPDATE", _craft_assistent.OnEvent) 
    _craft_assistent.init = true; 
end 

function _craft_assistent:stop()
    _craft_assistent.runing = false
    _craft_assistent.selling = false
end 

function _craft_assistent:craft()
    C_TradeSkillUI.CraftRecipe(_craft_assistent.craft_id, _craft_assistent.count) 
end
    
function _craft_assistent:isCraftDone()
    local count = 0 
    for bag = 0, 4, 1 do  
        for slot = 1, GetContainerNumSlots(bag), 1 do  
            if GetContainerItemID(bag, slot) == _craft_assistent.crafting_item_id then  
                count = count + 1 
            end 
        end 
    end 
    return count >= _craft_assistent.count 
end 
    
function _craft_assistent:sell()
    for bag = 0, 4, 1 do  
        for slot = 1, GetContainerNumSlots(bag), 1 do  
            if GetContainerItemID(bag, slot) == _craft_assistent.crafting_item_id then  
                UseContainerItem(bag, slot)
                return true
            end 
        end 
    end 
end 
    
function _craft_assistent:OnEvent(event, ...)
    if _craft_assistent.runing == true then 
        _craft_assistent[event](...) 
    end 
end 
    
function _craft_assistent:BAG_UPDATE()
    if _craft_assistent.selling ~= true and _craft_assistent:isCraftDone() then 
        _craft_assistent.selling = true;
    end

    if _craft_assistent.selling == true then
        if _craft_assistent:haveItemToSell() then
            _craft_assistent:sell()
        else
            _craft_assistent:stop()
        end
    end
end 

function _craft_assistent:haveItemToSell()
    for bag = 0, 4, 1 do  
        for slot = 1, GetContainerNumSlots(bag), 1 do  
            if GetContainerItemID(bag, slot) == _craft_assistent.crafting_item_id then
                return true
            end 
        end 
    end 
    return false
end

print(132)
   