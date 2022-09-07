function _linqur_suport.craft_and_sell:craft()
    local count = _linqur_suport.craft_and_sell:getEmptySlotCount()
    if count > 0 then
        C_TradeSkillUI.CraftRecipe(_linqur_suport.craft_and_sell.craft_id, count)
    else
        _linqur_suport.craft_and_sell:creftDone()
    end
end

function _linqur_suport.craft_and_sell:isDoneCraft()
    if _linqur_suport.craft_and_sell:getEmptySlotCount() < 1 then
        _linqur_suport.craft_and_sell:creftDone()
    end
end

function _linqur_suport.craft_and_sell:stopCrafting()
    C_TradeSkillUI.StopRecipeRepeat()
end

function  _linqur_suport.craft_and_sell:getEmptySlotCount()
    local count = 0
    for bag = 0, 4, 1 do
        for slot = 1, GetContainerNumSlots(bag), 1 do
            if GetContainerItemID(bag, slot) == nil then
                count = count + 1
            end
        end
    end
    return count
end
