return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Step Out" },
      { "<S-F5>", function() require("dap").terminate() end, desc = "Terminate" },
      { "<C-F4>", function() require("dap").close() end, desc = "Close" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>ds", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
      { "<leader>dp", function() require("dap-python").test_class() end, desc = "Debug Python Class" },
      { "<leader>dP", function() require("dap-python").test_method() end, desc = "Debug Python Method" },
    },

    config = function()
      local dap, dapui = require("dap"), require("dapui")
      vim.fn.setenv("VIMDAP_LOG", "1")
      dap.set_log_level("TRACE")
      dapui.setup({
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "*"
        },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⤵️",
            step_over = "↯",
            step_out = "⤴",
            step_back = "⬅️",
            run_last = "▷",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })
      -- Load `.env` file manually
      local function load_env()
        local env_file = vim.fn.getcwd() .. '/.env'
        local env_vars = {}
        local file = io.open(env_file, "r")
	print("loading env file: " .. env_file)
        if file then
            for line in file:lines() do
                -- Remove leading/trailing spaces
                line = line:gsub("^%s*(.-)%s*$", "%1")

                -- Ignore empty lines and comments (#)
                if line ~= "" and not line:match("^#") then
                    -- Capture key and value, allowing for any character in key
                    local key, value = line:match("^([^=]+)%s*=%s*(.*)$")

                    if key and value then
                        -- Remove surrounding quotes if present
                        value = value:gsub('^"(.-)"$', "%1"):gsub("^'(.-)'$", "%1")
                        env_vars[key] = value
                        vim.fn.setenv(key, value)  -- Set the environment variable
                    end
                end
            end
            file:close()
        else
            print("⚠️ Could not open .env file: " .. env_file)
        end
        return env_vars
      end

      local env_var = load_env()

      require("dap-python").setup()

      dap.configurations.python = {
        {
	  type = "python", 
          request = "launch",
          name = 'Launch with .env',
          program = '${file}',
          env = load_env(),
          pythonPath = function()
            return vim.fn.exepath('python')
          end,
        },
      }
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      --dap.listeners.before.event_terminated["dapui_config"] = function()
      --  dapui.close()
      --end
      --dap.listeners.before.event_exited["dapui_config"] = function()
      --  dapui.close()
      --end
    end,
  }
}
