local cmp = require("cmp")

local Plugins = {
  -- Added , here. I use it as localleader
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g", "," },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      -- require("custom.configs.lspconfig") -- No custom yet
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require("custom.configs.rust-tools")
    end,
    config = function (_, opts)
      require("rust-tools").setup(opts)
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      cmp.setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui"
    },

    config = function ()
      require("custom.configs.nvim-dap")
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require("plugins.configs.cmp")
      M.completion.completeopt = "menu,menuone,noselect"
      M.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "NeogitOrg/neogit",
    keys = { "<leader>gg" },
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = function ()
      require("neogit").setup()
      require("core.utils").load_mappings("neogit")
    end,
  }
}

return Plugins
