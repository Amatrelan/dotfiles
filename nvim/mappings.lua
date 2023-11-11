local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>"},
    ["kj"] = { "<ESC>"},
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

M.neogit = {
  n = {
    ["<leader>gg"] = {
      function ()
        require("neogit").open()
      end,
      "NeoGIT"
    }
  }
}

return M
