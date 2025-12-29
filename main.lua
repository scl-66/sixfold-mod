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

-- change Wild Card description localization when Mr. Rorschach is in deck
SMODS.Enhancement:take_ownership("wild", {
    loc_vars = function(self, info_queue, card)
        if next(SMODS.find_card("j_sxf_mr_rorschach")) then
            return { key = "m_wild_rank" }
        end
    end
})

-- if Mr. Rorschach is in deck, Wild Cards are considered face cards
local is_face_ref = Card.is_face
function Card:is_face(from_boss)
    local ret = is_face_ref(self, from_boss)

    if self.ability.effect == 'Wild Card' and next(SMODS.find_card('j_sxf_mr_rorschach')) then
        return true
    end
    return ret
end

-- if Mr. Rorschach is in deck, add all ranks to Wild Card rank table
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