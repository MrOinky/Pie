local Encounter, super = Class(Encounter)

function Encounter:init()
    super:init(self)
    
    -- Current battle turn.
    self.turn = 1
end

function Encounter:onBattleInit()
    super:onBattleInit(self)

    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            item:onBattleInit(battler)
        end
    end
end

function Encounter:onBattleStart()
    super:onBattleStart(self)

    -- Looping through the party
    for _, battler in ipairs(Game.battle.party) do
        -- Calls onBattleStart() for every equipped item.
        for _,item in ipairs(battler.chara:getEquipment()) do
            item:onBattleStart(battler)
        end
    end
end

function Encounter:onBattleEnd()
    super:onBattleStart(self)

    -- Looping through the party
    for _, battler in ipairs(Game.battle.party) do
        -- Calls onBattleEnd() for every equipped item.
        for _,item in ipairs(battler.chara:getEquipment()) do
            item:onBattleEnd(battler)
        end
        -- Empties future_heals table.
        battler.future_heals = {}
    end
end

function Encounter:onTurnStart()
    super:onTurnStart(self)
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            item:onTurnStart(battler)
        end
    end
end

function Encounter:onTurnEnd()
    super:onTurnEnd()
    local party = Game.battle.party

    -- Looping through the party
    for _,battler in ipairs(party) do
        -- Calls onTurnEnd() for every equipped item.
        for _,item in ipairs(battler.chara:getEquipment()) do
            item:onTurnEnd(battler, self.turn)
        end
        -- Runs through all future heals and reduces turns remaining
        -- by one. The heal is triggered if it hits 0.
        for i=1,#battler.chara.future_heals do
            fh = battler.chara.future_heals[i]
            fh.turns = fh.turns - 1
            if fh.turns == 0 then
                battler:heal(fh.amount)
            end
        end
    end

    -- The turn is advancing, so the turn number is increased.
    self.turn = self.turn + 1
end

function Encounter:onActionsStart()
    super:onActionsStart(self)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            item:onActionsStart(battler)
        end
    end
end

function Encounter:onActionsEnd()
    super:onActionsEnd(self)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            item:onActionsEnd(battler)
        end
    end
end

function Encounter:beforeStateChange(old, new)
    super:beforeStateChange(self, old, new)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            item:beforeStateChange(battler, old, new)
        end
    end
end

function Encounter:onStateChange(old, new)
    super:onStateChange(self, old, new)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            item:onStateChange(battler, old, new)
        end
    end
end

return Encounter