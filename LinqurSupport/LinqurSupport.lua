_linqur_suport = {}

function _linqur_suport:printMessage(message)
    print("[Linqur Support]: " .. message)
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
