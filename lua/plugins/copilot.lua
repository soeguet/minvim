return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				trigger_on_accept = true,
				keymap = {
					accept = "<TAB>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
		})

        vim.api.nvim_set_hl(0, "CopilotSuggestion", {
            fg = "#ff6961",
            bg = "#000000",
            blend = 30,
            undercurl = true,  -- Subtile Unterstreichung
            sp = "#665c54"     -- Farbe der Unterstreichung

        })
	end,
}
