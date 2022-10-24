-- An example of the beforeGameOver() callback usage.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "PhoenixRing"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A ring that bears an emblem of a Phoenix. Has the power to save you from death."

    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        defense = 2,
        magic = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Revival"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Cool!",
        ralsei = "Um, it's a little too big...",
        noelle = "Its too heavy!",
    }

    self:setFlag("saved", false)
end

function item:beforeGameOver(battler)
    -- If the holder has not already been saved...
    if not self:getFlag("saved", false) then
        -- Revive them and disable the ring for the battle.
        battler:heal(999)
        Assets.playSound("boost")

        self:setFlag("saved", true)
        return true
    end
end

function item:onBattleEnd(battler)
    -- Reset saved value after battle.
    self:setFlag("saved", false)
end

return item