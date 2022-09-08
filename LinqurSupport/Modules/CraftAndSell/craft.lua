function _linqur_suport.craft_and_sell:craft()
    _linqur_suport.craft_and_sell.crafted_count = 0
    _linqur_suport.craft_and_sell.needly_to_craft_count = _linqur_suport.craft_and_sell:getNeedlyToCtaftCount()
    if _linqur_suport.craft_and_sell.needly_to_craft_count > 0 then
        C_TradeSkillUI.CraftRecipe(_linqur_suport.craft_and_sell.craft_id, _linqur_suport.craft_and_sell.needly_to_craft_count)
    else
        _linqur_suport.craft_and_sell:creftIsDone()
    end
end

function _linqur_suport.craft_and_sell:getNeedlyToCtaftCount()
    return math.min(_linqur_suport.craft_and_sell:getEmptySlotCount(), C_TradeSkillUI.GetRecipeInfo(_linqur_suport.craft_and_sell.craft_id).numAvailable)
end

function _linqur_suport.craft_and_sell.events:UNIT_SPELLCAST_SUCCEEDED()
    if _linqur_suport.craft_and_sell.action ~= 'craft' then
        return
    end 

    _linqur_suport.craft_and_sell.crafted_count = _linqur_suport.craft_and_sell.crafted_count + 1

    if _linqur_suport.craft_and_sell.crafted_count >= _linqur_suport.craft_and_sell.needly_to_craft_count then
        _linqur_suport.craft_and_sell:creftIsDone()
    end
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

function _linqur_suport.craft_and_sell:stopCrafting()
    C_TradeSkillUI.StopRecipeRepeat()
end
