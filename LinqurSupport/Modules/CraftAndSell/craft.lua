function _linqur_suport.craft_and_sell:craft()
    local count = _linqur_suport.craft_and_sell:getCountToCraft()
    if count > 0 then
        C_TradeSkillUI.CraftRecipe(_linqur_suport.craft_and_sell.craft_id, count)
    else
        _linqur_suport.craft_and_sell:creftDone()
    end
end

function _linqur_suport.craft_and_sell:getCountToCraft()
    return math.min(_linqur_suport.craft_and_sell:getEmptySlotCount(), C_TradeSkillUI.GetRecipeInfo(_linqur_suport.craft_and_sell.craft_id).numAvailable)
end

function _linqur_suport.craft_and_sell:isDoneCraft()
    if _linqur_suport.craft_and_sell:getCountToCraft() < 1 then
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
