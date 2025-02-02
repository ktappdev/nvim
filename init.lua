-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd.colorscheme("rose-pine")

vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = function(lines)
      local data = table.concat(lines, "\n")
      local encoded = vim.fn.system("base64", data):gsub("\n", "")
      local seq = string.format("\x1b]52;c;%s\x07", encoded)
      vim.fn.chansend(vim.v.stderr, seq)
    end,
  },
  paste = {
    ["+"] = function()
      return {}
    end,
  },
}
