return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "RRethy/vim-illuminate",
    },
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "angularls",
          "clangd",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "gopls",
          "golangci_lint_ls",
          "html",
          "jsonls",
          "jdtls",
          "lemminx",
          "quick_lint_js",
          "tsserver",
          "vtsls",
          "lua_ls",
          "pyright",
          "yamlls"
        },
        automatic_installation = true,
      })

      -- This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        local lsp_map = require("utils.keys").lsp_map

        lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
        lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
        lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
        lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

        lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
        lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
        lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
        lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
        lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "Format")

        -- Attach and configure vim-illuminate
        require("illuminate").on_attach(client)
      end

      -- Java LSP
      -- local config = {
      --   cmd = { "/opt/homebrew/Cellar/jdtls/1.25.0/bin/jdtls" },
      --   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      -- }
      -- require('jdtls').start_or_attach(config)
      -- require("lspconfig")["jdtls"].setup({
      --   on_attach = on_attach,
      -- })

      -- XML LSP
      require("lspconfig")["lemminx"].setup({
        on_attach = on_attach,
      })

      -- JavaScript LSP
      require("lspconfig")["quick_lint_js"].setup({
        on_attach = on_attach,
      })

      require 'lspconfig'.tsserver.setup({
        on_attach = on_attach,
      })

      -- Docker
      require("lspconfig")["dockerls"].setup({
        on_attach = on_attach,
      })

      -- Docker Compose
      require("lspconfig")["docker_compose_language_service"].setup({
        on_attach = on_attach,
      })

      -- Lua LSP
      require("lspconfig")["lua_ls"].setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              -- Get the language server to recognize the 'vim' global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              -- Don't send data
              enable = false,
            },
          },
        },
      })
    end,
  }
}
