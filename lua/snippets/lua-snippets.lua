local luasnip = require('luasnip')
local fmt = require('luasnip.extras.fmt').fmt
local snippet = luasnip.snippet
local snippet_node = luasnip.snippet_node
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local choice_node = luasnip.choice_node

luasnip.add_snippets('all', {
	snippet('ternary', {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		insert_node(1, 'cond'),
		text_node(' ? '),
		insert_node(2, 'then'),
		text_node(' : '),
		insert_node(3, 'else'),
	}),

	snippet(
		'reutrn',
		fmt(
			[[
				return{zero}
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'reutnr',
		fmt(
			[[
				return{zero}
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'keymap',
		fmt(
			[[
				vim.keymap.set({one}, {two}, {three}, {{desc='{four}'}}){zero}
            ]],
			{
				one = choice_node(1, {
					text_node("'n'"),
					text_node("{'n','v'}"),
					text_node("{'n','i'}"),
					text_node("{'v','i'}"),
				}),
				two = choice_node(2, {
					snippet_node(nil, { text_node("'<leader>"), insert_node(1), text_node("'") }),
					snippet_node(nil, { text_node("'"), insert_node(1), text_node("'") }),
				}),
				three = choice_node(3, {
					snippet_node(nil, { text_node("'<cmd>"), insert_node(1), text_node("<cr>'") }),
					snippet_node(nil, { text_node("'"), insert_node(1), text_node("'") }),
				}),
				four = insert_node(4, ''),
				zero = insert_node(0, ''),
			}
		)
	),
})
