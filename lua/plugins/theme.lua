return {
    {
        "rebelot/kanagawa.nvim",
        opts = {
            compile = true,   -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = false },
            functionStyle = {},
            keywordStyle = { italic = false },
            statementStyle = { bold = false },
            typeStyle = {},
            transparent = false,   -- do not set background color
            dimInactive = true,    -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = {             -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors) -- add/modify highlights
                return {}
            end,
            theme = "wave",      -- Load "wave" theme
            background = {       -- map the value of 'background' option to a theme
                dark = "dragon", -- try "dragon" !
                light = "lotus"
            },
        }
    },
    {
        "scottmckendry/cyberdream.nvim",
        -- lazy = false,
        -- priority = 1000,
    },
    {
        "Mofiqul/vscode.nvim",
        -- lazy = false,
        -- priority = 1000,
        opts = {
            -- Alternatively set style in setup
            -- style = 'light'

            -- Enable transparent background
            transparent = false,

            -- Enable italic comment
            italic_comments = false,

            -- Underline `@markup.link.*` variants
            underline_links = true,

            -- Disable nvim-tree background color
            disable_nvimtree_bg = true,

            -- Apply theme colors to terminal
            terminal_colors = true,

            -- Override colors (see ./lua/vscode/colors.lua)
            -- color_overrides = {
            --     vscLineNumber = '#FFFFFF',
            --     vscNone = 'NONE',
            -- vscFront = '#D4D4D4',
            -- vscBack = '#1F1F1F',
            --
            -- vscTabCurrent = '#1F1F1F',
            -- vscTabOther = '#2D2D2D',
            -- vscTabOutside = '#252526',
            --
            -- vscLeftDark = '#252526',
            -- vscLeftMid = '#373737',
            -- vscLeftLight = '#636369',
            --
            -- vscPopupFront = '#BBBBBB',
            -- vscPopupBack = '#202020',
            -- vscPopupHighlightBlue = '#04395E',
            -- vscPopupHighlightGray = '#343B41',
            --
            -- vscSplitLight = '#898989',
            -- vscSplitDark = '#444444',
            -- vscSplitThumb = '#424242',
            --
            -- vscCursorDarkDark = '#222222',
            -- vscCursorDark = '#51504F',
            -- vscCursorLight = '#AEAFAD',
            -- vscSelection = '#264F78',
            -- vscLineNumber = '#5A5A5A',
            --
            -- vscDiffRedDark = '#4B1818',
            -- vscDiffRedLight = '#6F1313',
            -- vscDiffRedLightLight = '#FB0101',
            -- vscDiffGreenDark = '#373D29',
            -- vscDiffGreenLight = '#4B5632',
            -- vscSearchCurrent = '#515c6a',
            -- vscSearch = '#613315',
            --
            -- vscGitAdded = '#81b88b',
            -- vscGitModified = '#e2c08d',
            -- vscGitDeleted = '#c74e39',
            -- vscGitRenamed = '#73c991',
            -- vscGitUntracked = '#73c991',
            -- vscGitIgnored = '#8c8c8c',
            -- vscGitStageModified = '#e2c08d',
            -- vscGitStageDeleted = '#c74e39',
            -- vscGitConflicting = '#e4676b',
            -- vscGitSubmodule = '#8db9e2',
            --
            -- vscContext = '#404040',
            -- vscContextCurrent = '#707070',
            --
            -- vscFoldBackground = '#202d39',
            --
            -- vscSuggestion = '#6A6A6A',
            --
            -- -- Syntax colors
            -- vscGray = '#808080',
            -- vscViolet = '#646695',
            -- vscBlue = '#569CD6',
            -- vscAccentBlue = '#4FC1FF',
            -- vscDarkBlue = '#223E55',
            -- vscMediumBlue = '#18a2fe',
            -- vscDisabledBlue = '#729DB3',
            -- vscLightBlue = '#9CDCFE',
            -- vscGreen = '#6A9955',
            -- vscBlueGreen = '#4EC9B0',
            -- vscLightGreen = '#B5CEA8',
            -- vscRed = '#F44747',
            -- vscOrange = '#CE9178',
            -- vscLightRed = '#D16969',
            -- vscYellowOrange = '#D7BA7D',
            -- vscYellow = '#DCDCAA',
            -- vscDarkYellow = '#FFD602',
            -- vscPink = '#C586C0',
            --
            -- -- Low contrast with default background
            -- vscDimHighlight = '#51504F',
            -- },

            -- Override highlight groups (see ./lua/vscode/theme.lua)
            -- group_overrides = {
            --     -- this supports the same val table as vim.api.nvim_set_hl
            --     -- use colors from this colorscheme by requiring vscode.colors!
            --     Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
            -- }
        }
    },
    {
        "vague2k/vague.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = false,
            bold = false,
            italic = false,
        },
        config = function(_, opts)
            require("vague").setup(opts)
        end
    },
    {
        "webhooked/kanso.nvim",
        lazy = false,
        priority = 1000,
    }
}
