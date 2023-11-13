local M = {}

M.disabled = {
  n = {
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
    ["<leader>fm"] = "",
  }
}

M.general = {
  i = {
    ["jk"] = { "<ESC>" },
    ["kj"] = { "<ESC>" },
  },
  n = {
    ["<leader> "] = {
      "<cmd> Telecope buffers <cr>",
      "Find Buffers"
    },
    ["<localleader>f"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting"
    },
    ["<C-h"] = { "<cmd>TmuxNavigateLeft<cr>", "Tmux Left" },
    ["<C-j"] = { "<cmd>TmuxNavigateDown<cr>", "Tmux Down" },
    ["<C-k"] = { "<cmd>TmuxNavigateUp<cr>", "Tmux Up" },
    ["<C-l"] = { "<cmd>TmuxNavigateRight<cr>", "Tmux Right" },
  }
}

---@type NvKeymapOpts
M.crates = {
  plugin = true,

  n = {
    ["<localleader>u"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "Update crates"
    }
  }
}

M.general = {
  n = {
    ["<localleader>f"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting"
    }
  }
}

M.lspconfig = {
  plugin = true,

  n = {
    ["<localleader>a"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "Code Action"
    },
    ["cd"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["<localleader>d"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Floating diagnostic",
    }
  }
}

M.dap = {
  plugin = true,

  n = {
    ["<F1>"] = { function()
      require("dap").step_into()
    end,
      "DAP: Step Into"
    },
    ["<F2>"] = { function()
      require("dap").step_over()
    end,
      "DAP: Step Over"
    },
    ["<F3>"] = { function()
      require("dap").step_out()
    end,
      "DAP: Step Out"
    },
    ["<F5>"] = { function()
      require("dap").step_out()
    end,
      "DAP: Continue"
    },
    ["<leader>db"] = { function()
      require("dap").toggle_breakpoint()
    end,
      "DAP: Toggle Breakpoint"
    },
  }
}

M.dap_python = {
  plugin = true,

  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
    }
  }
}

M.neogit = {
  n = {
    ["<leader>gg"] = {
      function()
        require("neogit").open()
      end,
      "NeoGIT"
    }
  }
}

return M
