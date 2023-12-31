return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
  },
  config = function()
    require("telescope").setup({

    })

    -- Load fzf
    require("telescope").load_extension("fzf")

    local map = require("utils.keys").map
    map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
    map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
    map("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, "Search in current buffer")

    map("n", "<leader>sf", require("telescope.builtin").find_files, "Files")
    map("n", "<leader>sh", require("telescope.builtin").help_tags, "Help")
    map("n", "<leader>sw", require("telescope.builtin").grep_string, "Current word")
    map("n", "<leader>sg", require("telescope.builtin").live_grep, "Grep")
    map("n", "<leader>sd", require("telescope.builtin").diagnostics, "Diagnostics")

    map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keymaps")

  end,
}
