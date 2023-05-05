_linqur_suport = {}

function _linqur_suport:printMessage(message)
    if type(message) ~= "string" and type(message) ~= "number" then
        _linqur_suport:printError('Не могу вывести тип ' .. type(message))
        return
    end

    print("[Linqur Support]: " .. message)
end

function _linqur_suport:printError(message)
    print("[Linqur Support Error]: " .. message)
end

function _linqur_suport:getItemIdByItemLink(itemLink)
    if itemLink == nil then
        return nil
    end

    local from, to = string.find(itemLink, "item:%d+")

    if from == nil then
        return nil
    end

    local match = string.sub(itemLink, from, to)

    return string.gsub(match, 'item:', '') + 0
end

function _linqur_suport:bagsParse(parseSlotFuntion)
    local parsed = {};
    local counter = 0;

    for bag = 0, 5, 1 do
        for slot = 1, C_Container.GetContainerNumSlots(bag), 1 do
            parsed[counter] = {
                bag = bag,
                slot = slot,
                cell = parseSlotFuntion(bag, slot)
            }
            counter = counter + 1;
        end 
    end

    return parsed;
end

function _linqur_suport:unraveling()
    local itemID = 193050
    local craftID = 376562
    C_Container.SortBags()
    local slots = _linqur_suport:bagsParse(C_Container.GetContainerItemInfo)
    for slot = 0, table.getn(slots), 1 do
        if slots[slot].cell ~= nil and slots[slot].cell.itemID == itemID and slots[slot].cell.stackCount > 4 then
            C_TradeSkillUI.CraftSalvage(craftID, 200, ItemLocation:CreateFromBagAndSlot(slots[slot].bag, slots[slot].slot))        
            return
        end    
    end
end
