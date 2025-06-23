local luasnip = require("luasnip")
local snippet = luasnip.snippet
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local choice_node = luasnip.choice_node
local snippet_node = luasnip.snippet_node
local function_node = luasnip.function_node
local dynamic_node = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local postfix = require("luasnip.extras.postfix").postfix

local function copy_node(args, parent, user_args)
    return args[1][1]
end

local function copy_node_suffix(args, parent, user_args)
    return args[1][1] .. user_args
end

local return_filename = function()
    local filename = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
    local basename = filename:match("([^%.]+)")
    return basename
end

local return_filename_full = function()
    return vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
end

-- down below is where the snippets are added to the filetypes
local custom_snippets = {

    snippet(
        "return - ((all))",
        fmt(
            [[
				return (
					<>
						{zero}
					</>
				);
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        "{|}",
        fmt(
            [[
				{{{zero}}}
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        "{|} - multiline",
        fmt(
            [[
				{{
					{zero}
				}}
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        "(|)",
        fmt(
            [[
				({zero})
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        "(|) - multiline",
        fmt(
            [[
				(
					{zero}
				)
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        "[|]",
        fmt(
            [[
				[{zero}]
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        "[|] - multiline",
        fmt(
            [[
				[
					{zero}
				]
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        '"|"',
        fmt(
            [[
				"{zero}"
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    snippet(
        '"|" - multiline',
        fmt(
            [[
				"
					{zero}
				"
			]],
            {
                zero = insert_node(1, ""),
            }
        )
    ),

    postfix("-par ((...)) [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("({one})", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                })
            )
        end),
    }),

    postfix("..() [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("({one})", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                })
            )
        end),
    }),

    postfix("-brace ({...}) [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("{{{one}}}", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                })
            )
        end),
    }),

    postfix("..{} [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("{{{one}}}", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                })
            )
        end),
    }),

    postfix("-braket ([...]) [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("[{one}]", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                })
            )
        end),
    }),

    postfix("..[] [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("[{one}]", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                })
            )
        end),
    }),

    postfix("..<> [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("<{one}>{zero}</{two}>", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                    two = parent.snippet.env.POSTFIX_MATCH,
                    zero = insert_node(1, ""),
                })
            )
        end),
    }),

    postfix("-tag [postfix] - ((all))", {
        dynamic_node(1, function(_, parent)
            return snippet_node(
                1,
                fmt("<{one}>{zero}</{two}>", {
                    one = parent.snippet.env.POSTFIX_MATCH,
                    two = parent.snippet.env.POSTFIX_MATCH,
                    zero = insert_node(1, ""),
                })
            )
        end),
    }),
}

luasnip.add_snippets("all", custom_snippets)
