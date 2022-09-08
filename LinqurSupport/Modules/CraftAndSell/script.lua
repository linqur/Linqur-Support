_linqur_suport.craft_and_sell = {
    runing= false,
    init = false,
    action = nil,
    events = {}
}

function _linqur_suport:craftAndSell(craft_id)
     _linqur_suport:printMessage('1')
    _linqur_suport.craft_and_sell.craft_id = craft_id
    _linqur_suport.craft_and_sell.crafted_item_id = _linqur_suport:getItemIdByItemLink(C_TradeSkillUI.GetRecipeItemLink(craft_id))
    _linqur_suport:printMessage('2')
    if _linqur_suport.craft_and_sell.init ~= true then
        _linqur_suport.craft_and_sell:init()
    end

    if _linqur_suport.craft_and_sell.runing ~= true then
        _linqur_suport.craft_and_sell:start()
    else
        _linqur_suport:printMessage('[Craft And Spell] Принудительное завершение')
        _linqur_suport.craft_and_sell:stop()
    end
end

function _linqur_suport.craft_and_sell:start()
    _linqur_suport.craft_and_sell.runing = true
    _linqur_suport.craft_and_sell.action = 'craft'
    _linqur_suport.craft_and_sell:craft()
end

function _linqur_suport.craft_and_sell:stop()
    _linqur_suport.craft_and_sell.runing = false
    _linqur_suport.craft_and_sell.action = nil
    _linqur_suport.craft_and_sell:stopCrafting()
    _linqur_suport:printMessage('[Craft And Spell] Процесс завршен')
end

function _linqur_suport.craft_and_sell:init()
    _linqur_suport.craft_and_sell.frame = CreateFrame("Frame") 
    _linqur_suport.craft_and_sell.frame:SetScript("OnEvent", _linqur_suport.craft_and_sell.OnEvent) 
    _linqur_suport.craft_and_sell.frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    _linqur_suport.craft_and_sell.frame:RegisterEvent("BAG_UPDATE")
    _linqur_suport.craft_and_sell.init = true;
end

function _linqur_suport.craft_and_sell:OnEvent(event, ...)
    if _linqur_suport.craft_and_sell.runing == true then
        _linqur_suport.craft_and_sell.events[event](...)
    end
end

function _linqur_suport.craft_and_sell:creftIsDone()
    _linqur_suport.craft_and_sell.action = 'sell'
    _linqur_suport.craft_and_sell:sell()
end

function _linqur_suport.craft_and_sell:sellDone()
    _linqur_suport.craft_and_sell:stop()
end
