local luasnip = require('luasnip')
local snippet = luasnip.snippet
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local choice_node = luasnip.choice_node
local function_node = luasnip.function_node
local fmt = require('luasnip.extras.fmt').fmt

luasnip.add_snippets('java', {

	snippet(
		'cf',
		fmt(
			[[
	{} {} {}({}) {{

		{}
		{}
	}}

	]],
			{

				choice_node(1, {
					text_node('private'),
					text_node('public'),
					text_node('protected'),
				}),
				choice_node(2, {
					text_node('void'),
					text_node('int'),
					text_node('String'),
					text_node('boolean'),
					text_node('long'),
				}),
				insert_node(3, 'name'),
				insert_node(4),
				insert_node(0),
				function_node(function(values)
					local val = values[1][1]

					if val == 'void' then
						return
					elseif val == 'int' or val == 'long' then
						return 'return 0;'
					elseif val == 'String' then
						return 'return "";'
					elseif val == 'boolean' then
						return 'return false;'
					end
				end, { 2 }),
			}
		)
	),
})
