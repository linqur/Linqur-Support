_autocrafter = { 
    runing = false, 
    init = false, 
    selling = false 
   } 
    
   function _autocrafter:OnEvent(event, ...) 
    if _autocrafter.runing == true then 
     _autocrafterevent 
    end 
   end 
    
   function _autocrafter:BAG_UPDATE () 
    if _autocrafter.selling ~= true and _autocrafter:isCraftDone() then 
     _autocrafter:sell() 
    end 
   end 
    
   function _autocrafter:start (craft_id, crafting_item_id, count) 
    _autocrafter.craft_id = craft_id 
    _autocrafter.count = count 
    _autocrafter.crafting_item_id = crafting_item_id; 
    _autocrafter.craft_info = C_TradeSkillUI.GetRecipeInfo(craft_id) 
    
    if _autocrafter.init ~= true then 
     _autocrafter:init() 
    end 
    
    if _autocrafter.runing == false then 
     _autocrafter.runing = true 
     _autocrafter:craft() 
    else 
     _autocrafter:stop() 
    end 
   end 
    
   function _autocrafter:craft () 
    C_TradeSkillUI.CraftRecipe(_autocrafter.craft_id, _autocrafter.count) 
   end 
    
   function _autocrafter:isCraftDone() 
    local count = 0 
    for bag = 0, 4, 1 do  
     for slot = 1, GetContainerNumSlots(bag), 1 do  
      if GetContainerItemID(bag, slot) == _autocrafter.crafting_item_id then  
       count = count + 1 
      end 
     end 
    end 
    return count >= _autocrafter.count 
   end 
    
   function _autocrafter:sell() 
    _autocrafter.selling = true; 
    for bag = 0, 4, 1 do  
     for slot = 1, GetContainerNumSlots(bag), 1 do  
      if GetContainerItemID(bag, slot) == _autocrafter.crafting_item_id then  
       UseContainerItem(bag, slot) 
      end 
     end 
    end 
    _autocrafter.selling = false; 
   end 
    
   function _autocrafter:init() 
    _autocrafter.frame = CreateFrame("Frame") 
    _autocrafter.frame:SetScript("OnEvent", _autocrafter.OnEvent) 
    _autocrafter.frame:RegisterEvent("BAG_UPDATE", _autocrafter.OnEvent) 
    _autocrafter.init = true; 
   end 
    
   function _autocrafter:stop() 
    _autocrafter.runing = false 
   end 
    
   print(132)
   