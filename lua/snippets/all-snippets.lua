local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

-- dynamic node
-- generally, postfix comes in the form PRE-CAPTURE-POST, so in this case, arg1 is the "pre" text, arg2 the "post" text
local dynamic_postfix = function(_, parent, _, user_arg1, user_arg2)
    local capture = parent.snippet.env.POSTFIX_MATCH
    if #capture > 0 then
        return sn(nil, fmta([[
        <><><><>
        ]],
            { t(user_arg1), t(capture), t(user_arg2), i(0) }))
    else
        local visual_placeholder = ""
        if #parent.snippet.env.SELECT_RAW > 0 then
            visual_placeholder = parent.snippet.env.SELECT_RAW
        end
        return sn(nil, fmta([[
        <><><><>
        ]],
            { t(user_arg1), i(1, visual_placeholder), t(user_arg2), i(0) }))
    end
end



ls.add_snippets("all", {

    postfix({
        trig = '.var',
        match_pattern = '[%w%.%_%-%(%)]%+$',
    }, {
        d(1, function(_, parent)
            return sn(
                1,
                fmt('local {} = ' .. parent.snippet.env.POSTFIX_MATCH, {
                    i(1, 'name'),
                })
            )
        end),
    }),


    -- this is working 2025.07.13, but it's rust :D
    postfix({ trig = "vec", match_pattern = [[[%w%.%_%-%"%']*$]] },
        { d(1, dynamic_postfix, {}, { user_args = { "\\vec{", "}" } }) },
        { condition = require("luasnip.util.util").yes }
    ),
    postfix(".br", {
        f(function(_, parent)
            return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
        end, {}),
    }),
    postfix(".bs", {
        f(function(_, parent)
            return "{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
        end, {}),
    }),
    postfix(".par", {
        f(function(_, parent)
            return "(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
        end, {}),
    }),
    postfix({
        trig = ".bar", -- akzeptiert .ba, .bar, .be, .ber
    }, {
        d(1, function(_, parent)
            local matched = parent.snippet.env.POSTFIX_MATCH
            print('matched',matched)
            return sn(
                nil,
                fmt("({})", { t({ matched }) })
            )
        end),
    }),
    postfix(".brd", {
        d(1, function(_, parent)
            return sn(nil, { t("[" .. parent.env.POSTFIX_MATCH .. "]") })
        end)
    }),
    s({ trig = "testing" }, {
        t("This is a test snippet for testing purposes."),
        i(0, "You can type here after expanding the snippet."),
    }),
    postfix({
        trig = ".append2",
    }, {
        d(1, function(_, parent)
            local matched = parent.snippet.env.POSTFIX_MATCH
            print('matched', matched)
            return sn(
                nil,
                fmt("{} = append({}, {})", { t({ matched }), rep(1), i(1) })
            )
        end),
    }),
    postfix(
        {
            trig = '.mt',
            name = 'Create a method',
        },
        fmta(
            [[
        func (<re> <pointer><type_name>) <name>(<args>)<return_type> {
            <body>
        }<cursor>
      ]],
            {
                re = d(1, function(_, parent)
                    local match = parent.env.POSTFIX_MATCH
                    local initials = match:gsub('^%l', string.upper):gsub('(%l)', ''):lower()
                    return s('', { i(1, initials) })
                end),
                pointer = c(2, { t '*', t '' }),
                type_name = d(3, function(_, parent) return s('', { i(1, parent.env.POSTFIX_MATCH) }) end),
                name = i(4),
                args = i(5),
                return_type = d(6, function()
                    return s('', {
                        f(function(args)
                            if args[1][1]:match '[^( ] [^ )]' or args[1][1]:match ',' then
                                return ' ('
                            elseif #args[1][1] > 0 then
                                return ' '
                            else
                                return ''
                            end
                        end, { 1 }),
                        i(1),
                        f(function(args)
                            if args[1][1]:match '[^( ] [^ )]' or args[1][1]:match ',' then
                                return ')'
                            else
                                return ''
                            end
                        end, { 1 }),
                    })
                end),
                body = i(7),
                cursor = i(0),
            }
        )
    )
})
