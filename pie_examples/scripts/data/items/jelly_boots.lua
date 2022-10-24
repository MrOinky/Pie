-- Boots made from hardened gelatin, with strange healing properties.
-- Shows how you can modify getter functions to heal party members proportionate to their max hp.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "Jelly Boots"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Boots forged from a strange pink gelatin.\nRestores health proportionate to maximum HP."

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
        defense = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "PassiveHealing"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "I do NOT look cute.",
        ralsei = "They're a bit sticky...",
        noelle = "Ew, It's all gooey!",
    }
end

function item:doesPassiveHeal(chara)
    return true
end

function item:getPassiveHealAmount(chara)
    -- Heals 1/10th of the holder's max hp.
    return chara:getStat("health") / 10
end

function item:getPassiveHealFrequency(chara)
    return 1
end

return item