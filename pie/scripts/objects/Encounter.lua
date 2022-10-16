local Encounter, super = Class(Encounter)

function Encounter:init()
    super:init(self)
    
    -- Current battle turn.
    self.turn = 1
end

function Encounter:onBattleStart()
    super:onBattleStart(self)

    for _, battler in ipairs(Game.battle.party) do
        for _,item in ipairs(battler.chara:getEquipment()) do
            item:onBattleStart(battler)
        end
    end
end

function Encounter:onBattleEnd()
    super:onBattleStart(self)

    for _, battler in ipairs(Game.battle.party) do
        for _,item in ipairs(battler.chara:getEquipment()) do
            item:onBattleEnd(battler)
        end
    end
end

function Encounter:onTurnEnd()
    super:onTurnEnd()
    local party = Game.battle.party

    -- Looping through the party
    for _,battler in ipairs(party) do
        -- Looping through every equipped item (weapon, armor1, armor2)
        for _,item in ipairs(battler.chara:getEquipment()) do
            item:onTurnEnd(battler, self.turn)
        end
    end

    self.turn = self.turn + 1
end

return Encounter