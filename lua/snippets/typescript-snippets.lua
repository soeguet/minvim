local luasnip = require('luasnip')
local snippet = luasnip.snippet
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local choice_node = luasnip.choice_node
local snippet_node = luasnip.snippet_node
local function_node = luasnip.function_node
local dynamic_node = luasnip.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local postfix = require('luasnip.extras.postfix').postfix

local function copy_node(args, parent, user_args)
	return args[1][1]
end

local function copy_node_suffix(args, parent, user_args)
	return args[1][1] .. user_args
end

local return_filename = function()
	local filename = vim.fn.fnamemodify(vim.fn.expand('%'), ':t')
	local basename = filename:match('([^%.]+)')
	return basename
end

local return_filename_full = function()
	return vim.fn.fnamemodify(vim.fn.expand('%'), ':t')
end

-- down below is where the snippets are added to the filetypes
local custom_snippets = {
	snippet(
		'.zustand_store',
		fmt(
			[[
            import {{ StoreApi, UseBoundStore, create }} from "zustand";

            type {three} = {{
                count: number;
                inc: () => void;
            }};

            const {one}: UseBoundStore<StoreApi<{three}>> = create<{three}>((set) => ({{
                count: 1,{zero}
                inc: () => set((state) => ({{ count: state.count + 1 }})),
            }}));

            export {{{two}}};
            ]],
			{
				one = insert_node(1, 'useStore'),
				two = function_node(copy_node, { 1 }, nil),
				three = function_node(copy_node_suffix, { 1 }, { user_args = { 'Type' } }),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.tsx_function',
		fmt(
			[[
				function {one}() {{

					return (
						<>
							{zero}
						</>
					);
				}}

				export {{{two}}};
            ]],
			{
				-- one = insert_node(1, 'Component'),
				one = function_node(return_filename, {}),
				two = function_node(return_filename, {}),
				-- two = function_node(copy_node, { 1 }, nil),
				zero = insert_node(0, ''),
			}
		)
	),


	snippet(
		'.tsx_function_svg_i18n',
		fmt(
			[[
				import {{ useTranslation }} from "react-i18next";

				function {one}() {{
					const {{ t }} = useTranslation();
					return (
						<>
							{zero}
						</>
					);
				}}

				export {{{two}}};
            ]],
			{
				-- one = insert_node(1, 'Component'),
				one = function_node(return_filename, {}),
				two = function_node(return_filename, {}),
				-- two = function_node(copy_node, { 1 }, nil),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.tsx_return',
		fmt(
			[[
                return (
                    <>
                        {zero}
                    </>
                );
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.type',
		fmt(
			[[
                type {one}Props = {{
                    {zero}
                }};
            ]],
			{
				-- one = insert_node(1, 'TypeName'),
				one = function_node(return_filename, {}),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.describe_bun:test',
		fmt(
			[[
            import {{ expect, test, describe }} from "bun:test";

            describe("{one}", () => {{

                test("{two}", () => {{
                    {zero}
                }});
            }});
        ]],
			{
				one = insert_node(1, 'description'),
				two = insert_node(2, 'test description'),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.describe_vitest:test',
		fmt(
			[[
            import {{ expect, test, describe }} from "vitest";

            describe("{one}", () => {{

                test("{two}", () => {{
                    {zero}
                }});
            }});
        ]],
			{
				-- one = insert_node(1, 'description'),
				one = function_node(return_filename, {}),
				two = insert_node(2, 'test description'),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.test_async',
		fmt(
			[[
				test("{one}", async() => {{
					{zero}
				}});
            ]],
			{
				-- one = insert_node(1, 'test description'),
				one = function_node(return_filename, {}),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.test_normal',
		fmt(
			[[
				test("{one}", () => {{
					{zero}
				}});
            ]],
			{
				one = insert_node(1, 'test description'),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.debounce_function',
		fmt(
			[[
				// eslint-disable-next-line @typescript-eslint/no-explicit-any
				export function debounce<F extends (...args: any[]) => void>(
					func: F,
					waitFor: number,
				) {{
					let timeoutId: number | undefined;

					return function (this: ThisParameterType<F>, ...args: Parameters<F>) {{
						clearTimeout(timeoutId);
						timeoutId = window.setTimeout(() => func.apply(this, args), waitFor);
					}} as F;
				}}
				{zero}
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.div',
		fmt(
			[[
			<div>{zero}</div>
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.a',
		fmt(
			[[
			<a>{zero}</a>
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.p',
		fmt(
			[[
			<p>{zero}</p>
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.fragment',
		fmt(
			[[
			<>{zero}</>
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.div - multi',
		fmt(
			[[
			<div>
				{zero}
			</div>
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.() => {}',
		fmt(
			[[
				() => {{
					{zero}
				}}
            ]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.return(<></>)',
		fmt(
			[[
				return (
					<>
						{zero}
					</>
				);
			]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.className=""',
		fmt(
			[[
				className="{zero}"
			]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.style={{}}',
		fmt(
			[[
				style={{{{
					{zero}
				}}}}
			]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.onChange={() => {}}',

		fmt(
			[[
				onChange={{() => {{
					{zero}
				}}}}
			]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.onClick={() => {}}',

		fmt(
			[[
				onClick={{() => {{
					{zero}
				}}}}
			]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.render(</>);',

		fmt(
			[[
				render(<{zero}/>);
			]],
			{
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.render(</>); + filename',

		fmt(
			[[
				render(<{one}/>);{zero}
			]],
			{
				one = function_node(return_filename, {}),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.expect().;',

		fmt(
			[[
				expect({one}).{two}
				{zero}
			]],
			{
				zero = insert_node(0, ''),
				one = insert_node(1, ''),
				two = choice_node(2, {
					text_node(''),
					text_node('toBeInTheDocument();'),
					text_node('not.toBeInTheDocument();'),
					text_node('toBeNull();'),
					text_node('not.toBeNull();'),
					text_node('toBe();'),
					text_node('toEqual();'),
				}),
			}
		)
	),

	snippet(
		'.filename_full',

		fmt(
			[[
				{one}{zero}
			]],
			{
				one = function_node(return_filename_full, {}),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.filename_no_ext',

		fmt(
			[[
				{one}{zero}
			]],
			{
				one = function_node(return_filename, {}),
				zero = insert_node(0, ''),
			}
		)
	),

	snippet(
		'.storybook - component file',

		fmt(
			[[
				
				import {{ {one} }} from "./{two}";

				export default {{
					component: {three},
				}};

				export const Default = {{
					args: {{
						label: "{zero}",
						primary: true,
					}},
				}};
			]],
			{
				one = function_node(return_filename, {}),
				two = function_node(return_filename, {}),
				three = function_node(return_filename, {}),
				zero = insert_node(0, ''),
			}
		)
	),
	postfix('.log [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(1,
				fmt(
					"console.log('{one}', {two});",
					{
						one = parent.snippet.env.POSTFIX_MATCH,
						two = parent.snippet.env.POSTFIX_MATCH,
					}
				)
			)
		end)
	}),
	postfix('.clg [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(1,
				fmt(
					"console.log('{one}', {two});",
					{
						one = parent.snippet.env.POSTFIX_MATCH,
						two = parent.snippet.env.POSTFIX_MATCH,
					}
				)
			)
		end)
	}),
	postfix('.const [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						const {} = {};
					]],
					{
						parent.snippet.env.POSTFIX_MATCH,
						insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.let [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						let {} = {};
					]],
					{
						parent.snippet.env.POSTFIX_MATCH,
						insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.const [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						const {} = {};
					]],
					{
						parent.snippet.env.POSTFIX_MATCH,
						insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.null/undefined (==) [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						if ({} == null) {{
							{}
						}};
					]],
					{
						parent.snippet.env.POSTFIX_MATCH,
						insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.null/explicit (===) [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						if ({} ===) null) {{
							{}
						}};
					]],
					{
						parent.snippet.env.POSTFIX_MATCH,
						insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.if [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						if ({}) {{
							{}
						}};
					]],
					{
						parent.snippet.env.POSTFIX_MATCH,
						insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.nnull [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						if (!{}) {{
							{}
						}};
					]],
					{
						parent.snippet.env.POSTFIX_MATCH,
						insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.try [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						let {one};
						try {{
							{two} = {zero};
						}} catch (error) {{
							console.error("Error in {three}", error);
						}}
					]],
					{

						one = parent.snippet.env.POSTFIX_MATCH,
						two = parent.snippet.env.POSTFIX_MATCH,
						three = return_filename(),
						zero = insert_node(1, '')
					}
				)
			)
		end)
	}),
	postfix('.expression (${...}) [postfix] (js/ts)', {
		dynamic_node(1, function(_, parent)
			return snippet_node(nil,
				fmt(
					[[
						${{{one}}}{zero}
					]],
					{
						one = parent.snippet.env.POSTFIX_MATCH,
						zero = insert_node(1, '')
					}
				)
			)
		end)
	}),
}

-- luasnip.add_snippets('typescript', custom_snippets)
