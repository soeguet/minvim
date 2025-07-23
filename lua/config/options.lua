vim.api.nvim_create_user_command('Ex', 'Oil', {})

local opt = vim.opt

opt.secure = true
opt.exrc = true

opt.hlsearch = true -- Highlight search results
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search pattern contains uppercase letters
opt.incsearch = true -- Show search matches as you type
opt.wrap = false -- Disable line wrapping
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while editing
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Enable smart indentation
-- opt.paste = true :::: CAVE: das hier laesst einen im insert mode in telescope nicht zum item springen
opt.autoindent = true -- Copy indent from current line when starting a new line
opt.backup = false -- Disable backup files
opt.writebackup = false -- Disable backup files on write
opt.swapfile = false -- Disable swap files
opt.undofile = true -- Enable persistent undo
opt.undodir = vim.fn.stdpath("cache") .. "/undo" -- Directory for undo files
opt.scrolloff = 8 -- Minimum number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- Minimum number of screen columns to keep left and right of the cursor
opt.signcolumn = "yes" -- Always show the sign column
opt.cursorline = true -- Highlight the current line
opt.termguicolors = false -- Enable 24-bit RGB colors in the terminal
opt.splitbelow = true -- Open new horizontal splits below the current window
opt.splitright = true -- Open new vertical splits to the right of the current window
opt.laststatus = 3 -- Always show the status line
opt.showmode = false -- Disable showing the mode in the command line
opt.cmdheight = 1 -- Height of the command line
opt.updatetime = 300 -- Time in milliseconds to wait before triggering the CursorHold event
opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete
opt.mouse = "a" -- Enable mouse support in all modes
-- opt.clipboard += "unnamedplus" -- Use the system clipboard for all yank, delete, change and put operations
--
--     set clipboard+=unnamedplus

opt.clipboard = "unnamedplus" -- Use the system clipboard for all yank, delete, change and put operations
opt.iskeyword:append("-") -- Treat hyphenated words as a single word
opt.isfname:append("@-@") -- Allow '@' in file names
opt.isfname:append("#") -- Allow '#' in file names

-- clipboard
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    opt.clipboard = "unnamed" -- Use the default clipboard on Windows
end


-- [[ close some filetypes with <q> ]]
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'PlenaryTestPopup',
		'help',
		'lspinfo',
		'man',
		'notify',
		'qf',
		'query',
		'spectre_panel',
		'startuptime',
		'tsplayground',
		'neotest-output',
		'checkhealth',
		'neotest-summary',
		'neotest-output-panel',
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
	end,
})
