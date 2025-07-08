return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
        local jdtls = require("jdtls")
        local jdtls_utils = require("jdtls.setup")

        local root_dir = jdtls_utils.find_root({ ".git" })
        if not root_dir then
        return
        end

        jdtls.start_or_attach({
        cmd = { "jdtls" },
        root_dir = root_dir,
        settings = {
            java = {
            format = {
                enabled = true,
            },
            },
        },
        })
    end,

}