-- #region MIRRORED JOKER (UNFINISHED)
SMODS.Joker {
    key = "mirrored_joker",
    atlas = "sxfjokeratlas",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    config = {
        extra = {
            dollars = 1,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars, -- replace #1# in the description with this value
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            -- sets the trigger count
            context.other_card.count = (context.other_card.count or 0) + 1

            -- gives the player cash money $$$
            if (context.other_card.count or 0) >= 2 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end

        -- reset the triggers
        if context.joker_main then
            for i = 1, #context.scoring_hand do
                if (context.scoring_hand[i].count or 0) >= 1 then
                    context.scoring_hand[i].count = nil
                end
            end
        end
    end,
}
-- #endregion

-- #region CAMERA SHUTTER (NEEDS SPRITE)
SMODS.Joker {
    key = "camera_shutter",
    atlas = "sxfjokeratlas",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 7,
    pos = { x = 9, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_negative', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_negative' } } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_negative'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}
-- #endregion

-- #region MANDELBROT
SMODS.Joker {
    key = "mandelbrot",
    atlas = "sxfjokeratlas",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 5,
    pos = { x = 1, y = 1 },
    config = {
        extra = {
            chips = 0,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips, -- replace #1# in the description with this value
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            card.ability.extra.chips = card.ability.extra.chips + math.floor(context.other_card.base.nominal / 2)
            -- upgrade message
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}
-- #endregion
