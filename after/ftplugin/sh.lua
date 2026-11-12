local dap = require("dap")

for _, config in ipairs(dap.configurations.sh or {}) do
  if config.type == "bash" and config.request == "launch" then
    config.env = config.env or {}
    config.env.BASH_DEBUG = "1"
  end
end
