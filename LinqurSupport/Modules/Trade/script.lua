_linqur_suport.trader = {}

function _linqur_suport:trade(itemsId)
    for bag = 0, 4, 1 do
        for slot = 1, GetContainerNumSlots(bag), 1 do
            local itemId = GetContainerItemID(bag, slot)
            if itemId ~= nil and _linqur_suport.trader:contain(itemsId, itemId) then
                UseContainerItem(bag, slot)
            end
        end
    end
end

function _linqur_suport.trader:contain(itemsId, itemId)
    for key, value in ipairs(itemsId) do 
        if value == itemId then
            return true
        end
    end
    return false
end
