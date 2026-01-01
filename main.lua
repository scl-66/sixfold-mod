-- joker spritesheet
SMODS.Atlas {
    key = 'sxfjokeratlas',
    path = 'SXFJokers.png',
    px = 71,
    py = 95
}

assert(SMODS.load_file("jokers/common_jokers.lua"))()
assert(SMODS.load_file("jokers/uncommon_jokers.lua"))()
assert(SMODS.load_file("jokers/rare_jokers.lua"))()

local function perform_checks(table1, op, table2, mod)
    for k, v in pairs(table1) do
        for kk, vv in pairs(table2) do
            if op == "==" and v == vv then return true end
            if op == "~=" and v ~= vv then return true end
            if op == ">" and v > vv then return true end
            if op == ">=" and v >= vv then return true end
            if op == "<" and v < vv then return true end
            if op == "<=" and v <= vv then return true end
            if op == "mod" and v % vv == mod then return true end
            if type(op) == "function" and op(v, vv) then return true end
        end
    end
    return false
end

-- #region change Wild Card description localization when Mr. Rorschach is in deck
SMODS.Enhancement:take_ownership("wild", {
    loc_vars = function(self, info_queue, card)
        if next(SMODS.find_card("j_sxf_mr_rorschach")) then
            return { key = "m_wild_rank" }
        end
    end
})
-- #endregion

-- #region if Mr. Rorschach is in deck, Wild Cards are considered face cards
local is_face_ref = Card.is_face
function Card:is_face(from_boss)
    local ret = is_face_ref(self, from_boss)

    if self.ability.effect == 'Wild Card' and next(SMODS.find_card('j_sxf_mr_rorschach')) then
        return true
    end
    return ret
end

-- #endregion

-- #region if Mr. Rorschach is in deck, add all ranks to Wild Card rank table
local ids_op_ref = ids_op
function ids_op(card, op, b, c)
    local id = card:get_id()
    if not id then return false end
    local other_results = false
    if ids_op_ref ~= nil then
        other_results = ids_op_ref(card, op, b, c)
    end

    local ids = {}
    if SMODS.has_enhancement(card, 'm_wild') and not card.debuff and next(SMODS.find_card('j_sxf_mr_rorschach')) then
        for k, v in pairs(SMODS.Ranks) do
            table.insert(ids, v.id)
        end
    else
        table.insert(ids, id)
    end

    local function alias(x)
        if SMODS.has_enhancement(card, 'm_wild') and not card.debuff and next(SMODS.find_card('j_sxf_mr_rorschach')) then
            return
            '11'
        end
        return x
    end

    if other_results == true then
        return true
    end

    if op == "mod" then
        return perform_checks(ids, "mod", { b }, c)
    end

    if op == "==" then
        local lhs = alias(id)
        local rhs = alias(b)
        return lhs == rhs
    end
    if op == "~=" then
        local lhs = alias(id)
        local rhs = alias(b)
        return lhs ~= rhs
    end

    if op == ">=" then return perform_checks(ids, ">=", { b }) end
    if op == "<=" then return perform_checks(ids, "<=", { b }) end
    if op == ">" then return perform_checks(ids, ">", { b }) end
    if op == "<" then return perform_checks(ids, "<", { b }) end

    error("ids_op: unsupported op " .. tostring(op))
end

local insert_repetitions_ref = SMODS.insert_repetitions
function SMODS.insert_repetitions(ret, eval, effect_card, _type)
    local retu = insert_repetitions_ref(ret, eval, effect_card, _type)
    G.GAME.sxf_retriggered_value = effect_card:get_chip_bonus()
    return retu
end

-- #endregion

-- #region go through G.jokers.cards to check what jokers are left of eldritch_joker
check_jokers_left_of_eldritch = function ()
    if next(SMODS.find_card('j_sxf_eldritch_joker')) then
        for i, v in ipairs(G.jokers.cards) do
            if v.config.center.key == 'j_sxf_eldritch_joker' then
                if i > 1 then
                    G.GAME.sxf_sacrificed_joker_count = i - 1
                    for j = 1, i - 1 do
                        SMODS.debuff_card(G.jokers.cards[j], true, 'j_sxf_eldritch_joker')
                    end
                end
                if i < #G.jokers.cards then
                    for k = i, #G.jokers.cards do
                        SMODS.debuff_card(G.jokers.cards[k], "prevent_debuff", 'j_sxf_eldritch_joker')
                    end
                end
                if i == 1 then
                    G.GAME.sxf_sacrificed_joker_count = 0
                end
            end
        end
    end
end
-- #endregion

-- #region call check_jokers_left_of_eldritch() when stop_drag() is called
local stop_drag_ref = Moveable.stop_drag
function Moveable:stop_drag()
    local ret = stop_drag_ref(self)
    check_jokers_left_of_eldritch()
    --[[
    for i = 1, #G.jokers.cards do
        -- debuff jokers to the left of eldritch_joker
        if G.jokers.cards[i] == card and i > 1 then
            G.GAME.sxf_sacrificed_joker_count = i - 1
            for j = 1, G.GAME.sxf_sacrificed_joker_count do
                SMODS.debuff_card(G.jokers.cards[j], true, 'j_sxf_eldritch_joker')
            end
            -- if eldritch_joker is only joker, set sacrificed_joker_count (multiplier) to 0
        elseif G.jokers.cards[i] == card and i == 1 then
            G.GAME.sxf_sacrificed_joker_count = 0
        end
        -- undebuff jokers to the right of eldritch_joker
        if i < #G.jokers.cards then
            for k = i, #G.jokers.cards do
                SMODS.debuff_card(G.jokers.cards[k], "prevent_debuff", 'j_sxf_eldritch_joker')
            end
        end
    end
    --]]
    return ret
end

-- #endregion
