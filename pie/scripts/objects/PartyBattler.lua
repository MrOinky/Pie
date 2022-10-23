local PartyBattler, super = Class(PartyBattler)

function PartyBattler:hurt(amount, exact, color, options)
    options = options or {}
    local _amount = amount

    -- Calculating amount
    if not exact then
        amount = self:calculateDamage(amount)
        if options["all"] then
            if self.defending then
                amount = math.ceil((2 * amount) / 3)
            end
        else
            if self.defending then
                amount = math.ceil((3 * amount) / 4)
            end
        end
    end

    -- Don't callback if the damage was from a passive effect.
    if not options["passive_damage"] then
        for _, item in ipairs(self.chara:getEquipment()) do
            -- If beforeHolderHurt() returns true, then the battler is not hurt.
            if item:beforeHolderHurt(self, amount, self.defending) then
                return
            end
        end
    end

    super:hurt(self, _amount, exact, color, options)

    if not options["passive_damage"] then
        for _, item in ipairs(self.chara:getEquipment()) do
            item:onHolderHurt(self, amount, self.defending)
        end
    end
end

function PartyBattler:down()
    -- A new callback that fires on items when their holder is down.
    for _, item in ipairs(self.chara:getEquipment()) do
        item:onHolderDowned(self)
    end

    super:down(self)
end

return PartyBattler