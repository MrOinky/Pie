-- The brute shield. Menacing and spiky, it'll hurt enemies when you get hit if you're defending.
-- Shows how you might use onHolderHurt() in an item.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "BruteShield"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A menacing, brutish, and spiked pink shield. Hurts attackers when defending."

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
        defense = 3,
        attack = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Thorns"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        ralsei = false,
        noelle = false,
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Cool!",
        ralsei = "Um, it's a little too big...",
        noelle = "Its too heavy!",
    }
end

function item:onHolderHurt(battler, damage, defending)
    -- Check whether the holder is defending.
    if defending then
        -- Choose a random target to hit.
        local target = Utils.pick(Game.battle.enemies)
        -- Hurts the target for 1/3 of the damage dealt.
        target:hurt(math.floor(damage / 3), battler)
    end
end

return item