-- An ax that gives you a lot of random items.
-- Shows how you can modify getter functions to randomly choose an item to give to the player.

local item, super = Class(Item)

function item:init()
    super:init(self)

    -- Display name
    self.name = "RandomAx"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/axe"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An ax forged from a variety of random materials. Gives you a random item every turn."

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
        attack = 1,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "RandomItems"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = true,
    }

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Woah! it's got everything!",
        ralsei = "It's not quite my thing...",
        noelle = "Um, its not very practical...",
    }

    self.possible_items = {
        "darkburger",
        "cd_bagel",
        "butjuice",
        "dark_candy",
        "lightcandy",
        "pastry",
        "ping_pie",
        "favwich",
        "gigasalad"
    }
end

function item:doesPassiveItem(chara)
    return true
end

function item:getPassiveItemName(chara)
    return self.possible_items[love.math.random(1, #self.possible_items)]
end

function item:getPassiveItemFrequency(chara)
    return 1
end

return item