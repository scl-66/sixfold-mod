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
        if context.card_retriggered then
            return {
                dollars = card.ability.extra.dollars
            }
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
        if context.card_retriggered and not context.blueprint then
            local chip_value = math.floor(G.GAME.sxf_retriggered_value / 2)
            --print(math.floor(G.GAME.sxf_retriggered_card.base.nominal/2))
            card.ability.extra.chips = card.ability.extra.chips + chip_value
            -- upgrade message
            return {
                message = (localize('k_upgrade_ex') .. " +" .. chip_value),
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

-- #region POP ART
SMODS.Joker {
    key = "pop_art",
    atlas = "sxfjokeratlas",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 5,
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            poker_hand = "High Card",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(card.ability.extra.poker_hand, 'poker_hands'), -- replace #1# in the description with this value
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand then
            for i = 1, #context.scoring_hand do
                local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                local this_card = context.scoring_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        this_card:flip()
                        play_sound('card1', percent)
                        this_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            SMODS.calculate_effect({ message = "Rank UP!", colour = G.C.ORANGE }, card)

            for i = 1, #context.scoring_hand do
                -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                assert(SMODS.modify_rank(context.scoring_hand[i], 1, true))
            end

            for i = 1, #context.scoring_hand do
                local percent = 0.85 + (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
                local this_card = context.scoring_hand[i]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        -- change sprite
                        this_card:set_sprites(nil, G.P_CARDS[this_card.config.card_key])
                        -- flip cards back over
                        this_card:flip()
                        play_sound('tarot2', percent, 0.6)
                        this_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.5)
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vremade_to_do')
            return {
                message = localize('k_reset')
            }
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vremade_to_do')
    end,
}
-- #endregion
