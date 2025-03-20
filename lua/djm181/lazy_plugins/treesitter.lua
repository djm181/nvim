local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require'nvim-treesitter.configs'.setup {
          -- A list of parser names, or "all" (the listed parsers MUST always be installed)
          ensure_installed = { "c", "javascript", "typescript", "ruby", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          indent = {
            enable = true
          },
          highlight = {
            enable = true,

            additional_vim_regex_highlighting = false,
          },
        }
    end,
}

return { M }
