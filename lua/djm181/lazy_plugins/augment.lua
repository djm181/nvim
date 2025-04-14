return {
  "augmentcode/augment.vim",
  config = function()
    local augment = require("augment")
    vim.keymap.set("i", "<C-y>", function()
      vim.fn['augment#Accept']()
    end)
  end,
}
