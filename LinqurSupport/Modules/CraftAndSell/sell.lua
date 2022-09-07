_linqur_suport.craft_and_sell.sellLimit = 1
_linqur_suport.craft_and_sell.sellingSlots = {}

function _linqur_suport.craft_and_sell:sell()
    local nothingToSell = true

    _linqur_suport.craft_and_sell:clearSelledSlots()
    
    for bag = 0, 4, 1 do
        for slot = 1, GetContainerNumSlots(bag), 1 do
            if _linqur_suport.craft_and_sell:needlyToSell(bag, slot) then 
                nothingToSell = false
                if _linqur_suport.craft_and_sell:getSellingSlotsLength() < _linqur_suport.craft_and_sell.sellLimit then
                    _linqur_suport.craft_and_sell:addToSell(bag, slot)
                end
            end
        end 
    end

    if nothingToSell then
        _linqur_suport.craft_and_sell:sellDone()
    end
end

function _linqur_suport.craft_and_sell:needlyToSell(bag, slot)
    return false
end

function _linqur_suport.craft_and_sell:addToSell(bag, slot)
    _linqur_suport.craft_and_sell.sellingSlots[bag .. '_' .. slot] = {
        bag = bag,
        slot = slot
    }
    UseContainerItem(bag, slot)
end

function _linqur_suport.craft_and_sell:getSellingSlotsLength()
    local count = 0
    for k, v in pairs(_linqur_suport.craft_and_sell.sellingSlots) do
        count = count + 1
    end
    return count
end

function _linqur_suport.craft_and_sell:clearSelledSlots()
    local deleteKeys = {}
    for k, v in pairs(_linqur_suport.craft_and_sell.sellingSlots) do
        if _linqur_suport.craft_and_sell:isSelledSlot(v.bag, v.slot) then
            deleteKeys[k] = k
        end
    end
    for k, v in pairs(deleteKeys) do
        _linqur_suport.craft_and_sell.sellingSlots[k] = nil
    end
end

function _linqur_suport.craft_and_sell:isSelledSlot(bag, slot)
    return GetContainerItemID(bag, slot) == nil
end
