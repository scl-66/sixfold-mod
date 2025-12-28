SMODS.Joker {
    key = "camera_shutter",
    atlas = "sxfjokeratlas",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 7,
    pos = { x = 6, y = 0 },
    loc_txt = {
            name = "Camera Shutter",
            text = {
                "Sell this card to create", 
                "a free {C:attention}Negative Tag{}"
            }
        },
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